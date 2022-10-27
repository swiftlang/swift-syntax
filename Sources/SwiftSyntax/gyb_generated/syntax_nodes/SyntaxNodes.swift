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


// MARK: - MissingSyntax

public struct MissingSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missing else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missing)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.missing,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    default:
      fatalError("Invalid index")
    }
  }
}

extension MissingSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - CodeBlockItemSyntax

/// 
/// A CodeBlockItem is any Syntax node that appears on its own line inside
/// a CodeBlock.
/// 
public struct CodeBlockItemSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Item: SyntaxChildChoices {
    case `decl`(DeclSyntax)
    case `stmt`(StmtSyntax)
    case `expr`(ExprSyntax)
    case `tokenList`(TokenListSyntax)
    case `nonEmptyTokenList`(NonEmptyTokenListSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .decl(let node): return node._syntaxNode
      case .stmt(let node): return node._syntaxNode
      case .expr(let node): return node._syntaxNode
      case .tokenList(let node): return node._syntaxNode
      case .nonEmptyTokenList(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init<Node: DeclSyntaxProtocol>(_ node: Node) {
      self = .decl(DeclSyntax(node))
    }
    public init<Node: StmtSyntaxProtocol>(_ node: Node) {
      self = .stmt(StmtSyntax(node))
    }
    public init<Node: ExprSyntaxProtocol>(_ node: Node) {
      self = .expr(ExprSyntax(node))
    }
    public init(_ node: TokenListSyntax) {
      self = .tokenList(node)
    }
    public init(_ node: NonEmptyTokenListSyntax) {
      self = .nonEmptyTokenList(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(DeclSyntax.self) {
        self = .decl(node)
        return
      }
      if let node = syntaxNode.as(StmtSyntax.self) {
        self = .stmt(node)
        return
      }
      if let node = syntaxNode.as(ExprSyntax.self) {
        self = .expr(node)
        return
      }
      if let node = syntaxNode.as(TokenListSyntax.self) {
        self = .tokenList(node)
        return
      }
      if let node = syntaxNode.as(NonEmptyTokenListSyntax.self) {
        self = .nonEmptyTokenList(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(DeclSyntax.self),
        .node(StmtSyntax.self),
        .node(ExprSyntax.self),
        .node(TokenListSyntax.self),
        .node(NonEmptyTokenListSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeItem: UnexpectedNodesSyntax? = nil,
    item: Item,
    _ unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax?,
    _ unexpectedBetweenSemicolonAndErrorTokens: UnexpectedNodesSyntax? = nil,
    errorTokens: Syntax?,
    _ unexpectedAfterErrorTokens: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeItem?.raw,
      item.raw,
      unexpectedBetweenItemAndSemicolon?.raw,
      semicolon?.raw,
      unexpectedBetweenSemicolonAndErrorTokens?.raw,
      errorTokens?.raw,
      unexpectedAfterErrorTokens?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeItem: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeItem(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeItem` replaced.
  /// - param newChild: The new `unexpectedBeforeItem` to replace the node's
  ///                   current `unexpectedBeforeItem`, if present.
  public func withUnexpectedBeforeItem(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CodeBlockItemSyntax(newData)
  }

  /// The underlying node inside the code block.
  public var item: Item {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Item(childData!)
    }
    set(value) {
      self = withItem(value)
    }
  }

  /// Returns a copy of the receiver with its `item` replaced.
  /// - param newChild: The new `item` to replace the node's
  ///                   current `item`, if present.
  public func withItem(
    _ newChild: Item?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CodeBlockItemSyntax(newData)
  }

  public var unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenItemAndSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenItemAndSemicolon` replaced.
  /// - param newChild: The new `unexpectedBetweenItemAndSemicolon` to replace the node's
  ///                   current `unexpectedBetweenItemAndSemicolon`, if present.
  public func withUnexpectedBetweenItemAndSemicolon(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CodeBlockItemSyntax(newData)
  }

  /// 
  /// If present, the trailing semicolon at the end of the item.
  /// 
  public var semicolon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return CodeBlockItemSyntax(newData)
  }

  public var unexpectedBetweenSemicolonAndErrorTokens: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSemicolonAndErrorTokens(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSemicolonAndErrorTokens` replaced.
  /// - param newChild: The new `unexpectedBetweenSemicolonAndErrorTokens` to replace the node's
  ///                   current `unexpectedBetweenSemicolonAndErrorTokens`, if present.
  public func withUnexpectedBetweenSemicolonAndErrorTokens(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CodeBlockItemSyntax(newData)
  }

  public var errorTokens: Syntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return CodeBlockItemSyntax(newData)
  }

  public var unexpectedAfterErrorTokens: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterErrorTokens(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterErrorTokens` replaced.
  /// - param newChild: The new `unexpectedAfterErrorTokens` to replace the node's
  ///                   current `unexpectedAfterErrorTokens`, if present.
  public func withUnexpectedAfterErrorTokens(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CodeBlockItemSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeItem,
      \Self.item,
      \Self.unexpectedBetweenItemAndSemicolon,
      \Self.semicolon,
      \Self.unexpectedBetweenSemicolonAndErrorTokens,
      \Self.errorTokens,
      \Self.unexpectedAfterErrorTokens,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CodeBlockItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeItem": unexpectedBeforeItem.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "item": Syntax(item).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenItemAndSemicolon": unexpectedBetweenItemAndSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSemicolonAndErrorTokens": unexpectedBetweenSemicolonAndErrorTokens.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "errorTokens": errorTokens.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterErrorTokens": unexpectedAfterErrorTokens.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CodeBlockSyntax

public struct CodeBlockSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax,
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftBrace` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftBrace` to replace the node's
  ///                   current `unexpectedBeforeLeftBrace`, if present.
  public func withUnexpectedBeforeLeftBrace(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CodeBlockSyntax(newData)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CodeBlockSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBraceAndStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBraceAndStatements` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBraceAndStatements` to replace the node's
  ///                   current `unexpectedBetweenLeftBraceAndStatements`, if present.
  public func withUnexpectedBetweenLeftBraceAndStatements(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CodeBlockSyntax(newData)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return CodeBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return CodeBlockSyntax(newData)
  }

  public var unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenStatementsAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenStatementsAndRightBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenStatementsAndRightBrace` to replace the node's
  ///                   current `unexpectedBetweenStatementsAndRightBrace`, if present.
  public func withUnexpectedBetweenStatementsAndRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CodeBlockSyntax(newData)
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return CodeBlockSyntax(newData)
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightBrace` replaced.
  /// - param newChild: The new `unexpectedAfterRightBrace` to replace the node's
  ///                   current `unexpectedAfterRightBrace`, if present.
  public func withUnexpectedAfterRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CodeBlockSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftBrace,
      \Self.leftBrace,
      \Self.unexpectedBetweenLeftBraceAndStatements,
      \Self.statements,
      \Self.unexpectedBetweenStatementsAndRightBrace,
      \Self.rightBrace,
      \Self.unexpectedAfterRightBrace,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "statements"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CodeBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftBrace": unexpectedBeforeLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBraceAndStatements": unexpectedBetweenLeftBraceAndStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenStatementsAndRightBrace": unexpectedBetweenStatementsAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightBrace": unexpectedAfterRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameArgumentSyntax

public struct DeclNameArgumentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DeclNameArgumentSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DeclNameArgumentSyntax(newData)
  }

  public var unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndColon` to replace the node's
  ///                   current `unexpectedBetweenNameAndColon`, if present.
  public func withUnexpectedBetweenNameAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DeclNameArgumentSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DeclNameArgumentSyntax(newData)
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterColon` replaced.
  /// - param newChild: The new `unexpectedAfterColon` to replace the node's
  ///                   current `unexpectedAfterColon`, if present.
  public func withUnexpectedAfterColon(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DeclNameArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndColon,
      \Self.colon,
      \Self.unexpectedAfterColon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeclNameArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndColon": unexpectedBetweenNameAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterColon": unexpectedAfterColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameArgumentsSyntax

public struct DeclNameArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DeclNameArgumentsSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DeclNameArgumentsSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndArguments` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndArguments`, if present.
  public func withUnexpectedBetweenLeftParenAndArguments(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DeclNameArgumentsSyntax(newData)
  }

  public var arguments: DeclNameArgumentListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgumentList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return DeclNameArgumentsSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: DeclNameArgumentListSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.declNameArgumentList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DeclNameArgumentsSyntax(newData)
  }

  public var unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentsAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentsAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenArgumentsAndRightParen`, if present.
  public func withUnexpectedBetweenArgumentsAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DeclNameArgumentsSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DeclNameArgumentsSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DeclNameArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArguments,
      \Self.arguments,
      \Self.unexpectedBetweenArgumentsAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeclNameArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndArguments": unexpectedBetweenLeftParenAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentsAndRightParen": unexpectedBetweenArgumentsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleExprElementSyntax

public struct TupleExprElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax?,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TupleExprElementSyntax(newData)
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return TupleExprElementSyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TupleExprElementSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return TupleExprElementSyntax(newData)
  }

  public var unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndExpression` to replace the node's
  ///                   current `unexpectedBetweenColonAndExpression`, if present.
  public func withUnexpectedBetweenColonAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TupleExprElementSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return TupleExprElementSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndTrailingComma`, if present.
  public func withUnexpectedBetweenExpressionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return TupleExprElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return TupleExprElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return TupleExprElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndExpression,
      \Self.expression,
      \Self.unexpectedBetweenExpressionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "value"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TupleExprElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndExpression": unexpectedBetweenColonAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndTrailingComma": unexpectedBetweenExpressionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayElementSyntax

public struct ArrayElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ArrayElementSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ArrayElementSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndTrailingComma`, if present.
  public func withUnexpectedBetweenExpressionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ArrayElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ArrayElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ArrayElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeExpression,
      \Self.expression,
      \Self.unexpectedBetweenExpressionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "value"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ArrayElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndTrailingComma": unexpectedBetweenExpressionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryElementSyntax

public struct DictionaryElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? = nil,
    keyExpression: ExprSyntax,
    _ unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? = nil,
    valueExpression: ExprSyntax,
    _ unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeKeyExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeKeyExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeKeyExpression` to replace the node's
  ///                   current `unexpectedBeforeKeyExpression`, if present.
  public func withUnexpectedBeforeKeyExpression(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DictionaryElementSyntax(newData)
  }

  public var keyExpression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DictionaryElementSyntax(newData)
  }

  public var unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenKeyExpressionAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenKeyExpressionAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenKeyExpressionAndColon` to replace the node's
  ///                   current `unexpectedBetweenKeyExpressionAndColon`, if present.
  public func withUnexpectedBetweenKeyExpressionAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DictionaryElementSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DictionaryElementSyntax(newData)
  }

  public var unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndValueExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndValueExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndValueExpression` to replace the node's
  ///                   current `unexpectedBetweenColonAndValueExpression`, if present.
  public func withUnexpectedBetweenColonAndValueExpression(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DictionaryElementSyntax(newData)
  }

  public var valueExpression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DictionaryElementSyntax(newData)
  }

  public var unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenValueExpressionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenValueExpressionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenValueExpressionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenValueExpressionAndTrailingComma`, if present.
  public func withUnexpectedBetweenValueExpressionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DictionaryElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return DictionaryElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return DictionaryElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeKeyExpression,
      \Self.keyExpression,
      \Self.unexpectedBetweenKeyExpressionAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndValueExpression,
      \Self.valueExpression,
      \Self.unexpectedBetweenValueExpressionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "key"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "value"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DictionaryElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeKeyExpression": unexpectedBeforeKeyExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "keyExpression": Syntax(keyExpression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenKeyExpressionAndColon": unexpectedBetweenKeyExpressionAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndValueExpression": unexpectedBetweenColonAndValueExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valueExpression": Syntax(valueExpression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenValueExpressionAndTrailingComma": unexpectedBetweenValueExpressionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureItemSyntax

public struct ClosureCaptureItemSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: TokenListSyntax?,
    _ unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax?,
    _ unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? = nil,
    assignToken: TokenSyntax?,
    _ unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeSpecifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeSpecifier` replaced.
  /// - param newChild: The new `unexpectedBeforeSpecifier` to replace the node's
  ///                   current `unexpectedBeforeSpecifier`, if present.
  public func withUnexpectedBeforeSpecifier(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ClosureCaptureItemSyntax(newData)
  }

  public var specifier: TokenListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tokenList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return ClosureCaptureItemSyntax(newData)
  }

  /// Returns a copy of the receiver with its `specifier` replaced.
  /// - param newChild: The new `specifier` to replace the node's
  ///                   current `specifier`, if present.
  public func withSpecifier(
    _ newChild: TokenListSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 1)
    return ClosureCaptureItemSyntax(newData)
  }

  public var unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSpecifierAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSpecifierAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenSpecifierAndName` to replace the node's
  ///                   current `unexpectedBetweenSpecifierAndName`, if present.
  public func withUnexpectedBetweenSpecifierAndName(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ClosureCaptureItemSyntax(newData)
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ClosureCaptureItemSyntax(newData)
  }

  public var unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndAssignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndAssignToken` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndAssignToken` to replace the node's
  ///                   current `unexpectedBetweenNameAndAssignToken`, if present.
  public func withUnexpectedBetweenNameAndAssignToken(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ClosureCaptureItemSyntax(newData)
  }

  public var assignToken: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return ClosureCaptureItemSyntax(newData)
  }

  public var unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAssignTokenAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAssignTokenAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenAssignTokenAndExpression` to replace the node's
  ///                   current `unexpectedBetweenAssignTokenAndExpression`, if present.
  public func withUnexpectedBetweenAssignTokenAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ClosureCaptureItemSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return ClosureCaptureItemSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndTrailingComma`, if present.
  public func withUnexpectedBetweenExpressionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return ClosureCaptureItemSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return ClosureCaptureItemSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return ClosureCaptureItemSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSpecifier,
      \Self.specifier,
      \Self.unexpectedBetweenSpecifierAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndAssignToken,
      \Self.assignToken,
      \Self.unexpectedBetweenAssignTokenAndExpression,
      \Self.expression,
      \Self.unexpectedBetweenExpressionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ClosureCaptureItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSpecifier": unexpectedBeforeSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSpecifierAndName": unexpectedBetweenSpecifierAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenNameAndAssignToken": unexpectedBetweenNameAndAssignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignToken": assignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAssignTokenAndExpression": unexpectedBetweenAssignTokenAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndTrailingComma": unexpectedBetweenExpressionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureSignatureSyntax

public struct ClosureCaptureSignatureSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil,
    leftSquare: TokenSyntax,
    _ unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? = nil,
    items: ClosureCaptureItemListSyntax?,
    _ unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? = nil,
    rightSquare: TokenSyntax,
    _ unexpectedAfterRightSquare: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndItems?.raw,
      items?.raw,
      unexpectedBetweenItemsAndRightSquare?.raw,
      rightSquare.raw,
      unexpectedAfterRightSquare?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftSquare` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftSquare` to replace the node's
  ///                   current `unexpectedBeforeLeftSquare`, if present.
  public func withUnexpectedBeforeLeftSquare(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftSquareAndItems(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftSquareAndItems` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftSquareAndItems` to replace the node's
  ///                   current `unexpectedBetweenLeftSquareAndItems`, if present.
  public func withUnexpectedBetweenLeftSquareAndItems(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var items: ClosureCaptureItemListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return ClosureCaptureSignatureSyntax(newData)
  }

  /// Returns a copy of the receiver with its `items` replaced.
  /// - param newChild: The new `items` to replace the node's
  ///                   current `items`, if present.
  public func withItems(
    _ newChild: ClosureCaptureItemListSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenItemsAndRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenItemsAndRightSquare` replaced.
  /// - param newChild: The new `unexpectedBetweenItemsAndRightSquare` to replace the node's
  ///                   current `unexpectedBetweenItemsAndRightSquare`, if present.
  public func withUnexpectedBetweenItemsAndRightSquare(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var unexpectedAfterRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightSquare` replaced.
  /// - param newChild: The new `unexpectedAfterRightSquare` to replace the node's
  ///                   current `unexpectedAfterRightSquare`, if present.
  public func withUnexpectedAfterRightSquare(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftSquare,
      \Self.leftSquare,
      \Self.unexpectedBetweenLeftSquareAndItems,
      \Self.items,
      \Self.unexpectedBetweenItemsAndRightSquare,
      \Self.rightSquare,
      \Self.unexpectedAfterRightSquare,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ClosureCaptureSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftSquare": unexpectedBeforeLeftSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftSquareAndItems": unexpectedBetweenLeftSquareAndItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "items": items.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenItemsAndRightSquare": unexpectedBetweenItemsAndRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightSquare": unexpectedAfterRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureParamSyntax

public struct ClosureParamSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParam,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ClosureParamSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ClosureParamSyntax(newData)
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenNameAndTrailingComma`, if present.
  public func withUnexpectedBetweenNameAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ClosureParamSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ClosureParamSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ClosureParamSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ClosureParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndTrailingComma": unexpectedBetweenNameAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureSignatureSyntax

public struct ClosureSignatureSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Input: SyntaxChildChoices {
    case `simpleInput`(ClosureParamListSyntax)
    case `input`(ParameterClauseSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .simpleInput(let node): return node._syntaxNode
      case .input(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: ClosureParamListSyntax) {
      self = .simpleInput(node)
    }
    public init(_ node: ParameterClauseSyntax) {
      self = .input(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(ClosureParamListSyntax.self) {
        self = .simpleInput(node)
        return
      }
      if let node = syntaxNode.as(ParameterClauseSyntax.self) {
        self = .input(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(ClosureParamListSyntax.self),
        .node(ParameterClauseSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? = nil,
    capture: ClosureCaptureSignatureSyntax?,
    _ unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? = nil,
    input: Input?,
    _ unexpectedBetweenInputAndAsyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsTok: UnexpectedNodesSyntax? = nil,
    throwsTok: TokenSyntax?,
    _ unexpectedBetweenThrowsTokAndOutput: UnexpectedNodesSyntax? = nil,
    output: ReturnClauseSyntax?,
    _ unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? = nil,
    inTok: TokenSyntax,
    _ unexpectedAfterInTok: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ClosureSignatureSyntax(newData)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return ClosureSignatureSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 1)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributesAndCapture(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributesAndCapture` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributesAndCapture` to replace the node's
  ///                   current `unexpectedBetweenAttributesAndCapture`, if present.
  public func withUnexpectedBetweenAttributesAndCapture(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ClosureSignatureSyntax(newData)
  }

  public var capture: ClosureCaptureSignatureSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaptureAndInput(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaptureAndInput` replaced.
  /// - param newChild: The new `unexpectedBetweenCaptureAndInput` to replace the node's
  ///                   current `unexpectedBetweenCaptureAndInput`, if present.
  public func withUnexpectedBetweenCaptureAndInput(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ClosureSignatureSyntax(newData)
  }

  public var input: Input? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return Input(childData!)
    }
    set(value) {
      self = withInput(value)
    }
  }

  /// Returns a copy of the receiver with its `input` replaced.
  /// - param newChild: The new `input` to replace the node's
  ///                   current `input`, if present.
  public func withInput(
    _ newChild: Input?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenInputAndAsyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInputAndAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInputAndAsyncKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenInputAndAsyncKeyword` to replace the node's
  ///                   current `unexpectedBetweenInputAndAsyncKeyword`, if present.
  public func withUnexpectedBetweenInputAndAsyncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ClosureSignatureSyntax(newData)
  }

  public var asyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenAsyncKeywordAndThrowsTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsyncKeywordAndThrowsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsyncKeywordAndThrowsTok` replaced.
  /// - param newChild: The new `unexpectedBetweenAsyncKeywordAndThrowsTok` to replace the node's
  ///                   current `unexpectedBetweenAsyncKeywordAndThrowsTok`, if present.
  public func withUnexpectedBetweenAsyncKeywordAndThrowsTok(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return ClosureSignatureSyntax(newData)
  }

  public var throwsTok: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenThrowsTokAndOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenThrowsTokAndOutput(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenThrowsTokAndOutput` replaced.
  /// - param newChild: The new `unexpectedBetweenThrowsTokAndOutput` to replace the node's
  ///                   current `unexpectedBetweenThrowsTokAndOutput`, if present.
  public func withUnexpectedBetweenThrowsTokAndOutput(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return ClosureSignatureSyntax(newData)
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 11)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOutputAndInTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOutputAndInTok` replaced.
  /// - param newChild: The new `unexpectedBetweenOutputAndInTok` to replace the node's
  ///                   current `unexpectedBetweenOutputAndInTok`, if present.
  public func withUnexpectedBetweenOutputAndInTok(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return ClosureSignatureSyntax(newData)
  }

  public var inTok: TokenSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.inKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 13)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedAfterInTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterInTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterInTok` replaced.
  /// - param newChild: The new `unexpectedAfterInTok` to replace the node's
  ///                   current `unexpectedAfterInTok`, if present.
  public func withUnexpectedAfterInTok(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return ClosureSignatureSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndCapture,
      \Self.capture,
      \Self.unexpectedBetweenCaptureAndInput,
      \Self.input,
      \Self.unexpectedBetweenInputAndAsyncKeyword,
      \Self.asyncKeyword,
      \Self.unexpectedBetweenAsyncKeywordAndThrowsTok,
      \Self.throwsTok,
      \Self.unexpectedBetweenThrowsTokAndOutput,
      \Self.output,
      \Self.unexpectedBetweenOutputAndInTok,
      \Self.inTok,
      \Self.unexpectedAfterInTok,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "attributes"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return nil
    case 14:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ClosureSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndCapture": unexpectedBetweenAttributesAndCapture.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "capture": capture.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCaptureAndInput": unexpectedBetweenCaptureAndInput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "input": input.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInputAndAsyncKeyword": unexpectedBetweenInputAndAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncKeywordAndThrowsTok": unexpectedBetweenAsyncKeywordAndThrowsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsTok": throwsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenThrowsTokAndOutput": unexpectedBetweenThrowsTokAndOutput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "output": output.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenOutputAndInTok": unexpectedBetweenOutputAndInTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inTok": Syntax(inTok).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterInTok": unexpectedAfterInTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MultipleTrailingClosureElementSyntax

public struct MultipleTrailingClosureElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? = nil,
    closure: ClosureExprSyntax,
    _ unexpectedAfterClosure: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndClosure?.raw,
      closure.raw,
      unexpectedAfterClosure?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndClosure` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndClosure` to replace the node's
  ///                   current `unexpectedBetweenColonAndClosure`, if present.
  public func withUnexpectedBetweenColonAndClosure(
    _ newChild: UnexpectedNodesSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var closure: ClosureExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.closureExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var unexpectedAfterClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterClosure` replaced.
  /// - param newChild: The new `unexpectedAfterClosure` to replace the node's
  ///                   current `unexpectedAfterClosure`, if present.
  public func withUnexpectedAfterClosure(
    _ newChild: UnexpectedNodesSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndClosure,
      \Self.closure,
      \Self.unexpectedAfterClosure,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MultipleTrailingClosureElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndClosure": unexpectedBetweenColonAndClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "closure": Syntax(closure).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterClosure": unexpectedAfterClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - StringSegmentSyntax

public struct StringSegmentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeContent: UnexpectedNodesSyntax? = nil,
    content: TokenSyntax,
    _ unexpectedAfterContent: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeContent?.raw,
      content.raw,
      unexpectedAfterContent?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringSegment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeContent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeContent(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeContent` replaced.
  /// - param newChild: The new `unexpectedBeforeContent` to replace the node's
  ///                   current `unexpectedBeforeContent`, if present.
  public func withUnexpectedBeforeContent(
    _ newChild: UnexpectedNodesSyntax?) -> StringSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return StringSegmentSyntax(newData)
  }

  public var content: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringSegment(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return StringSegmentSyntax(newData)
  }

  public var unexpectedAfterContent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterContent(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterContent` replaced.
  /// - param newChild: The new `unexpectedAfterContent` to replace the node's
  ///                   current `unexpectedAfterContent`, if present.
  public func withUnexpectedAfterContent(
    _ newChild: UnexpectedNodesSyntax?) -> StringSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return StringSegmentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeContent,
      \Self.content,
      \Self.unexpectedAfterContent,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension StringSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeContent": unexpectedBeforeContent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "content": Syntax(content).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterContent": unexpectedAfterContent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionSegmentSyntax

public struct ExpressionSegmentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil,
    backslash: TokenSyntax,
    _ unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? = nil,
    delimiter: TokenSyntax?,
    _ unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? = nil,
    expressions: TupleExprElementListSyntax,
    _ unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionSegment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeBackslash: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBackslash(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBackslash` replaced.
  /// - param newChild: The new `unexpectedBeforeBackslash` to replace the node's
  ///                   current `unexpectedBeforeBackslash`, if present.
  public func withUnexpectedBeforeBackslash(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ExpressionSegmentSyntax(newData)
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBackslashAndDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBackslashAndDelimiter` replaced.
  /// - param newChild: The new `unexpectedBetweenBackslashAndDelimiter` to replace the node's
  ///                   current `unexpectedBetweenBackslashAndDelimiter`, if present.
  public func withUnexpectedBetweenBackslashAndDelimiter(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ExpressionSegmentSyntax(newData)
  }

  public var delimiter: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDelimiterAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDelimiterAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenDelimiterAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenDelimiterAndLeftParen`, if present.
  public func withUnexpectedBetweenDelimiterAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ExpressionSegmentSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndExpressions(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndExpressions` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndExpressions` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndExpressions`, if present.
  public func withUnexpectedBetweenLeftParenAndExpressions(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ExpressionSegmentSyntax(newData)
  }

  public var expressions: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[7] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 7)
    return ExpressionSegmentSyntax(newData)
  }

  /// Returns a copy of the receiver with its `expressions` replaced.
  /// - param newChild: The new `expressions` to replace the node's
  ///                   current `expressions`, if present.
  public func withExpressions(
    _ newChild: TupleExprElementListSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionsAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionsAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenExpressionsAndRightParen`, if present.
  public func withUnexpectedBetweenExpressionsAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return ExpressionSegmentSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringInterpolationAnchor, arena: .default)
    let newData = data.replacingChild(raw, at: 9)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return ExpressionSegmentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBackslash,
      \Self.backslash,
      \Self.unexpectedBetweenBackslashAndDelimiter,
      \Self.delimiter,
      \Self.unexpectedBetweenDelimiterAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndExpressions,
      \Self.expressions,
      \Self.unexpectedBetweenExpressionsAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ExpressionSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBackslash": unexpectedBeforeBackslash.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBackslashAndDelimiter": unexpectedBetweenBackslashAndDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "delimiter": delimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDelimiterAndLeftParen": unexpectedBetweenDelimiterAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndExpressions": unexpectedBetweenLeftParenAndExpressions.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expressions": Syntax(expressions).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionsAndRightParen": unexpectedBetweenExpressionsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathComponentSyntax

public struct KeyPathComponentSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Component: SyntaxChildChoices {
    case `property`(KeyPathPropertyComponentSyntax)
    case `subscript`(KeyPathSubscriptComponentSyntax)
    case `optional`(KeyPathOptionalComponentSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .property(let node): return node._syntaxNode
      case .subscript(let node): return node._syntaxNode
      case .optional(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: KeyPathPropertyComponentSyntax) {
      self = .property(node)
    }
    public init(_ node: KeyPathSubscriptComponentSyntax) {
      self = .subscript(node)
    }
    public init(_ node: KeyPathOptionalComponentSyntax) {
      self = .optional(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(KeyPathPropertyComponentSyntax.self) {
        self = .property(node)
        return
      }
      if let node = syntaxNode.as(KeyPathSubscriptComponentSyntax.self) {
        self = .subscript(node)
        return
      }
      if let node = syntaxNode.as(KeyPathOptionalComponentSyntax.self) {
        self = .optional(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(KeyPathPropertyComponentSyntax.self),
        .node(KeyPathSubscriptComponentSyntax.self),
        .node(KeyPathOptionalComponentSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathComponent else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax?,
    _ unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? = nil,
    component: Component,
    _ unexpectedAfterComponent: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePeriod?.raw,
      period?.raw,
      unexpectedBetweenPeriodAndComponent?.raw,
      component.raw,
      unexpectedAfterComponent?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePeriod` replaced.
  /// - param newChild: The new `unexpectedBeforePeriod` to replace the node's
  ///                   current `unexpectedBeforePeriod`, if present.
  public func withUnexpectedBeforePeriod(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return KeyPathComponentSyntax(newData)
  }

  public var period: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> KeyPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 1)
    return KeyPathComponentSyntax(newData)
  }

  public var unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPeriodAndComponent(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPeriodAndComponent` replaced.
  /// - param newChild: The new `unexpectedBetweenPeriodAndComponent` to replace the node's
  ///                   current `unexpectedBetweenPeriodAndComponent`, if present.
  public func withUnexpectedBetweenPeriodAndComponent(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return KeyPathComponentSyntax(newData)
  }

  public var component: Component {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return Component(childData!)
    }
    set(value) {
      self = withComponent(value)
    }
  }

  /// Returns a copy of the receiver with its `component` replaced.
  /// - param newChild: The new `component` to replace the node's
  ///                   current `component`, if present.
  public func withComponent(
    _ newChild: Component?) -> KeyPathComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return KeyPathComponentSyntax(newData)
  }

  public var unexpectedAfterComponent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterComponent(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterComponent` replaced.
  /// - param newChild: The new `unexpectedAfterComponent` to replace the node's
  ///                   current `unexpectedAfterComponent`, if present.
  public func withUnexpectedAfterComponent(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return KeyPathComponentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePeriod,
      \Self.period,
      \Self.unexpectedBetweenPeriodAndComponent,
      \Self.component,
      \Self.unexpectedAfterComponent,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension KeyPathComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePeriod": unexpectedBeforePeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": period.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenPeriodAndComponent": unexpectedBetweenPeriodAndComponent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "component": Syntax(component).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterComponent": unexpectedAfterComponent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathPropertyComponentSyntax

public struct KeyPathPropertyComponentSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathPropertyComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathPropertyComponent else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathPropertyComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathPropertyComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?,
    _ unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?,
    _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathPropertyComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndDeclNameArguments` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndDeclNameArguments`, if present.
  public func withUnexpectedBetweenIdentifierAndDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: DeclNameArgumentsSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeclNameArgumentsAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause` to replace the node's
  ///                   current `unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause`, if present.
  public func withUnexpectedBetweenDeclNameArgumentsAndGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericArgumentClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericArgumentClause` replaced.
  /// - param newChild: The new `genericArgumentClause` to replace the node's
  ///                   current `genericArgumentClause`, if present.
  public func withGenericArgumentClause(
    _ newChild: GenericArgumentClauseSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public var unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedAfterGenericArgumentClause` to replace the node's
  ///                   current `unexpectedAfterGenericArgumentClause`, if present.
  public func withUnexpectedAfterGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathPropertyComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return KeyPathPropertyComponentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndDeclNameArguments,
      \Self.declNameArguments,
      \Self.unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause,
      \Self.genericArgumentClause,
      \Self.unexpectedAfterGenericArgumentClause,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension KeyPathPropertyComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndDeclNameArguments": unexpectedBetweenIdentifierAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause": unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericArgumentClause": unexpectedAfterGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathSubscriptComponentSyntax

public struct KeyPathSubscriptComponentSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathSubscriptComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathSubscriptComponent else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathSubscriptComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathSubscriptComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? = nil,
    leftBracket: TokenSyntax,
    _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil,
    rightBracket: TokenSyntax,
    _ unexpectedAfterRightBracket: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBracket?.raw,
      leftBracket.raw,
      unexpectedBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      unexpectedAfterRightBracket?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathSubscriptComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftBracket`, if present.
  public func withUnexpectedBeforeLeftBracket(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var leftBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `leftBracket` replaced.
  /// - param newChild: The new `leftBracket` to replace the node's
  ///                   current `leftBracket`, if present.
  public func withLeftBracket(
    _ newChild: TokenSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBracketAndArgumentList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBracketAndArgumentList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBracketAndArgumentList` to replace the node's
  ///                   current `unexpectedBetweenLeftBracketAndArgumentList`, if present.
  public func withUnexpectedBetweenLeftBracketAndArgumentList(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
  public func addArgument(_ element: TupleExprElementSyntax) -> KeyPathSubscriptComponentSyntax {
    var collection: RawSyntax
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: TupleExprElementListSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentListAndRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentListAndRightBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentListAndRightBracket` to replace the node's
  ///                   current `unexpectedBetweenArgumentListAndRightBracket`, if present.
  public func withUnexpectedBetweenArgumentListAndRightBracket(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var rightBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `rightBracket` replaced.
  /// - param newChild: The new `rightBracket` to replace the node's
  ///                   current `rightBracket`, if present.
  public func withRightBracket(
    _ newChild: TokenSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var unexpectedAfterRightBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightBracket` to replace the node's
  ///                   current `unexpectedAfterRightBracket`, if present.
  public func withUnexpectedAfterRightBracket(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathSubscriptComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftBracket,
      \Self.leftBracket,
      \Self.unexpectedBetweenLeftBracketAndArgumentList,
      \Self.argumentList,
      \Self.unexpectedBetweenArgumentListAndRightBracket,
      \Self.rightBracket,
      \Self.unexpectedAfterRightBracket,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "arguments"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension KeyPathSubscriptComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftBracket": unexpectedBeforeLeftBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBracket": Syntax(leftBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBracketAndArgumentList": unexpectedBetweenLeftBracketAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentListAndRightBracket": unexpectedBetweenArgumentListAndRightBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBracket": Syntax(rightBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightBracket": unexpectedAfterRightBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathOptionalComponentSyntax

public struct KeyPathOptionalComponentSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathOptionalComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathOptionalComponent else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathOptionalComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathOptionalComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax,
    _ unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionOrExclamationMark?.raw,
      questionOrExclamationMark.raw,
      unexpectedAfterQuestionOrExclamationMark?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathOptionalComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `unexpectedBeforeQuestionOrExclamationMark` to replace the node's
  ///                   current `unexpectedBeforeQuestionOrExclamationMark`, if present.
  public func withUnexpectedBeforeQuestionOrExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathOptionalComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return KeyPathOptionalComponentSyntax(newData)
  }

  public var questionOrExclamationMark: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `questionOrExclamationMark` replaced.
  /// - param newChild: The new `questionOrExclamationMark` to replace the node's
  ///                   current `questionOrExclamationMark`, if present.
  public func withQuestionOrExclamationMark(
    _ newChild: TokenSyntax?) -> KeyPathOptionalComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return KeyPathOptionalComponentSyntax(newData)
  }

  public var unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `unexpectedAfterQuestionOrExclamationMark` to replace the node's
  ///                   current `unexpectedAfterQuestionOrExclamationMark`, if present.
  public func withUnexpectedAfterQuestionOrExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathOptionalComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return KeyPathOptionalComponentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeQuestionOrExclamationMark,
      \Self.questionOrExclamationMark,
      \Self.unexpectedAfterQuestionOrExclamationMark,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension KeyPathOptionalComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeQuestionOrExclamationMark": unexpectedBeforeQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": Syntax(questionOrExclamationMark).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterQuestionOrExclamationMark": unexpectedAfterQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjcNamePieceSyntax

public struct ObjcNamePieceSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndDot: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax?,
    _ unexpectedAfterDot: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndDot?.raw,
      dot?.raw,
      unexpectedAfterDot?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcNamePiece,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcNamePieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ObjcNamePieceSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ObjcNamePieceSyntax(newData)
  }

  public var unexpectedBetweenNameAndDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndDot` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndDot` to replace the node's
  ///                   current `unexpectedBetweenNameAndDot`, if present.
  public func withUnexpectedBetweenNameAndDot(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcNamePieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ObjcNamePieceSyntax(newData)
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ObjcNamePieceSyntax(newData)
  }

  public var unexpectedAfterDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDot` replaced.
  /// - param newChild: The new `unexpectedAfterDot` to replace the node's
  ///                   current `unexpectedAfterDot`, if present.
  public func withUnexpectedAfterDot(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcNamePieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ObjcNamePieceSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndDot,
      \Self.dot,
      \Self.unexpectedAfterDot,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ObjcNamePieceSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndDot": unexpectedBetweenNameAndDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterDot": unexpectedAfterDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - YieldExprListElementSyntax

public struct YieldExprListElementSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `YieldExprListElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .yieldExprListElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `YieldExprListElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldExprListElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax?,
    _ unexpectedAfterComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndComma?.raw,
      comma?.raw,
      unexpectedAfterComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprListElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> YieldExprListElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return YieldExprListElementSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: ExprSyntax?) -> YieldExprListElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return YieldExprListElementSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndComma` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndComma`, if present.
  public func withUnexpectedBetweenExpressionAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> YieldExprListElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return YieldExprListElementSyntax(newData)
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> YieldExprListElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return YieldExprListElementSyntax(newData)
  }

  public var unexpectedAfterComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterComma` replaced.
  /// - param newChild: The new `unexpectedAfterComma` to replace the node's
  ///                   current `unexpectedAfterComma`, if present.
  public func withUnexpectedAfterComma(
    _ newChild: UnexpectedNodesSyntax?) -> YieldExprListElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return YieldExprListElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeExpression,
      \Self.expression,
      \Self.unexpectedBetweenExpressionAndComma,
      \Self.comma,
      \Self.unexpectedAfterComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension YieldExprListElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndComma": unexpectedBetweenExpressionAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterComma": unexpectedAfterComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInitializerClauseSyntax

public struct TypeInitializerClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil,
    equal: TokenSyntax,
    _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil,
    value: TypeSyntax,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInitializerClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeEqual: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeEqual(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeEqual` replaced.
  /// - param newChild: The new `unexpectedBeforeEqual` to replace the node's
  ///                   current `unexpectedBeforeEqual`, if present.
  public func withUnexpectedBeforeEqual(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TypeInitializerClauseSyntax(newData)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return TypeInitializerClauseSyntax(newData)
  }

  public var unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEqualAndValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEqualAndValue` replaced.
  /// - param newChild: The new `unexpectedBetweenEqualAndValue` to replace the node's
  ///                   current `unexpectedBetweenEqualAndValue`, if present.
  public func withUnexpectedBetweenEqualAndValue(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TypeInitializerClauseSyntax(newData)
  }

  public var value: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return TypeInitializerClauseSyntax(newData)
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValue` replaced.
  /// - param newChild: The new `unexpectedAfterValue` to replace the node's
  ///                   current `unexpectedAfterValue`, if present.
  public func withUnexpectedAfterValue(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TypeInitializerClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeEqual,
      \Self.equal,
      \Self.unexpectedBetweenEqualAndValue,
      \Self.value,
      \Self.unexpectedAfterValue,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "type"
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TypeInitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeEqual": unexpectedBeforeEqual.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenEqualAndValue": unexpectedBetweenEqualAndValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValue": unexpectedAfterValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ParameterClauseSyntax

public struct ParameterClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? = nil,
    parameterList: FunctionParameterListSyntax,
    _ unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndParameterList?.raw,
      parameterList.raw,
      unexpectedBetweenParameterListAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.parameterClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ParameterClauseSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndParameterList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndParameterList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndParameterList` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndParameterList`, if present.
  public func withUnexpectedBetweenLeftParenAndParameterList(
    _ newChild: UnexpectedNodesSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ParameterClauseSyntax(newData)
  }

  public var parameterList: FunctionParameterListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.functionParameterList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return ParameterClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `parameterList` replaced.
  /// - param newChild: The new `parameterList` to replace the node's
  ///                   current `parameterList`, if present.
  public func withParameterList(
    _ newChild: FunctionParameterListSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionParameterList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenParameterListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenParameterListAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenParameterListAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenParameterListAndRightParen`, if present.
  public func withUnexpectedBetweenParameterListAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ParameterClauseSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ParameterClauseSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ParameterClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndParameterList,
      \Self.parameterList,
      \Self.unexpectedBetweenParameterListAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "parameters"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndParameterList": unexpectedBetweenLeftParenAndParameterList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "parameterList": Syntax(parameterList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenParameterListAndRightParen": unexpectedBetweenParameterListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ReturnClauseSyntax

public struct ReturnClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeArrow: UnexpectedNodesSyntax? = nil,
    arrow: TokenSyntax,
    _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil,
    returnType: TypeSyntax,
    _ unexpectedAfterReturnType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArrow?.raw,
      arrow.raw,
      unexpectedBetweenArrowAndReturnType?.raw,
      returnType.raw,
      unexpectedAfterReturnType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.returnClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeArrow: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeArrow(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeArrow` replaced.
  /// - param newChild: The new `unexpectedBeforeArrow` to replace the node's
  ///                   current `unexpectedBeforeArrow`, if present.
  public func withUnexpectedBeforeArrow(
    _ newChild: UnexpectedNodesSyntax?) -> ReturnClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ReturnClauseSyntax(newData)
  }

  public var arrow: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ReturnClauseSyntax(newData)
  }

  public var unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArrowAndReturnType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArrowAndReturnType` replaced.
  /// - param newChild: The new `unexpectedBetweenArrowAndReturnType` to replace the node's
  ///                   current `unexpectedBetweenArrowAndReturnType`, if present.
  public func withUnexpectedBetweenArrowAndReturnType(
    _ newChild: UnexpectedNodesSyntax?) -> ReturnClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ReturnClauseSyntax(newData)
  }

  public var returnType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ReturnClauseSyntax(newData)
  }

  public var unexpectedAfterReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterReturnType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterReturnType` replaced.
  /// - param newChild: The new `unexpectedAfterReturnType` to replace the node's
  ///                   current `unexpectedAfterReturnType`, if present.
  public func withUnexpectedAfterReturnType(
    _ newChild: UnexpectedNodesSyntax?) -> ReturnClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ReturnClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeArrow,
      \Self.arrow,
      \Self.unexpectedBetweenArrowAndReturnType,
      \Self.returnType,
      \Self.unexpectedAfterReturnType,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "return type"
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ReturnClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeArrow": unexpectedBeforeArrow.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArrowAndReturnType": unexpectedBetweenArrowAndReturnType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterReturnType": unexpectedAfterReturnType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionSignatureSyntax

public struct FunctionSignatureSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeInput: UnexpectedNodesSyntax? = nil,
    input: ParameterClauseSyntax,
    _ unexpectedBetweenInputAndAsyncOrReasyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncOrReasyncKeyword: TokenSyntax?,
    _ unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax?,
    _ unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: UnexpectedNodesSyntax? = nil,
    output: ReturnClauseSyntax?,
    _ unexpectedAfterOutput: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeInput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeInput(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeInput` replaced.
  /// - param newChild: The new `unexpectedBeforeInput` to replace the node's
  ///                   current `unexpectedBeforeInput`, if present.
  public func withUnexpectedBeforeInput(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return FunctionSignatureSyntax(newData)
  }

  public var input: ParameterClauseSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return FunctionSignatureSyntax(newData)
  }

  public var unexpectedBetweenInputAndAsyncOrReasyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInputAndAsyncOrReasyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInputAndAsyncOrReasyncKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenInputAndAsyncOrReasyncKeyword` to replace the node's
  ///                   current `unexpectedBetweenInputAndAsyncOrReasyncKeyword`, if present.
  public func withUnexpectedBetweenInputAndAsyncOrReasyncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return FunctionSignatureSyntax(newData)
  }

  public var asyncOrReasyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return FunctionSignatureSyntax(newData)
  }

  public var unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword` to replace the node's
  ///                   current `unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword`, if present.
  public func withUnexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return FunctionSignatureSyntax(newData)
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return FunctionSignatureSyntax(newData)
  }

  public var unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenThrowsOrRethrowsKeywordAndOutput(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenThrowsOrRethrowsKeywordAndOutput` replaced.
  /// - param newChild: The new `unexpectedBetweenThrowsOrRethrowsKeywordAndOutput` to replace the node's
  ///                   current `unexpectedBetweenThrowsOrRethrowsKeywordAndOutput`, if present.
  public func withUnexpectedBetweenThrowsOrRethrowsKeywordAndOutput(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return FunctionSignatureSyntax(newData)
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return FunctionSignatureSyntax(newData)
  }

  public var unexpectedAfterOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterOutput(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterOutput` replaced.
  /// - param newChild: The new `unexpectedAfterOutput` to replace the node's
  ///                   current `unexpectedAfterOutput`, if present.
  public func withUnexpectedAfterOutput(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return FunctionSignatureSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeInput,
      \Self.input,
      \Self.unexpectedBetweenInputAndAsyncOrReasyncKeyword,
      \Self.asyncOrReasyncKeyword,
      \Self.unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword,
      \Self.throwsOrRethrowsKeyword,
      \Self.unexpectedBetweenThrowsOrRethrowsKeywordAndOutput,
      \Self.output,
      \Self.unexpectedAfterOutput,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension FunctionSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeInput": unexpectedBeforeInput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "input": Syntax(input).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenInputAndAsyncOrReasyncKeyword": unexpectedBetweenInputAndAsyncOrReasyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncOrReasyncKeyword": asyncOrReasyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword": unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenThrowsOrRethrowsKeywordAndOutput": unexpectedBetweenThrowsOrRethrowsKeywordAndOutput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "output": output.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterOutput": unexpectedAfterOutput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfConfigClauseSyntax

public struct IfConfigClauseSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Elements: SyntaxChildChoices {
    case `statements`(CodeBlockItemListSyntax)
    case `switchCases`(SwitchCaseListSyntax)
    case `decls`(MemberDeclListSyntax)
    case `postfixExpression`(ExprSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .statements(let node): return node._syntaxNode
      case .switchCases(let node): return node._syntaxNode
      case .decls(let node): return node._syntaxNode
      case .postfixExpression(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: CodeBlockItemListSyntax) {
      self = .statements(node)
    }
    public init(_ node: SwitchCaseListSyntax) {
      self = .switchCases(node)
    }
    public init(_ node: MemberDeclListSyntax) {
      self = .decls(node)
    }
    public init<Node: ExprSyntaxProtocol>(_ node: Node) {
      self = .postfixExpression(ExprSyntax(node))
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(CodeBlockItemListSyntax.self) {
        self = .statements(node)
        return
      }
      if let node = syntaxNode.as(SwitchCaseListSyntax.self) {
        self = .switchCases(node)
        return
      }
      if let node = syntaxNode.as(MemberDeclListSyntax.self) {
        self = .decls(node)
        return
      }
      if let node = syntaxNode.as(ExprSyntax.self) {
        self = .postfixExpression(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(CodeBlockItemListSyntax.self),
        .node(SwitchCaseListSyntax.self),
        .node(MemberDeclListSyntax.self),
        .node(ExprSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? = nil,
    poundKeyword: TokenSyntax,
    _ unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? = nil,
    condition: ExprSyntax?,
    _ unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? = nil,
    elements: Elements?,
    _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundKeyword?.raw,
      poundKeyword.raw,
      unexpectedBetweenPoundKeywordAndCondition?.raw,
      condition?.raw,
      unexpectedBetweenConditionAndElements?.raw,
      elements?.raw,
      unexpectedAfterElements?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforePoundKeyword` to replace the node's
  ///                   current `unexpectedBeforePoundKeyword`, if present.
  public func withUnexpectedBeforePoundKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return IfConfigClauseSyntax(newData)
  }

  public var poundKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundIfKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return IfConfigClauseSyntax(newData)
  }

  public var unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundKeywordAndCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundKeywordAndCondition` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundKeywordAndCondition` to replace the node's
  ///                   current `unexpectedBetweenPoundKeywordAndCondition`, if present.
  public func withUnexpectedBetweenPoundKeywordAndCondition(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return IfConfigClauseSyntax(newData)
  }

  public var condition: ExprSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return IfConfigClauseSyntax(newData)
  }

  public var unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenConditionAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenConditionAndElements` replaced.
  /// - param newChild: The new `unexpectedBetweenConditionAndElements` to replace the node's
  ///                   current `unexpectedBetweenConditionAndElements`, if present.
  public func withUnexpectedBetweenConditionAndElements(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return IfConfigClauseSyntax(newData)
  }

  public var elements: Elements? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return Elements(childData!)
    }
    set(value) {
      self = withElements(value)
    }
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: Elements?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return IfConfigClauseSyntax(newData)
  }

  public var unexpectedAfterElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterElements` replaced.
  /// - param newChild: The new `unexpectedAfterElements` to replace the node's
  ///                   current `unexpectedAfterElements`, if present.
  public func withUnexpectedAfterElements(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return IfConfigClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundKeyword,
      \Self.poundKeyword,
      \Self.unexpectedBetweenPoundKeywordAndCondition,
      \Self.condition,
      \Self.unexpectedBetweenConditionAndElements,
      \Self.elements,
      \Self.unexpectedAfterElements,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "condition"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension IfConfigClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundKeyword": unexpectedBeforePoundKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundKeyword": Syntax(poundKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundKeywordAndCondition": unexpectedBetweenPoundKeywordAndCondition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "condition": condition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenConditionAndElements": unexpectedBetweenConditionAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": elements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterElements": unexpectedAfterElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundSourceLocationArgsSyntax

public struct PoundSourceLocationArgsSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? = nil,
    fileArgLabel: TokenSyntax,
    _ unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? = nil,
    fileArgColon: TokenSyntax,
    _ unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? = nil,
    fileName: TokenSyntax,
    _ unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax,
    _ unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? = nil,
    lineArgLabel: TokenSyntax,
    _ unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? = nil,
    lineArgColon: TokenSyntax,
    _ unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? = nil,
    lineNumber: TokenSyntax,
    _ unexpectedAfterLineNumber: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocationArgs,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeFileArgLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeFileArgLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeFileArgLabel` to replace the node's
  ///                   current `unexpectedBeforeFileArgLabel`, if present.
  public func withUnexpectedBeforeFileArgLabel(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var fileArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFileArgLabelAndFileArgColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFileArgLabelAndFileArgColon` replaced.
  /// - param newChild: The new `unexpectedBetweenFileArgLabelAndFileArgColon` to replace the node's
  ///                   current `unexpectedBetweenFileArgLabelAndFileArgColon`, if present.
  public func withUnexpectedBetweenFileArgLabelAndFileArgColon(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var fileArgColon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFileArgColonAndFileName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFileArgColonAndFileName` replaced.
  /// - param newChild: The new `unexpectedBetweenFileArgColonAndFileName` to replace the node's
  ///                   current `unexpectedBetweenFileArgColonAndFileName`, if present.
  public func withUnexpectedBetweenFileArgColonAndFileName(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var fileName: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFileNameAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFileNameAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenFileNameAndComma` to replace the node's
  ///                   current `unexpectedBetweenFileNameAndComma`, if present.
  public func withUnexpectedBetweenFileNameAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndLineArgLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndLineArgLabel` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndLineArgLabel` to replace the node's
  ///                   current `unexpectedBetweenCommaAndLineArgLabel`, if present.
  public func withUnexpectedBetweenCommaAndLineArgLabel(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var lineArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 9)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLineArgLabelAndLineArgColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLineArgLabelAndLineArgColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLineArgLabelAndLineArgColon` to replace the node's
  ///                   current `unexpectedBetweenLineArgLabelAndLineArgColon`, if present.
  public func withUnexpectedBetweenLineArgLabelAndLineArgColon(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var lineArgColon: TokenSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 11)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLineArgColonAndLineNumber(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLineArgColonAndLineNumber` replaced.
  /// - param newChild: The new `unexpectedBetweenLineArgColonAndLineNumber` to replace the node's
  ///                   current `unexpectedBetweenLineArgColonAndLineNumber`, if present.
  public func withUnexpectedBetweenLineArgColonAndLineNumber(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var lineNumber: TokenSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: 13)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public var unexpectedAfterLineNumber: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterLineNumber(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterLineNumber` replaced.
  /// - param newChild: The new `unexpectedAfterLineNumber` to replace the node's
  ///                   current `unexpectedAfterLineNumber`, if present.
  public func withUnexpectedAfterLineNumber(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return PoundSourceLocationArgsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeFileArgLabel,
      \Self.fileArgLabel,
      \Self.unexpectedBetweenFileArgLabelAndFileArgColon,
      \Self.fileArgColon,
      \Self.unexpectedBetweenFileArgColonAndFileName,
      \Self.fileName,
      \Self.unexpectedBetweenFileNameAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndLineArgLabel,
      \Self.lineArgLabel,
      \Self.unexpectedBetweenLineArgLabelAndLineArgColon,
      \Self.lineArgColon,
      \Self.unexpectedBetweenLineArgColonAndLineNumber,
      \Self.lineNumber,
      \Self.unexpectedAfterLineNumber,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "file name"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return "line number"
    case 14:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PoundSourceLocationArgsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeFileArgLabel": unexpectedBeforeFileArgLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "fileArgLabel": Syntax(fileArgLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFileArgLabelAndFileArgColon": unexpectedBetweenFileArgLabelAndFileArgColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "fileArgColon": Syntax(fileArgColon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFileArgColonAndFileName": unexpectedBetweenFileArgColonAndFileName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "fileName": Syntax(fileName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFileNameAndComma": unexpectedBetweenFileNameAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCommaAndLineArgLabel": unexpectedBetweenCommaAndLineArgLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "lineArgLabel": Syntax(lineArgLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLineArgLabelAndLineArgColon": unexpectedBetweenLineArgLabelAndLineArgColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "lineArgColon": Syntax(lineArgColon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLineArgColonAndLineNumber": unexpectedBetweenLineArgColonAndLineNumber.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "lineNumber": Syntax(lineNumber).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterLineNumber": unexpectedAfterLineNumber.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclModifierDetailSyntax

public struct DeclModifierDetailSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclModifierDetailSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declModifierDetail else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclModifierDetailSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declModifierDetail)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? = nil,
    detail: TokenSyntax,
    _ unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDetail?.raw,
      detail.raw,
      unexpectedBetweenDetailAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifierDetail,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DeclModifierDetailSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DeclModifierDetailSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndDetail(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndDetail` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndDetail` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndDetail`, if present.
  public func withUnexpectedBetweenLeftParenAndDetail(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DeclModifierDetailSyntax(newData)
  }

  public var detail: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DeclModifierDetailSyntax(newData)
  }

  public var unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDetailAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDetailAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenDetailAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenDetailAndRightParen`, if present.
  public func withUnexpectedBetweenDetailAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DeclModifierDetailSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DeclModifierDetailSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierDetailSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DeclModifierDetailSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndDetail,
      \Self.detail,
      \Self.unexpectedBetweenDetailAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeclModifierDetailSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndDetail": unexpectedBetweenLeftParenAndDetail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "detail": Syntax(detail).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDetailAndRightParen": unexpectedBetweenDetailAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclModifierSyntax

public struct DeclModifierSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? = nil,
    detail: DeclModifierDetailSyntax?,
    _ unexpectedAfterDetail: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndDetail?.raw,
      detail?.raw,
      unexpectedAfterDetail?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DeclModifierSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DeclModifierSyntax(newData)
  }

  public var unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndDetail(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndDetail` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndDetail` to replace the node's
  ///                   current `unexpectedBetweenNameAndDetail`, if present.
  public func withUnexpectedBetweenNameAndDetail(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DeclModifierSyntax(newData)
  }

  public var detail: DeclModifierDetailSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclModifierDetailSyntax(childData!)
    }
    set(value) {
      self = withDetail(value)
    }
  }

  /// Returns a copy of the receiver with its `detail` replaced.
  /// - param newChild: The new `detail` to replace the node's
  ///                   current `detail`, if present.
  public func withDetail(
    _ newChild: DeclModifierDetailSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return DeclModifierSyntax(newData)
  }

  public var unexpectedAfterDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDetail(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDetail` replaced.
  /// - param newChild: The new `unexpectedAfterDetail` to replace the node's
  ///                   current `unexpectedAfterDetail`, if present.
  public func withUnexpectedAfterDetail(
    _ newChild: UnexpectedNodesSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DeclModifierSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndDetail,
      \Self.detail,
      \Self.unexpectedAfterDetail,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeclModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndDetail": unexpectedBetweenNameAndDetail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "detail": detail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterDetail": unexpectedAfterDetail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InheritedTypeSyntax

public struct InheritedTypeSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeTypeName: UnexpectedNodesSyntax? = nil,
    typeName: TypeSyntax,
    _ unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTypeName?.raw,
      typeName.raw,
      unexpectedBetweenTypeNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeTypeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeTypeName` replaced.
  /// - param newChild: The new `unexpectedBeforeTypeName` to replace the node's
  ///                   current `unexpectedBeforeTypeName`, if present.
  public func withUnexpectedBeforeTypeName(
    _ newChild: UnexpectedNodesSyntax?) -> InheritedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return InheritedTypeSyntax(newData)
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return InheritedTypeSyntax(newData)
  }

  public var unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeNameAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeNameAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeNameAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenTypeNameAndTrailingComma`, if present.
  public func withUnexpectedBetweenTypeNameAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> InheritedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return InheritedTypeSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return InheritedTypeSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> InheritedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return InheritedTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeTypeName,
      \Self.typeName,
      \Self.unexpectedBetweenTypeNameAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension InheritedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeTypeName": unexpectedBeforeTypeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypeNameAndTrailingComma": unexpectedBetweenTypeNameAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInheritanceClauseSyntax

public struct TypeInheritanceClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? = nil,
    inheritedTypeCollection: InheritedTypeListSyntax,
    _ unexpectedAfterInheritedTypeCollection: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndInheritedTypeCollection?.raw,
      inheritedTypeCollection.raw,
      unexpectedAfterInheritedTypeCollection?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInheritanceClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeColon` replaced.
  /// - param newChild: The new `unexpectedBeforeColon` to replace the node's
  ///                   current `unexpectedBeforeColon`, if present.
  public func withUnexpectedBeforeColon(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TypeInheritanceClauseSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return TypeInheritanceClauseSyntax(newData)
  }

  public var unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndInheritedTypeCollection(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndInheritedTypeCollection` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndInheritedTypeCollection` to replace the node's
  ///                   current `unexpectedBetweenColonAndInheritedTypeCollection`, if present.
  public func withUnexpectedBetweenColonAndInheritedTypeCollection(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TypeInheritanceClauseSyntax(newData)
  }

  public var inheritedTypeCollection: InheritedTypeListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.inheritedTypeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return TypeInheritanceClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `inheritedTypeCollection` replaced.
  /// - param newChild: The new `inheritedTypeCollection` to replace the node's
  ///                   current `inheritedTypeCollection`, if present.
  public func withInheritedTypeCollection(
    _ newChild: InheritedTypeListSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.inheritedTypeList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return TypeInheritanceClauseSyntax(newData)
  }

  public var unexpectedAfterInheritedTypeCollection: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterInheritedTypeCollection(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterInheritedTypeCollection` replaced.
  /// - param newChild: The new `unexpectedAfterInheritedTypeCollection` to replace the node's
  ///                   current `unexpectedAfterInheritedTypeCollection`, if present.
  public func withUnexpectedAfterInheritedTypeCollection(
    _ newChild: UnexpectedNodesSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TypeInheritanceClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndInheritedTypeCollection,
      \Self.inheritedTypeCollection,
      \Self.unexpectedAfterInheritedTypeCollection,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TypeInheritanceClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeColon": unexpectedBeforeColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndInheritedTypeCollection": unexpectedBetweenColonAndInheritedTypeCollection.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritedTypeCollection": Syntax(inheritedTypeCollection).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterInheritedTypeCollection": unexpectedAfterInheritedTypeCollection.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberDeclBlockSyntax

public struct MemberDeclBlockSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclListSyntax,
    _ unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax,
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndMembers?.raw,
      members.raw,
      unexpectedBetweenMembersAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftBrace` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftBrace` to replace the node's
  ///                   current `unexpectedBeforeLeftBrace`, if present.
  public func withUnexpectedBeforeLeftBrace(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MemberDeclBlockSyntax(newData)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MemberDeclBlockSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBraceAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBraceAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBraceAndMembers` to replace the node's
  ///                   current `unexpectedBetweenLeftBraceAndMembers`, if present.
  public func withUnexpectedBetweenLeftBraceAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MemberDeclBlockSyntax(newData)
  }

  public var members: MemberDeclListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return MemberDeclBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclListSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return MemberDeclBlockSyntax(newData)
  }

  public var unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMembersAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMembersAndRightBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenMembersAndRightBrace` to replace the node's
  ///                   current `unexpectedBetweenMembersAndRightBrace`, if present.
  public func withUnexpectedBetweenMembersAndRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MemberDeclBlockSyntax(newData)
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return MemberDeclBlockSyntax(newData)
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightBrace` replaced.
  /// - param newChild: The new `unexpectedAfterRightBrace` to replace the node's
  ///                   current `unexpectedAfterRightBrace`, if present.
  public func withUnexpectedAfterRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return MemberDeclBlockSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftBrace,
      \Self.leftBrace,
      \Self.unexpectedBetweenLeftBraceAndMembers,
      \Self.members,
      \Self.unexpectedBetweenMembersAndRightBrace,
      \Self.rightBrace,
      \Self.unexpectedAfterRightBrace,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MemberDeclBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftBrace": unexpectedBeforeLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBraceAndMembers": unexpectedBetweenLeftBraceAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMembersAndRightBrace": unexpectedBetweenMembersAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightBrace": unexpectedAfterRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberDeclListItemSyntax

/// 
/// A member declaration of a type consisting of a declaration and an
/// optional semicolon;
/// 
public struct MemberDeclListItemSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeDecl: UnexpectedNodesSyntax? = nil,
    decl: DeclSyntax,
    _ unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax?,
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDecl?.raw,
      decl.raw,
      unexpectedBetweenDeclAndSemicolon?.raw,
      semicolon?.raw,
      unexpectedAfterSemicolon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclListItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeDecl: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeDecl(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeDecl` replaced.
  /// - param newChild: The new `unexpectedBeforeDecl` to replace the node's
  ///                   current `unexpectedBeforeDecl`, if present.
  public func withUnexpectedBeforeDecl(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclListItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MemberDeclListItemSyntax(newData)
  }

  /// The declaration of the type member.
  public var decl: DeclSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingDecl, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MemberDeclListItemSyntax(newData)
  }

  public var unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeclAndSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeclAndSemicolon` replaced.
  /// - param newChild: The new `unexpectedBetweenDeclAndSemicolon` to replace the node's
  ///                   current `unexpectedBetweenDeclAndSemicolon`, if present.
  public func withUnexpectedBetweenDeclAndSemicolon(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclListItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MemberDeclListItemSyntax(newData)
  }

  /// An optional trailing semicolon.
  public var semicolon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return MemberDeclListItemSyntax(newData)
  }

  public var unexpectedAfterSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterSemicolon` replaced.
  /// - param newChild: The new `unexpectedAfterSemicolon` to replace the node's
  ///                   current `unexpectedAfterSemicolon`, if present.
  public func withUnexpectedAfterSemicolon(
    _ newChild: UnexpectedNodesSyntax?) -> MemberDeclListItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MemberDeclListItemSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeDecl,
      \Self.decl,
      \Self.unexpectedBetweenDeclAndSemicolon,
      \Self.semicolon,
      \Self.unexpectedAfterSemicolon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MemberDeclListItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeDecl": unexpectedBeforeDecl.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "decl": Syntax(decl).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDeclAndSemicolon": unexpectedBetweenDeclAndSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterSemicolon": unexpectedAfterSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SourceFileSyntax

public struct SourceFileSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? = nil,
    eofToken: TokenSyntax,
    _ unexpectedAfterEOFToken: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndEOFToken?.raw,
      eofToken.raw,
      unexpectedAfterEOFToken?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sourceFile,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeStatements` replaced.
  /// - param newChild: The new `unexpectedBeforeStatements` to replace the node's
  ///                   current `unexpectedBeforeStatements`, if present.
  public func withUnexpectedBeforeStatements(
    _ newChild: UnexpectedNodesSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SourceFileSyntax(newData)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return SourceFileSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return SourceFileSyntax(newData)
  }

  public var unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenStatementsAndEOFToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenStatementsAndEOFToken` replaced.
  /// - param newChild: The new `unexpectedBetweenStatementsAndEOFToken` to replace the node's
  ///                   current `unexpectedBetweenStatementsAndEOFToken`, if present.
  public func withUnexpectedBetweenStatementsAndEOFToken(
    _ newChild: UnexpectedNodesSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SourceFileSyntax(newData)
  }

  public var eofToken: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return SourceFileSyntax(newData)
  }

  public var unexpectedAfterEOFToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterEOFToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterEOFToken` replaced.
  /// - param newChild: The new `unexpectedAfterEOFToken` to replace the node's
  ///                   current `unexpectedAfterEOFToken`, if present.
  public func withUnexpectedAfterEOFToken(
    _ newChild: UnexpectedNodesSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SourceFileSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeStatements,
      \Self.statements,
      \Self.unexpectedBetweenStatementsAndEOFToken,
      \Self.eofToken,
      \Self.unexpectedAfterEOFToken,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension SourceFileSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeStatements": unexpectedBeforeStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenStatementsAndEOFToken": unexpectedBetweenStatementsAndEOFToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "eofToken": Syntax(eofToken).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterEOFToken": unexpectedAfterEOFToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InitializerClauseSyntax

public struct InitializerClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil,
    equal: TokenSyntax,
    _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil,
    value: ExprSyntax,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeEqual: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeEqual(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeEqual` replaced.
  /// - param newChild: The new `unexpectedBeforeEqual` to replace the node's
  ///                   current `unexpectedBeforeEqual`, if present.
  public func withUnexpectedBeforeEqual(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return InitializerClauseSyntax(newData)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return InitializerClauseSyntax(newData)
  }

  public var unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEqualAndValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEqualAndValue` replaced.
  /// - param newChild: The new `unexpectedBetweenEqualAndValue` to replace the node's
  ///                   current `unexpectedBetweenEqualAndValue`, if present.
  public func withUnexpectedBetweenEqualAndValue(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return InitializerClauseSyntax(newData)
  }

  public var value: ExprSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return InitializerClauseSyntax(newData)
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValue` replaced.
  /// - param newChild: The new `unexpectedAfterValue` to replace the node's
  ///                   current `unexpectedAfterValue`, if present.
  public func withUnexpectedAfterValue(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return InitializerClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeEqual,
      \Self.equal,
      \Self.unexpectedBetweenEqualAndValue,
      \Self.value,
      \Self.unexpectedAfterValue,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension InitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeEqual": unexpectedBeforeEqual.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenEqualAndValue": unexpectedBetweenEqualAndValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValue": unexpectedAfterValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionParameterSyntax

public struct FunctionParameterSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? = nil,
    firstName: TokenSyntax?,
    _ unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? = nil,
    secondName: TokenSyntax?,
    _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax?,
    _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax?,
    _ unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? = nil,
    defaultArgument: InitializerClauseSyntax?,
    _ unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return FunctionParameterSyntax(newData)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return FunctionParameterSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 1)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributesAndModifiers` to replace the node's
  ///                   current `unexpectedBetweenAttributesAndModifiers`, if present.
  public func withUnexpectedBetweenAttributesAndModifiers(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return FunctionParameterSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ModifierListSyntax(childData!)
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
  public func addModifier(_ element: DeclModifierSyntax) -> FunctionParameterSyntax {
    var collection: RawSyntax
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return FunctionParameterSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndFirstName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndFirstName` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndFirstName` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndFirstName`, if present.
  public func withUnexpectedBetweenModifiersAndFirstName(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return FunctionParameterSyntax(newData)
  }

  public var firstName: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFirstNameAndSecondName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFirstNameAndSecondName` replaced.
  /// - param newChild: The new `unexpectedBetweenFirstNameAndSecondName` to replace the node's
  ///                   current `unexpectedBetweenFirstNameAndSecondName`, if present.
  public func withUnexpectedBetweenFirstNameAndSecondName(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return FunctionParameterSyntax(newData)
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSecondNameAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSecondNameAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenSecondNameAndColon` to replace the node's
  ///                   current `unexpectedBetweenSecondNameAndColon`, if present.
  public func withUnexpectedBetweenSecondNameAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return FunctionParameterSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndType` to replace the node's
  ///                   current `unexpectedBetweenColonAndType`, if present.
  public func withUnexpectedBetweenColonAndType(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return FunctionParameterSyntax(newData)
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 11)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAndEllipsis(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAndEllipsis` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAndEllipsis` to replace the node's
  ///                   current `unexpectedBetweenTypeAndEllipsis`, if present.
  public func withUnexpectedBetweenTypeAndEllipsis(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return FunctionParameterSyntax(newData)
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 13)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEllipsisAndDefaultArgument(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEllipsisAndDefaultArgument` replaced.
  /// - param newChild: The new `unexpectedBetweenEllipsisAndDefaultArgument` to replace the node's
  ///                   current `unexpectedBetweenEllipsisAndDefaultArgument`, if present.
  public func withUnexpectedBetweenEllipsisAndDefaultArgument(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return FunctionParameterSyntax(newData)
  }

  public var defaultArgument: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 15)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDefaultArgumentAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDefaultArgumentAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenDefaultArgumentAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenDefaultArgumentAndTrailingComma`, if present.
  public func withUnexpectedBetweenDefaultArgumentAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 16)
    return FunctionParameterSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 17, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 17)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 18, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 18)
    return FunctionParameterSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndFirstName,
      \Self.firstName,
      \Self.unexpectedBetweenFirstNameAndSecondName,
      \Self.secondName,
      \Self.unexpectedBetweenSecondNameAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndType,
      \Self.type,
      \Self.unexpectedBetweenTypeAndEllipsis,
      \Self.ellipsis,
      \Self.unexpectedBetweenEllipsisAndDefaultArgument,
      \Self.defaultArgument,
      \Self.unexpectedBetweenDefaultArgumentAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "attributes"
    case 2:
      return nil
    case 3:
      return "modifiers"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return "internal name"
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return "type"
    case 12:
      return nil
    case 13:
      return nil
    case 14:
      return nil
    case 15:
      return "default argument"
    case 16:
      return nil
    case 17:
      return nil
    case 18:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension FunctionParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndFirstName": unexpectedBetweenModifiersAndFirstName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "firstName": firstName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenFirstNameAndSecondName": unexpectedBetweenFirstNameAndSecondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondName": secondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSecondNameAndColon": unexpectedBetweenSecondNameAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndType": unexpectedBetweenColonAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTypeAndEllipsis": unexpectedBetweenTypeAndEllipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenEllipsisAndDefaultArgument": unexpectedBetweenEllipsisAndDefaultArgument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "defaultArgument": defaultArgument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDefaultArgumentAndTrailingComma": unexpectedBetweenDefaultArgumentAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessLevelModifierSyntax

public struct AccessLevelModifierSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndModifier: UnexpectedNodesSyntax? = nil,
    modifier: DeclModifierDetailSyntax?,
    _ unexpectedAfterModifier: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndModifier?.raw,
      modifier?.raw,
      unexpectedAfterModifier?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessLevelModifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AccessLevelModifierSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AccessLevelModifierSyntax(newData)
  }

  public var unexpectedBetweenNameAndModifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndModifier` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndModifier` to replace the node's
  ///                   current `unexpectedBetweenNameAndModifier`, if present.
  public func withUnexpectedBetweenNameAndModifier(
    _ newChild: UnexpectedNodesSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AccessLevelModifierSyntax(newData)
  }

  public var modifier: DeclModifierDetailSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclModifierDetailSyntax(childData!)
    }
    set(value) {
      self = withModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `modifier` replaced.
  /// - param newChild: The new `modifier` to replace the node's
  ///                   current `modifier`, if present.
  public func withModifier(
    _ newChild: DeclModifierDetailSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return AccessLevelModifierSyntax(newData)
  }

  public var unexpectedAfterModifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterModifier` replaced.
  /// - param newChild: The new `unexpectedAfterModifier` to replace the node's
  ///                   current `unexpectedAfterModifier`, if present.
  public func withUnexpectedAfterModifier(
    _ newChild: UnexpectedNodesSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AccessLevelModifierSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndModifier,
      \Self.modifier,
      \Self.unexpectedAfterModifier,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AccessLevelModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndModifier": unexpectedBetweenNameAndModifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifier": modifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterModifier": unexpectedAfterModifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessPathComponentSyntax

public struct AccessPathComponentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? = nil,
    trailingDot: TokenSyntax?,
    _ unexpectedAfterTrailingDot: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingDot?.raw,
      trailingDot?.raw,
      unexpectedAfterTrailingDot?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPathComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> AccessPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AccessPathComponentSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AccessPathComponentSyntax(newData)
  }

  public var unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndTrailingDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndTrailingDot` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndTrailingDot` to replace the node's
  ///                   current `unexpectedBetweenNameAndTrailingDot`, if present.
  public func withUnexpectedBetweenNameAndTrailingDot(
    _ newChild: UnexpectedNodesSyntax?) -> AccessPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AccessPathComponentSyntax(newData)
  }

  public var trailingDot: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return AccessPathComponentSyntax(newData)
  }

  public var unexpectedAfterTrailingDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingDot` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingDot` to replace the node's
  ///                   current `unexpectedAfterTrailingDot`, if present.
  public func withUnexpectedAfterTrailingDot(
    _ newChild: UnexpectedNodesSyntax?) -> AccessPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AccessPathComponentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndTrailingDot,
      \Self.trailingDot,
      \Self.unexpectedAfterTrailingDot,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AccessPathComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndTrailingDot": unexpectedBetweenNameAndTrailingDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingDot": trailingDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingDot": unexpectedAfterTrailingDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorParameterSyntax

public struct AccessorParameterSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AccessorParameterSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AccessorParameterSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndName` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndName`, if present.
  public func withUnexpectedBetweenLeftParenAndName(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AccessorParameterSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AccessorParameterSyntax(newData)
  }

  public var unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenNameAndRightParen`, if present.
  public func withUnexpectedBetweenNameAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AccessorParameterSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AccessorParameterSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AccessorParameterSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "name"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AccessorParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndName": unexpectedBetweenLeftParenAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndRightParen": unexpectedBetweenNameAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorBlockSyntax

public struct AccessorBlockSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? = nil,
    accessors: AccessorListSyntax,
    _ unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax,
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndAccessors?.raw,
      accessors.raw,
      unexpectedBetweenAccessorsAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftBrace` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftBrace` to replace the node's
  ///                   current `unexpectedBeforeLeftBrace`, if present.
  public func withUnexpectedBeforeLeftBrace(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AccessorBlockSyntax(newData)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AccessorBlockSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBraceAndAccessors(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBraceAndAccessors` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBraceAndAccessors` to replace the node's
  ///                   current `unexpectedBetweenLeftBraceAndAccessors`, if present.
  public func withUnexpectedBetweenLeftBraceAndAccessors(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AccessorBlockSyntax(newData)
  }

  public var accessors: AccessorListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.accessorList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return AccessorBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `accessors` replaced.
  /// - param newChild: The new `accessors` to replace the node's
  ///                   current `accessors`, if present.
  public func withAccessors(
    _ newChild: AccessorListSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessorList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AccessorBlockSyntax(newData)
  }

  public var unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAccessorsAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAccessorsAndRightBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenAccessorsAndRightBrace` to replace the node's
  ///                   current `unexpectedBetweenAccessorsAndRightBrace`, if present.
  public func withUnexpectedBetweenAccessorsAndRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AccessorBlockSyntax(newData)
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AccessorBlockSyntax(newData)
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightBrace` replaced.
  /// - param newChild: The new `unexpectedAfterRightBrace` to replace the node's
  ///                   current `unexpectedAfterRightBrace`, if present.
  public func withUnexpectedAfterRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AccessorBlockSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftBrace,
      \Self.leftBrace,
      \Self.unexpectedBetweenLeftBraceAndAccessors,
      \Self.accessors,
      \Self.unexpectedBetweenAccessorsAndRightBrace,
      \Self.rightBrace,
      \Self.unexpectedAfterRightBrace,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AccessorBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftBrace": unexpectedBeforeLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBraceAndAccessors": unexpectedBetweenLeftBraceAndAccessors.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessors": Syntax(accessors).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAccessorsAndRightBrace": unexpectedBetweenAccessorsAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightBrace": unexpectedAfterRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PatternBindingSyntax

public struct PatternBindingSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Accessor: SyntaxChildChoices {
    case `accessors`(AccessorBlockSyntax)
    case `getter`(CodeBlockSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .accessors(let node): return node._syntaxNode
      case .getter(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: AccessorBlockSyntax) {
      self = .accessors(node)
    }
    public init(_ node: CodeBlockSyntax) {
      self = .getter(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(AccessorBlockSyntax.self) {
        self = .accessors(node)
        return
      }
      if let node = syntaxNode.as(CodeBlockSyntax.self) {
        self = .getter(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(AccessorBlockSyntax.self),
        .node(CodeBlockSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? = nil,
    accessor: Accessor?,
    _ unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBinding,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePattern` replaced.
  /// - param newChild: The new `unexpectedBeforePattern` to replace the node's
  ///                   current `unexpectedBeforePattern`, if present.
  public func withUnexpectedBeforePattern(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PatternBindingSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PatternBindingSyntax(newData)
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndTypeAnnotation` to replace the node's
  ///                   current `unexpectedBetweenPatternAndTypeAnnotation`, if present.
  public func withUnexpectedBetweenPatternAndTypeAnnotation(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PatternBindingSyntax(newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return PatternBindingSyntax(newData)
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAnnotationAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAnnotationAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAnnotationAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenTypeAnnotationAndInitializer`, if present.
  public func withUnexpectedBetweenTypeAnnotationAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PatternBindingSyntax(newData)
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return PatternBindingSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInitializerAndAccessor(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInitializerAndAccessor` replaced.
  /// - param newChild: The new `unexpectedBetweenInitializerAndAccessor` to replace the node's
  ///                   current `unexpectedBetweenInitializerAndAccessor`, if present.
  public func withUnexpectedBetweenInitializerAndAccessor(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PatternBindingSyntax(newData)
  }

  public var accessor: Accessor? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return Accessor(childData!)
    }
    set(value) {
      self = withAccessor(value)
    }
  }

  /// Returns a copy of the receiver with its `accessor` replaced.
  /// - param newChild: The new `accessor` to replace the node's
  ///                   current `accessor`, if present.
  public func withAccessor(
    _ newChild: Accessor?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return PatternBindingSyntax(newData)
  }

  public var unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAccessorAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAccessorAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenAccessorAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenAccessorAndTrailingComma`, if present.
  public func withUnexpectedBetweenAccessorAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return PatternBindingSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return PatternBindingSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return PatternBindingSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndTypeAnnotation,
      \Self.typeAnnotation,
      \Self.unexpectedBetweenTypeAnnotationAndInitializer,
      \Self.initializer,
      \Self.unexpectedBetweenInitializerAndAccessor,
      \Self.accessor,
      \Self.unexpectedBetweenAccessorAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "type annotation"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PatternBindingSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePattern": unexpectedBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndTypeAnnotation": unexpectedBetweenPatternAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTypeAnnotationAndInitializer": unexpectedBetweenTypeAnnotationAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInitializerAndAccessor": unexpectedBetweenInitializerAndAccessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessor": accessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAccessorAndTrailingComma": unexpectedBetweenAccessorAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - EnumCaseElementSyntax

/// 
/// An element of an enum case, containing the name of the case and,
/// optionally, either associated values or an assignment to a raw value.
/// 
public struct EnumCaseElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? = nil,
    associatedValue: ParameterClauseSyntax?,
    _ unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? = nil,
    rawValue: InitializerClauseSyntax?,
    _ unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return EnumCaseElementSyntax(newData)
  }

  /// The name of this case.
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return EnumCaseElementSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndAssociatedValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndAssociatedValue` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndAssociatedValue` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndAssociatedValue`, if present.
  public func withUnexpectedBetweenIdentifierAndAssociatedValue(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return EnumCaseElementSyntax(newData)
  }

  /// The set of associated values of the case.
  public var associatedValue: ParameterClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return EnumCaseElementSyntax(newData)
  }

  public var unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAssociatedValueAndRawValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAssociatedValueAndRawValue` replaced.
  /// - param newChild: The new `unexpectedBetweenAssociatedValueAndRawValue` to replace the node's
  ///                   current `unexpectedBetweenAssociatedValueAndRawValue`, if present.
  public func withUnexpectedBetweenAssociatedValueAndRawValue(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return EnumCaseElementSyntax(newData)
  }

  /// 
  /// The raw value of this enum element, if present.
  /// 
  public var rawValue: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return EnumCaseElementSyntax(newData)
  }

  public var unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRawValueAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRawValueAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenRawValueAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenRawValueAndTrailingComma`, if present.
  public func withUnexpectedBetweenRawValueAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return EnumCaseElementSyntax(newData)
  }

  /// 
  /// The trailing comma of this element, if the case has
  /// multiple elements.
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return EnumCaseElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return EnumCaseElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndAssociatedValue,
      \Self.associatedValue,
      \Self.unexpectedBetweenAssociatedValueAndRawValue,
      \Self.rawValue,
      \Self.unexpectedBetweenRawValueAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "associated values"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension EnumCaseElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndAssociatedValue": unexpectedBetweenIdentifierAndAssociatedValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associatedValue": associatedValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAssociatedValueAndRawValue": unexpectedBetweenAssociatedValueAndRawValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rawValue": rawValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenRawValueAndTrailingComma": unexpectedBetweenRawValueAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DesignatedTypeElementSyntax

public struct DesignatedTypeElementSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DesignatedTypeElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .designatedTypeElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DesignatedTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .designatedTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? = nil,
    leadingComma: TokenSyntax,
    _ unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedAfterName: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeadingComma?.raw,
      leadingComma.raw,
      unexpectedBetweenLeadingCommaAndName?.raw,
      name.raw,
      unexpectedAfterName?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeadingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeadingComma` replaced.
  /// - param newChild: The new `unexpectedBeforeLeadingComma` to replace the node's
  ///                   current `unexpectedBeforeLeadingComma`, if present.
  public func withUnexpectedBeforeLeadingComma(
    _ newChild: UnexpectedNodesSyntax?) -> DesignatedTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DesignatedTypeElementSyntax(newData)
  }

  public var leadingComma: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeadingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `leadingComma` replaced.
  /// - param newChild: The new `leadingComma` to replace the node's
  ///                   current `leadingComma`, if present.
  public func withLeadingComma(
    _ newChild: TokenSyntax?) -> DesignatedTypeElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DesignatedTypeElementSyntax(newData)
  }

  public var unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeadingCommaAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeadingCommaAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenLeadingCommaAndName` to replace the node's
  ///                   current `unexpectedBetweenLeadingCommaAndName`, if present.
  public func withUnexpectedBetweenLeadingCommaAndName(
    _ newChild: UnexpectedNodesSyntax?) -> DesignatedTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DesignatedTypeElementSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> DesignatedTypeElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DesignatedTypeElementSyntax(newData)
  }

  public var unexpectedAfterName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterName` replaced.
  /// - param newChild: The new `unexpectedAfterName` to replace the node's
  ///                   current `unexpectedAfterName`, if present.
  public func withUnexpectedAfterName(
    _ newChild: UnexpectedNodesSyntax?) -> DesignatedTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DesignatedTypeElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeadingComma,
      \Self.leadingComma,
      \Self.unexpectedBetweenLeadingCommaAndName,
      \Self.name,
      \Self.unexpectedAfterName,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DesignatedTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeadingComma": unexpectedBeforeLeadingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leadingComma": Syntax(leadingComma).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeadingCommaAndName": unexpectedBetweenLeadingCommaAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterName": unexpectedAfterName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OperatorPrecedenceAndTypesSyntax

/// 
/// A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.
/// 
public struct OperatorPrecedenceAndTypesSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? = nil,
    precedenceGroup: TokenSyntax,
    _ unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? = nil,
    designatedTypes: DesignatedTypeListSyntax,
    _ unexpectedAfterDesignatedTypes: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndPrecedenceGroup?.raw,
      precedenceGroup.raw,
      unexpectedBetweenPrecedenceGroupAndDesignatedTypes?.raw,
      designatedTypes.raw,
      unexpectedAfterDesignatedTypes?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorPrecedenceAndTypes,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeColon` replaced.
  /// - param newChild: The new `unexpectedBeforeColon` to replace the node's
  ///                   current `unexpectedBeforeColon`, if present.
  public func withUnexpectedBeforeColon(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public var unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndPrecedenceGroup(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndPrecedenceGroup` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndPrecedenceGroup` to replace the node's
  ///                   current `unexpectedBetweenColonAndPrecedenceGroup`, if present.
  public func withUnexpectedBetweenColonAndPrecedenceGroup(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  /// 
  /// The precedence group for this operator
  /// 
  public var precedenceGroup: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPrecedenceGroup(value)
    }
  }

  /// Returns a copy of the receiver with its `precedenceGroup` replaced.
  /// - param newChild: The new `precedenceGroup` to replace the node's
  ///                   current `precedenceGroup`, if present.
  public func withPrecedenceGroup(
    _ newChild: TokenSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public var unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPrecedenceGroupAndDesignatedTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPrecedenceGroupAndDesignatedTypes` replaced.
  /// - param newChild: The new `unexpectedBetweenPrecedenceGroupAndDesignatedTypes` to replace the node's
  ///                   current `unexpectedBetweenPrecedenceGroupAndDesignatedTypes`, if present.
  public func withUnexpectedBetweenPrecedenceGroupAndDesignatedTypes(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  /// 
  /// The designated types associated with this operator.
  /// 
  public var designatedTypes: DesignatedTypeListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return DesignatedTypeListSyntax(childData!)
    }
    set(value) {
      self = withDesignatedTypes(value)
    }
  }

  /// Adds the provided `DesignatedTypeElement` to the node's `designatedTypes`
  /// collection.
  /// - param element: The new `DesignatedTypeElement` to add to the node's
  ///                  `designatedTypes` collection.
  /// - returns: A copy of the receiver with the provided `DesignatedTypeElement`
  ///            appended to its `designatedTypes` collection.
  public func addDesignatedTypeElement(_ element: DesignatedTypeElementSyntax) -> OperatorPrecedenceAndTypesSyntax {
    var collection: RawSyntax
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  /// Returns a copy of the receiver with its `designatedTypes` replaced.
  /// - param newChild: The new `designatedTypes` to replace the node's
  ///                   current `designatedTypes`, if present.
  public func withDesignatedTypes(
    _ newChild: DesignatedTypeListSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.designatedTypeList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public var unexpectedAfterDesignatedTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDesignatedTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDesignatedTypes` replaced.
  /// - param newChild: The new `unexpectedAfterDesignatedTypes` to replace the node's
  ///                   current `unexpectedAfterDesignatedTypes`, if present.
  public func withUnexpectedAfterDesignatedTypes(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndPrecedenceGroup,
      \Self.precedenceGroup,
      \Self.unexpectedBetweenPrecedenceGroupAndDesignatedTypes,
      \Self.designatedTypes,
      \Self.unexpectedAfterDesignatedTypes,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "precedence group"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension OperatorPrecedenceAndTypesSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeColon": unexpectedBeforeColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndPrecedenceGroup": unexpectedBetweenColonAndPrecedenceGroup.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "precedenceGroup": Syntax(precedenceGroup).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPrecedenceGroupAndDesignatedTypes": unexpectedBetweenPrecedenceGroupAndDesignatedTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "designatedTypes": Syntax(designatedTypes).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterDesignatedTypes": unexpectedAfterDesignatedTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupRelationSyntax

/// 
/// Specify the new precedence group's relation to existing precedence
/// groups.
/// 
public struct PrecedenceGroupRelationSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? = nil,
    higherThanOrLowerThan: TokenSyntax,
    _ unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? = nil,
    otherNames: PrecedenceGroupNameListSyntax,
    _ unexpectedAfterOtherNames: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeHigherThanOrLowerThan?.raw,
      higherThanOrLowerThan.raw,
      unexpectedBetweenHigherThanOrLowerThanAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndOtherNames?.raw,
      otherNames.raw,
      unexpectedAfterOtherNames?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupRelation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeHigherThanOrLowerThan(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeHigherThanOrLowerThan` replaced.
  /// - param newChild: The new `unexpectedBeforeHigherThanOrLowerThan` to replace the node's
  ///                   current `unexpectedBeforeHigherThanOrLowerThan`, if present.
  public func withUnexpectedBeforeHigherThanOrLowerThan(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrecedenceGroupRelationSyntax(newData)
  }

  /// 
  /// The relation to specified other precedence groups.
  /// 
  public var higherThanOrLowerThan: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public var unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenHigherThanOrLowerThanAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenHigherThanOrLowerThanAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenHigherThanOrLowerThanAndColon` to replace the node's
  ///                   current `unexpectedBetweenHigherThanOrLowerThanAndColon`, if present.
  public func withUnexpectedBetweenHigherThanOrLowerThanAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public var unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndOtherNames(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndOtherNames` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndOtherNames` to replace the node's
  ///                   current `unexpectedBetweenColonAndOtherNames`, if present.
  public func withUnexpectedBetweenColonAndOtherNames(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PrecedenceGroupRelationSyntax(newData)
  }

  /// 
  /// The name of other precedence group to which this precedence
  /// group relates.
  /// 
  public var otherNames: PrecedenceGroupNameListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return PrecedenceGroupRelationSyntax(newData)
  }

  /// Returns a copy of the receiver with its `otherNames` replaced.
  /// - param newChild: The new `otherNames` to replace the node's
  ///                   current `otherNames`, if present.
  public func withOtherNames(
    _ newChild: PrecedenceGroupNameListSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupNameList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public var unexpectedAfterOtherNames: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterOtherNames(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterOtherNames` replaced.
  /// - param newChild: The new `unexpectedAfterOtherNames` to replace the node's
  ///                   current `unexpectedAfterOtherNames`, if present.
  public func withUnexpectedAfterOtherNames(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeHigherThanOrLowerThan,
      \Self.higherThanOrLowerThan,
      \Self.unexpectedBetweenHigherThanOrLowerThanAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndOtherNames,
      \Self.otherNames,
      \Self.unexpectedAfterOtherNames,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrecedenceGroupRelationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeHigherThanOrLowerThan": unexpectedBeforeHigherThanOrLowerThan.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "higherThanOrLowerThan": Syntax(higherThanOrLowerThan).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenHigherThanOrLowerThanAndColon": unexpectedBetweenHigherThanOrLowerThanAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndOtherNames": unexpectedBetweenColonAndOtherNames.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "otherNames": Syntax(otherNames).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterOtherNames": unexpectedAfterOtherNames.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupNameElementSyntax

public struct PrecedenceGroupNameElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupNameElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenNameAndTrailingComma`, if present.
  public func withUnexpectedBetweenNameAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupNameElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupNameElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrecedenceGroupNameElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndTrailingComma": unexpectedBetweenNameAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupAssignmentSyntax

/// 
/// Specifies the precedence of an operator when used in an operation
/// that includes optional chaining.
/// 
public struct PrecedenceGroupAssignmentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? = nil,
    assignmentKeyword: TokenSyntax,
    _ unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? = nil,
    flag: TokenSyntax,
    _ unexpectedAfterFlag: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignmentKeyword?.raw,
      assignmentKeyword.raw,
      unexpectedBetweenAssignmentKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndFlag?.raw,
      flag.raw,
      unexpectedAfterFlag?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssignment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAssignmentKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAssignmentKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeAssignmentKeyword` to replace the node's
  ///                   current `unexpectedBeforeAssignmentKeyword`, if present.
  public func withUnexpectedBeforeAssignmentKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public var assignmentKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public var unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAssignmentKeywordAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAssignmentKeywordAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenAssignmentKeywordAndColon` to replace the node's
  ///                   current `unexpectedBetweenAssignmentKeywordAndColon`, if present.
  public func withUnexpectedBetweenAssignmentKeywordAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public var unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndFlag(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndFlag` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndFlag` to replace the node's
  ///                   current `unexpectedBetweenColonAndFlag`, if present.
  public func withUnexpectedBetweenColonAndFlag(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
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
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public var unexpectedAfterFlag: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterFlag(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterFlag` replaced.
  /// - param newChild: The new `unexpectedAfterFlag` to replace the node's
  ///                   current `unexpectedAfterFlag`, if present.
  public func withUnexpectedAfterFlag(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAssignmentKeyword,
      \Self.assignmentKeyword,
      \Self.unexpectedBetweenAssignmentKeywordAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndFlag,
      \Self.flag,
      \Self.unexpectedAfterFlag,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrecedenceGroupAssignmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAssignmentKeyword": unexpectedBeforeAssignmentKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignmentKeyword": Syntax(assignmentKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAssignmentKeywordAndColon": unexpectedBetweenAssignmentKeywordAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndFlag": unexpectedBetweenColonAndFlag.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "flag": Syntax(flag).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterFlag": unexpectedAfterFlag.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupAssociativitySyntax

/// 
/// Specifies how a sequence of operators with the same precedence level
/// are grouped together in the absence of grouping parentheses.
/// 
public struct PrecedenceGroupAssociativitySyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? = nil,
    associativityKeyword: TokenSyntax,
    _ unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: TokenSyntax,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssociativityKeyword?.raw,
      associativityKeyword.raw,
      unexpectedBetweenAssociativityKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssociativity,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAssociativityKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAssociativityKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeAssociativityKeyword` to replace the node's
  ///                   current `unexpectedBeforeAssociativityKeyword`, if present.
  public func withUnexpectedBeforeAssociativityKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public var associativityKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public var unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAssociativityKeywordAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAssociativityKeywordAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenAssociativityKeywordAndColon` to replace the node's
  ///                   current `unexpectedBetweenAssociativityKeywordAndColon`, if present.
  public func withUnexpectedBetweenAssociativityKeywordAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndValue` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndValue` to replace the node's
  ///                   current `unexpectedBetweenColonAndValue`, if present.
  public func withUnexpectedBetweenColonAndValue(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
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
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValue` replaced.
  /// - param newChild: The new `unexpectedAfterValue` to replace the node's
  ///                   current `unexpectedAfterValue`, if present.
  public func withUnexpectedAfterValue(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAssociativityKeyword,
      \Self.associativityKeyword,
      \Self.unexpectedBetweenAssociativityKeywordAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndValue,
      \Self.value,
      \Self.unexpectedAfterValue,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrecedenceGroupAssociativitySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAssociativityKeyword": unexpectedBeforeAssociativityKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associativityKeyword": Syntax(associativityKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAssociativityKeywordAndColon": unexpectedBetweenAssociativityKeywordAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndValue": unexpectedBetweenColonAndValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValue": unexpectedAfterValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CustomAttributeSyntax

/// 
/// A custom `@` attribute.
/// 
public struct CustomAttributeSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil,
    atSignToken: TokenSyntax,
    _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil,
    attributeName: TypeSyntax,
    _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax?,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.customAttribute,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAtSignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAtSignToken` replaced.
  /// - param newChild: The new `unexpectedBeforeAtSignToken` to replace the node's
  ///                   current `unexpectedBeforeAtSignToken`, if present.
  public func withUnexpectedBeforeAtSignToken(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CustomAttributeSyntax(newData)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CustomAttributeSyntax(newData)
  }

  public var unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAtSignTokenAndAttributeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAtSignTokenAndAttributeName` replaced.
  /// - param newChild: The new `unexpectedBetweenAtSignTokenAndAttributeName` to replace the node's
  ///                   current `unexpectedBetweenAtSignTokenAndAttributeName`, if present.
  public func withUnexpectedBetweenAtSignTokenAndAttributeName(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CustomAttributeSyntax(newData)
  }

  /// The name of the attribute.
  public var attributeName: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return CustomAttributeSyntax(newData)
  }

  public var unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributeNameAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributeNameAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributeNameAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenAttributeNameAndLeftParen`, if present.
  public func withUnexpectedBetweenAttributeNameAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CustomAttributeSyntax(newData)
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return CustomAttributeSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndArgumentList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndArgumentList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndArgumentList` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndArgumentList`, if present.
  public func withUnexpectedBetweenLeftParenAndArgumentList(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CustomAttributeSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[7] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 7)
    return CustomAttributeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: TupleExprElementListSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return CustomAttributeSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentListAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentListAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenArgumentListAndRightParen`, if present.
  public func withUnexpectedBetweenArgumentListAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return CustomAttributeSyntax(newData)
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return CustomAttributeSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return CustomAttributeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAtSignToken,
      \Self.atSignToken,
      \Self.unexpectedBetweenAtSignTokenAndAttributeName,
      \Self.attributeName,
      \Self.unexpectedBetweenAttributeNameAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArgumentList,
      \Self.argumentList,
      \Self.unexpectedBetweenArgumentListAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "name"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CustomAttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAtSignToken": unexpectedBeforeAtSignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAtSignTokenAndAttributeName": unexpectedBetweenAtSignTokenAndAttributeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAttributeNameAndLeftParen": unexpectedBetweenAttributeNameAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndArgumentList": unexpectedBetweenLeftParenAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": argumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenArgumentListAndRightParen": unexpectedBetweenArgumentListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AttributeSyntax

/// 
/// An `@` attribute.
/// 
public struct AttributeSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Argument: SyntaxChildChoices {
    case `identifier`(TokenSyntax)
    case `string`(TokenSyntax)
    case `integer`(TokenSyntax)
    case `availability`(AvailabilitySpecListSyntax)
    case `specializeArguments`(SpecializeAttributeSpecListSyntax)
    case `objCName`(ObjCSelectorSyntax)
    case `implementsArguments`(ImplementsAttributeArgumentsSyntax)
    case `differentiableArguments`(DifferentiableAttributeArgumentsSyntax)
    case `derivativeRegistrationArguments`(DerivativeRegistrationAttributeArgumentsSyntax)
    case `namedAttributeString`(NamedAttributeStringArgumentSyntax)
    case `backDeployArguments`(BackDeployAttributeSpecListSyntax)
    case `conventionArguments`(ConventionAttributeArgumentsSyntax)
    case `conventionWitnessMethodArguments`(ConventionWitnessMethodAttributeArgumentsSyntax)
    case `tokenList`(TokenListSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .identifier(let node): return node._syntaxNode
      case .string(let node): return node._syntaxNode
      case .integer(let node): return node._syntaxNode
      case .availability(let node): return node._syntaxNode
      case .specializeArguments(let node): return node._syntaxNode
      case .objCName(let node): return node._syntaxNode
      case .implementsArguments(let node): return node._syntaxNode
      case .differentiableArguments(let node): return node._syntaxNode
      case .derivativeRegistrationArguments(let node): return node._syntaxNode
      case .namedAttributeString(let node): return node._syntaxNode
      case .backDeployArguments(let node): return node._syntaxNode
      case .conventionArguments(let node): return node._syntaxNode
      case .conventionWitnessMethodArguments(let node): return node._syntaxNode
      case .tokenList(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: AvailabilitySpecListSyntax) {
      self = .availability(node)
    }
    public init(_ node: SpecializeAttributeSpecListSyntax) {
      self = .specializeArguments(node)
    }
    public init(_ node: ObjCSelectorSyntax) {
      self = .objCName(node)
    }
    public init(_ node: ImplementsAttributeArgumentsSyntax) {
      self = .implementsArguments(node)
    }
    public init(_ node: DifferentiableAttributeArgumentsSyntax) {
      self = .differentiableArguments(node)
    }
    public init(_ node: DerivativeRegistrationAttributeArgumentsSyntax) {
      self = .derivativeRegistrationArguments(node)
    }
    public init(_ node: NamedAttributeStringArgumentSyntax) {
      self = .namedAttributeString(node)
    }
    public init(_ node: BackDeployAttributeSpecListSyntax) {
      self = .backDeployArguments(node)
    }
    public init(_ node: ConventionAttributeArgumentsSyntax) {
      self = .conventionArguments(node)
    }
    public init(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) {
      self = .conventionWitnessMethodArguments(node)
    }
    public init(_ node: TokenListSyntax) {
      self = .tokenList(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .identifier: self = .identifier(tok)
        case .stringLiteral: self = .string(tok)
        case .integerLiteral: self = .integer(tok)
        default: return nil
        }
        return
      }
      if let node = syntaxNode.as(AvailabilitySpecListSyntax.self) {
        self = .availability(node)
        return
      }
      if let node = syntaxNode.as(SpecializeAttributeSpecListSyntax.self) {
        self = .specializeArguments(node)
        return
      }
      if let node = syntaxNode.as(ObjCSelectorSyntax.self) {
        self = .objCName(node)
        return
      }
      if let node = syntaxNode.as(ImplementsAttributeArgumentsSyntax.self) {
        self = .implementsArguments(node)
        return
      }
      if let node = syntaxNode.as(DifferentiableAttributeArgumentsSyntax.self) {
        self = .differentiableArguments(node)
        return
      }
      if let node = syntaxNode.as(DerivativeRegistrationAttributeArgumentsSyntax.self) {
        self = .derivativeRegistrationArguments(node)
        return
      }
      if let node = syntaxNode.as(NamedAttributeStringArgumentSyntax.self) {
        self = .namedAttributeString(node)
        return
      }
      if let node = syntaxNode.as(BackDeployAttributeSpecListSyntax.self) {
        self = .backDeployArguments(node)
        return
      }
      if let node = syntaxNode.as(ConventionAttributeArgumentsSyntax.self) {
        self = .conventionArguments(node)
        return
      }
      if let node = syntaxNode.as(ConventionWitnessMethodAttributeArgumentsSyntax.self) {
        self = .conventionWitnessMethodArguments(node)
        return
      }
      if let node = syntaxNode.as(TokenListSyntax.self) {
        self = .tokenList(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.identifier("")),
        .token(.stringLiteral("")),
        .token(.integerLiteral("")),
        .node(AvailabilitySpecListSyntax.self),
        .node(SpecializeAttributeSpecListSyntax.self),
        .node(ObjCSelectorSyntax.self),
        .node(ImplementsAttributeArgumentsSyntax.self),
        .node(DifferentiableAttributeArgumentsSyntax.self),
        .node(DerivativeRegistrationAttributeArgumentsSyntax.self),
        .node(NamedAttributeStringArgumentSyntax.self),
        .node(BackDeployAttributeSpecListSyntax.self),
        .node(ConventionAttributeArgumentsSyntax.self),
        .node(ConventionWitnessMethodAttributeArgumentsSyntax.self),
        .node(TokenListSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil,
    atSignToken: TokenSyntax,
    _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil,
    attributeName: TokenSyntax,
    _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? = nil,
    argument: Argument?,
    _ unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedBetweenRightParenAndTokenList: UnexpectedNodesSyntax? = nil,
    tokenList: TokenListSyntax?,
    _ unexpectedAfterTokenList: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.attribute,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAtSignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAtSignToken` replaced.
  /// - param newChild: The new `unexpectedBeforeAtSignToken` to replace the node's
  ///                   current `unexpectedBeforeAtSignToken`, if present.
  public func withUnexpectedBeforeAtSignToken(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AttributeSyntax(newData)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AttributeSyntax(newData)
  }

  public var unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAtSignTokenAndAttributeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAtSignTokenAndAttributeName` replaced.
  /// - param newChild: The new `unexpectedBetweenAtSignTokenAndAttributeName` to replace the node's
  ///                   current `unexpectedBetweenAtSignTokenAndAttributeName`, if present.
  public func withUnexpectedBetweenAtSignTokenAndAttributeName(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AttributeSyntax(newData)
  }

  /// The name of the attribute.
  public var attributeName: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AttributeSyntax(newData)
  }

  public var unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributeNameAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributeNameAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributeNameAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenAttributeNameAndLeftParen`, if present.
  public func withUnexpectedBetweenAttributeNameAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AttributeSyntax(newData)
  }

  /// 
  /// If the attribute takes arguments, the opening parenthesis.
  /// 
  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return AttributeSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndArgument(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndArgument` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndArgument` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndArgument`, if present.
  public func withUnexpectedBetweenLeftParenAndArgument(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AttributeSyntax(newData)
  }

  /// 
  /// The arguments of the attribute. In case the attribute
  /// takes multiple arguments, they are gather in the
  /// appropriate takes first.
  /// 
  public var argument: Argument? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return Argument(childData!)
    }
    set(value) {
      self = withArgument(value)
    }
  }

  /// Returns a copy of the receiver with its `argument` replaced.
  /// - param newChild: The new `argument` to replace the node's
  ///                   current `argument`, if present.
  public func withArgument(
    _ newChild: Argument?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return AttributeSyntax(newData)
  }

  public var unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenArgumentAndRightParen`, if present.
  public func withUnexpectedBetweenArgumentAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return AttributeSyntax(newData)
  }

  /// 
  /// If the attribute takes arguments, the closing parenthesis.
  /// 
  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return AttributeSyntax(newData)
  }

  public var unexpectedBetweenRightParenAndTokenList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRightParenAndTokenList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRightParenAndTokenList` replaced.
  /// - param newChild: The new `unexpectedBetweenRightParenAndTokenList` to replace the node's
  ///                   current `unexpectedBetweenRightParenAndTokenList`, if present.
  public func withUnexpectedBetweenRightParenAndTokenList(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return AttributeSyntax(newData)
  }

  public var tokenList: TokenListSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[11] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tokenList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 11)
    return AttributeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `tokenList` replaced.
  /// - param newChild: The new `tokenList` to replace the node's
  ///                   current `tokenList`, if present.
  public func withTokenList(
    _ newChild: TokenListSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 11)
    return AttributeSyntax(newData)
  }

  public var unexpectedAfterTokenList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTokenList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTokenList` replaced.
  /// - param newChild: The new `unexpectedAfterTokenList` to replace the node's
  ///                   current `unexpectedAfterTokenList`, if present.
  public func withUnexpectedAfterTokenList(
    _ newChild: UnexpectedNodesSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return AttributeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAtSignToken,
      \Self.atSignToken,
      \Self.unexpectedBetweenAtSignTokenAndAttributeName,
      \Self.attributeName,
      \Self.unexpectedBetweenAttributeNameAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArgument,
      \Self.argument,
      \Self.unexpectedBetweenArgumentAndRightParen,
      \Self.rightParen,
      \Self.unexpectedBetweenRightParenAndTokenList,
      \Self.tokenList,
      \Self.unexpectedAfterTokenList,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "name"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAtSignToken": unexpectedBeforeAtSignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAtSignTokenAndAttributeName": unexpectedBetweenAtSignTokenAndAttributeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAttributeNameAndLeftParen": unexpectedBetweenAttributeNameAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndArgument": unexpectedBetweenLeftParenAndArgument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argument": argument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenArgumentAndRightParen": unexpectedBetweenArgumentAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenRightParenAndTokenList": unexpectedBetweenRightParenAndTokenList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "tokenList": tokenList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTokenList": unexpectedAfterTokenList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityEntrySyntax

/// 
/// The availability argument for the _specialize attribute
/// 
public struct AvailabilityEntrySyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? = nil,
    availabilityList: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax,
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AvailabilityEntrySyntax(newData)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AvailabilityEntrySyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AvailabilityEntrySyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AvailabilityEntrySyntax(newData)
  }

  public var unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndAvailabilityList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndAvailabilityList` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndAvailabilityList` to replace the node's
  ///                   current `unexpectedBetweenColonAndAvailabilityList`, if present.
  public func withUnexpectedBetweenColonAndAvailabilityList(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AvailabilityEntrySyntax(newData)
  }

  public var availabilityList: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return AvailabilityEntrySyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilityList` replaced.
  /// - param newChild: The new `availabilityList` to replace the node's
  ///                   current `availabilityList`, if present.
  public func withAvailabilityList(
    _ newChild: AvailabilitySpecListSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AvailabilityEntrySyntax(newData)
  }

  public var unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAvailabilityListAndSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAvailabilityListAndSemicolon` replaced.
  /// - param newChild: The new `unexpectedBetweenAvailabilityListAndSemicolon` to replace the node's
  ///                   current `unexpectedBetweenAvailabilityListAndSemicolon`, if present.
  public func withUnexpectedBetweenAvailabilityListAndSemicolon(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AvailabilityEntrySyntax(newData)
  }

  public var semicolon: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.semicolon, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return AvailabilityEntrySyntax(newData)
  }

  public var unexpectedAfterSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterSemicolon` replaced.
  /// - param newChild: The new `unexpectedAfterSemicolon` to replace the node's
  ///                   current `unexpectedAfterSemicolon`, if present.
  public func withUnexpectedAfterSemicolon(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return AvailabilityEntrySyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndAvailabilityList,
      \Self.availabilityList,
      \Self.unexpectedBetweenAvailabilityListAndSemicolon,
      \Self.semicolon,
      \Self.unexpectedAfterSemicolon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AvailabilityEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndAvailabilityList": unexpectedBetweenColonAndAvailabilityList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "availabilityList": Syntax(availabilityList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAvailabilityListAndSemicolon": unexpectedBetweenAvailabilityListAndSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": Syntax(semicolon).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterSemicolon": unexpectedAfterSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - LabeledSpecializeEntrySyntax

/// 
/// A labeled argument for the `@_specialize` attribute like
/// `exported: true`
/// 
public struct LabeledSpecializeEntrySyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: TokenSyntax,
    _ unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.labeledSpecializeEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return LabeledSpecializeEntrySyntax(newData)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return LabeledSpecializeEntrySyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return LabeledSpecializeEntrySyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return LabeledSpecializeEntrySyntax(newData)
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndValue` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndValue` to replace the node's
  ///                   current `unexpectedBetweenColonAndValue`, if present.
  public func withUnexpectedBetweenColonAndValue(
    _ newChild: UnexpectedNodesSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return LabeledSpecializeEntrySyntax(newData)
  }

  /// The value for this argument
  public var value: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return LabeledSpecializeEntrySyntax(newData)
  }

  public var unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenValueAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenValueAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenValueAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenValueAndTrailingComma`, if present.
  public func withUnexpectedBetweenValueAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return LabeledSpecializeEntrySyntax(newData)
  }

  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return LabeledSpecializeEntrySyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return LabeledSpecializeEntrySyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndValue,
      \Self.value,
      \Self.unexpectedBetweenValueAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "value"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension LabeledSpecializeEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndValue": unexpectedBetweenColonAndValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenValueAndTrailingComma": unexpectedBetweenValueAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? = nil,
    declname: DeclNameSyntax,
    _ unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.targetFunctionEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TargetFunctionEntrySyntax(newData)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return TargetFunctionEntrySyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TargetFunctionEntrySyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return TargetFunctionEntrySyntax(newData)
  }

  public var unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndDeclname(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndDeclname` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndDeclname` to replace the node's
  ///                   current `unexpectedBetweenColonAndDeclname`, if present.
  public func withUnexpectedBetweenColonAndDeclname(
    _ newChild: UnexpectedNodesSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TargetFunctionEntrySyntax(newData)
  }

  /// The value for this argument
  public var declname: DeclNameSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return DeclNameSyntax(childData!)
    }
    set(value) {
      self = withDeclname(value)
    }
  }

  /// Returns a copy of the receiver with its `declname` replaced.
  /// - param newChild: The new `declname` to replace the node's
  ///                   current `declname`, if present.
  public func withDeclname(
    _ newChild: DeclNameSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.declName, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return TargetFunctionEntrySyntax(newData)
  }

  public var unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeclnameAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeclnameAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenDeclnameAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenDeclnameAndTrailingComma`, if present.
  public func withUnexpectedBetweenDeclnameAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return TargetFunctionEntrySyntax(newData)
  }

  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return TargetFunctionEntrySyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return TargetFunctionEntrySyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndDeclname,
      \Self.declname,
      \Self.unexpectedBetweenDeclnameAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "declaration name"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TargetFunctionEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndDeclname": unexpectedBetweenColonAndDeclname.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declname": Syntax(declname).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDeclnameAndTrailingComma": unexpectedBetweenDeclnameAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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
  public enum StringOrDeclname: SyntaxChildChoices {
    case `string`(TokenSyntax)
    case `declname`(DeclNameSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .string(let node): return node._syntaxNode
      case .declname(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: DeclNameSyntax) {
      self = .declname(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .stringLiteral: self = .string(tok)
        default: return nil
        }
        return
      }
      if let node = syntaxNode.as(DeclNameSyntax.self) {
        self = .declname(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.stringLiteral("")),
        .node(DeclNameSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeNameTok: UnexpectedNodesSyntax? = nil,
    nameTok: TokenSyntax,
    _ unexpectedBetweenNameTokAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndStringOrDeclname: UnexpectedNodesSyntax? = nil,
    stringOrDeclname: StringOrDeclname,
    _ unexpectedAfterStringOrDeclname: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNameTok?.raw,
      nameTok.raw,
      unexpectedBetweenNameTokAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndStringOrDeclname?.raw,
      stringOrDeclname.raw,
      unexpectedAfterStringOrDeclname?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedAttributeStringArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeNameTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeNameTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeNameTok` replaced.
  /// - param newChild: The new `unexpectedBeforeNameTok` to replace the node's
  ///                   current `unexpectedBeforeNameTok`, if present.
  public func withUnexpectedBeforeNameTok(
    _ newChild: UnexpectedNodesSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  /// The label of the argument
  public var nameTok: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  public var unexpectedBetweenNameTokAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameTokAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameTokAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenNameTokAndColon` to replace the node's
  ///                   current `unexpectedBetweenNameTokAndColon`, if present.
  public func withUnexpectedBetweenNameTokAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  public var unexpectedBetweenColonAndStringOrDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndStringOrDeclname(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndStringOrDeclname` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndStringOrDeclname` to replace the node's
  ///                   current `unexpectedBetweenColonAndStringOrDeclname`, if present.
  public func withUnexpectedBetweenColonAndStringOrDeclname(
    _ newChild: UnexpectedNodesSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  public var stringOrDeclname: StringOrDeclname {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringOrDeclname(childData!)
    }
    set(value) {
      self = withStringOrDeclname(value)
    }
  }

  /// Returns a copy of the receiver with its `stringOrDeclname` replaced.
  /// - param newChild: The new `stringOrDeclname` to replace the node's
  ///                   current `stringOrDeclname`, if present.
  public func withStringOrDeclname(
    _ newChild: StringOrDeclname?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  public var unexpectedAfterStringOrDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterStringOrDeclname(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterStringOrDeclname` replaced.
  /// - param newChild: The new `unexpectedAfterStringOrDeclname` to replace the node's
  ///                   current `unexpectedAfterStringOrDeclname`, if present.
  public func withUnexpectedAfterStringOrDeclname(
    _ newChild: UnexpectedNodesSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeNameTok,
      \Self.nameTok,
      \Self.unexpectedBetweenNameTokAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndStringOrDeclname,
      \Self.stringOrDeclname,
      \Self.unexpectedAfterStringOrDeclname,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "value"
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension NamedAttributeStringArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeNameTok": unexpectedBeforeNameTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "nameTok": Syntax(nameTok).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameTokAndColon": unexpectedBetweenNameTokAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndStringOrDeclname": unexpectedBetweenColonAndStringOrDeclname.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "stringOrDeclname": Syntax(stringOrDeclname).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterStringOrDeclname": unexpectedAfterStringOrDeclname.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameSyntax

public struct DeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  public enum DeclBaseName: SyntaxChildChoices {
    case `identifier`(TokenSyntax)
    case `operator`(TokenSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .identifier(let node): return node._syntaxNode
      case .operator(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .identifier: self = .identifier(tok)
        case .prefixOperator: self = .operator(tok)
        default: return nil
        }
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.identifier("")),
        .token(.prefixOperator("")),
      ])
    }
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

  public init(
    _ unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? = nil,
    declBaseName: DeclBaseName,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?,
    _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeclBaseName?.raw,
      declBaseName.raw,
      unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedAfterDeclNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeDeclBaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeDeclBaseName` replaced.
  /// - param newChild: The new `unexpectedBeforeDeclBaseName` to replace the node's
  ///                   current `unexpectedBeforeDeclBaseName`, if present.
  public func withUnexpectedBeforeDeclBaseName(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DeclNameSyntax(newData)
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: DeclBaseName {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return DeclBaseName(childData!)
    }
    set(value) {
      self = withDeclBaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `declBaseName` replaced.
  /// - param newChild: The new `declBaseName` to replace the node's
  ///                   current `declBaseName`, if present.
  public func withDeclBaseName(
    _ newChild: DeclBaseName?) -> DeclNameSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DeclNameSyntax(newData)
  }

  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeclBaseNameAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeclBaseNameAndDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenDeclBaseNameAndDeclNameArguments` to replace the node's
  ///                   current `unexpectedBetweenDeclBaseNameAndDeclNameArguments`, if present.
  public func withUnexpectedBetweenDeclBaseNameAndDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DeclNameSyntax(newData)
  }

  /// 
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return DeclNameSyntax(newData)
  }

  public var unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedAfterDeclNameArguments` to replace the node's
  ///                   current `unexpectedAfterDeclNameArguments`, if present.
  public func withUnexpectedAfterDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> DeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DeclNameSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeDeclBaseName,
      \Self.declBaseName,
      \Self.unexpectedBetweenDeclBaseNameAndDeclNameArguments,
      \Self.declNameArguments,
      \Self.unexpectedAfterDeclNameArguments,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "base name"
    case 2:
      return nil
    case 3:
      return "arguments"
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeDeclBaseName": unexpectedBeforeDeclBaseName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDeclBaseNameAndDeclNameArguments": unexpectedBetweenDeclBaseNameAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterDeclNameArguments": unexpectedAfterDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImplementsAttributeArgumentsSyntax

/// 
/// The arguments for the `@_implements` attribute of the form
/// `Type, methodName(arg1Label:arg2Label:)`
/// 
public struct ImplementsAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax,
    _ unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax,
    _ unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? = nil,
    declBaseName: TokenSyntax,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?,
    _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.implementsAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeType` replaced.
  /// - param newChild: The new `unexpectedBeforeType` to replace the node's
  ///                   current `unexpectedBeforeType`, if present.
  public func withUnexpectedBeforeType(
    _ newChild: UnexpectedNodesSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The type for which the method with this attribute
  /// implements a requirement.
  /// 
  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAndComma` to replace the node's
  ///                   current `unexpectedBetweenTypeAndComma`, if present.
  public func withUnexpectedBetweenTypeAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The comma separating the type and method name
  /// 
  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndDeclBaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndDeclBaseName` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndDeclBaseName` to replace the node's
  ///                   current `unexpectedBetweenCommaAndDeclBaseName`, if present.
  public func withUnexpectedBetweenCommaAndDeclBaseName(
    _ newChild: UnexpectedNodesSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDeclBaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `declBaseName` replaced.
  /// - param newChild: The new `declBaseName` to replace the node's
  ///                   current `declBaseName`, if present.
  public func withDeclBaseName(
    _ newChild: TokenSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeclBaseNameAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeclBaseNameAndDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenDeclBaseNameAndDeclNameArguments` to replace the node's
  ///                   current `unexpectedBetweenDeclBaseNameAndDeclNameArguments`, if present.
  public func withUnexpectedBetweenDeclBaseNameAndDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedAfterDeclNameArguments` to replace the node's
  ///                   current `unexpectedAfterDeclNameArguments`, if present.
  public func withUnexpectedAfterDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeType,
      \Self.type,
      \Self.unexpectedBetweenTypeAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndDeclBaseName,
      \Self.declBaseName,
      \Self.unexpectedBetweenDeclBaseNameAndDeclNameArguments,
      \Self.declNameArguments,
      \Self.unexpectedAfterDeclNameArguments,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "type"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "declaration base name"
    case 6:
      return nil
    case 7:
      return "declaration name arguments"
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ImplementsAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeType": unexpectedBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypeAndComma": unexpectedBetweenTypeAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCommaAndDeclBaseName": unexpectedBetweenCommaAndDeclBaseName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDeclBaseNameAndDeclNameArguments": unexpectedBetweenDeclBaseNameAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterDeclNameArguments": unexpectedAfterDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjCSelectorPieceSyntax

/// 
/// A piece of an Objective-C selector. Either consisting of just an
/// identifier for a nullary selector, an identifier and a colon for a
/// labeled argument or just a colon for an unlabeled argument
/// 
public struct ObjCSelectorPieceSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax?,
    _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name?.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon?.raw,
      unexpectedAfterColon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelectorPiece,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> ObjCSelectorPieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ObjCSelectorPieceSyntax(newData)
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return ObjCSelectorPieceSyntax(newData)
  }

  public var unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndColon` to replace the node's
  ///                   current `unexpectedBetweenNameAndColon`, if present.
  public func withUnexpectedBetweenNameAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> ObjCSelectorPieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ObjCSelectorPieceSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ObjCSelectorPieceSyntax(newData)
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterColon` replaced.
  /// - param newChild: The new `unexpectedAfterColon` to replace the node's
  ///                   current `unexpectedAfterColon`, if present.
  public func withUnexpectedAfterColon(
    _ newChild: UnexpectedNodesSyntax?) -> ObjCSelectorPieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ObjCSelectorPieceSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndColon,
      \Self.colon,
      \Self.unexpectedAfterColon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ObjCSelectorPieceSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenNameAndColon": unexpectedBetweenNameAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterColon": unexpectedAfterColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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

  public init(
    _ unexpectedBeforeDiffKind: UnexpectedNodesSyntax? = nil,
    diffKind: TokenSyntax?,
    _ unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? = nil,
    diffKindComma: TokenSyntax?,
    _ unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamsClauseSyntax?,
    _ unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? = nil,
    diffParamsComma: TokenSyntax?,
    _ unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: GenericWhereClauseSyntax?,
    _ unexpectedAfterWhereClause: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiableAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeDiffKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeDiffKind(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeDiffKind` replaced.
  /// - param newChild: The new `unexpectedBeforeDiffKind` to replace the node's
  ///                   current `unexpectedBeforeDiffKind`, if present.
  public func withUnexpectedBeforeDiffKind(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var diffKind: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDiffKindAndDiffKindComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDiffKindAndDiffKindComma` replaced.
  /// - param newChild: The new `unexpectedBetweenDiffKindAndDiffKindComma` to replace the node's
  ///                   current `unexpectedBetweenDiffKindAndDiffKindComma`, if present.
  public func withUnexpectedBetweenDiffKindAndDiffKindComma(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The comma following the differentiability kind, if it exists.
  /// 
  public var diffKindComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDiffKindCommaAndDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDiffKindCommaAndDiffParams` replaced.
  /// - param newChild: The new `unexpectedBetweenDiffKindCommaAndDiffParams` to replace the node's
  ///                   current `unexpectedBetweenDiffKindCommaAndDiffParams`, if present.
  public func withUnexpectedBetweenDiffKindCommaAndDiffParams(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDiffParamsAndDiffParamsComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDiffParamsAndDiffParamsComma` replaced.
  /// - param newChild: The new `unexpectedBetweenDiffParamsAndDiffParamsComma` to replace the node's
  ///                   current `unexpectedBetweenDiffParamsAndDiffParamsComma`, if present.
  public func withUnexpectedBetweenDiffParamsAndDiffParamsComma(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The comma following the differentiability parameters clause,
  /// if it exists.
  /// 
  public var diffParamsComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDiffParamsCommaAndWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDiffParamsCommaAndWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenDiffParamsCommaAndWhereClause` to replace the node's
  ///                   current `unexpectedBetweenDiffParamsCommaAndWhereClause`, if present.
  public func withUnexpectedBetweenDiffParamsCommaAndWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var whereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterWhereClause` replaced.
  /// - param newChild: The new `unexpectedAfterWhereClause` to replace the node's
  ///                   current `unexpectedAfterWhereClause`, if present.
  public func withUnexpectedAfterWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeDiffKind,
      \Self.diffKind,
      \Self.unexpectedBetweenDiffKindAndDiffKindComma,
      \Self.diffKindComma,
      \Self.unexpectedBetweenDiffKindCommaAndDiffParams,
      \Self.diffParams,
      \Self.unexpectedBetweenDiffParamsAndDiffParamsComma,
      \Self.diffParamsComma,
      \Self.unexpectedBetweenDiffParamsCommaAndWhereClause,
      \Self.whereClause,
      \Self.unexpectedAfterWhereClause,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DifferentiableAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeDiffKind": unexpectedBeforeDiffKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffKind": diffKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDiffKindAndDiffKindComma": unexpectedBetweenDiffKindAndDiffKindComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffKindComma": diffKindComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDiffKindCommaAndDiffParams": unexpectedBetweenDiffKindCommaAndDiffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": diffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDiffParamsAndDiffParamsComma": unexpectedBetweenDiffParamsAndDiffParamsComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParamsComma": diffParamsComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDiffParamsCommaAndWhereClause": unexpectedBetweenDiffParamsCommaAndWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterWhereClause": unexpectedAfterWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamsClauseSyntax

/// A clause containing differentiability parameters.
public struct DifferentiabilityParamsClauseSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Parameters: SyntaxChildChoices {
    case `parameter`(DifferentiabilityParamSyntax)
    case `parameterList`(DifferentiabilityParamsSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .parameter(let node): return node._syntaxNode
      case .parameterList(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: DifferentiabilityParamSyntax) {
      self = .parameter(node)
    }
    public init(_ node: DifferentiabilityParamsSyntax) {
      self = .parameterList(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(DifferentiabilityParamSyntax.self) {
        self = .parameter(node)
        return
      }
      if let node = syntaxNode.as(DifferentiabilityParamsSyntax.self) {
        self = .parameterList(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(DifferentiabilityParamSyntax.self),
        .node(DifferentiabilityParamsSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? = nil,
    wrtLabel: TokenSyntax,
    _ unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? = nil,
    parameters: Parameters,
    _ unexpectedAfterParameters: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrtLabel?.raw,
      wrtLabel.raw,
      unexpectedBetweenWrtLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndParameters?.raw,
      parameters.raw,
      unexpectedAfterParameters?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamsClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWrtLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWrtLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeWrtLabel` to replace the node's
  ///                   current `unexpectedBeforeWrtLabel`, if present.
  public func withUnexpectedBeforeWrtLabel(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  /// The "wrt" label.
  public var wrtLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public var unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWrtLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWrtLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenWrtLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenWrtLabelAndColon`, if present.
  public func withUnexpectedBetweenWrtLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  /// 
  /// The colon separating "wrt" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public var unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndParameters` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndParameters` to replace the node's
  ///                   current `unexpectedBetweenColonAndParameters`, if present.
  public func withUnexpectedBetweenColonAndParameters(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public var parameters: Parameters {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return Parameters(childData!)
    }
    set(value) {
      self = withParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `parameters` replaced.
  /// - param newChild: The new `parameters` to replace the node's
  ///                   current `parameters`, if present.
  public func withParameters(
    _ newChild: Parameters?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public var unexpectedAfterParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterParameters` replaced.
  /// - param newChild: The new `unexpectedAfterParameters` to replace the node's
  ///                   current `unexpectedAfterParameters`, if present.
  public func withUnexpectedAfterParameters(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWrtLabel,
      \Self.wrtLabel,
      \Self.unexpectedBetweenWrtLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndParameters,
      \Self.parameters,
      \Self.unexpectedAfterParameters,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "parameters"
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DifferentiabilityParamsClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWrtLabel": unexpectedBeforeWrtLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wrtLabel": Syntax(wrtLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWrtLabelAndColon": unexpectedBetweenWrtLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndParameters": unexpectedBetweenColonAndParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "parameters": Syntax(parameters).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterParameters": unexpectedAfterParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamsSyntax

/// The differentiability parameters.
public struct DifferentiabilityParamsSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamListSyntax,
    _ unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDiffParams?.raw,
      diffParams.raw,
      unexpectedBetweenDiffParamsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParams,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndDiffParams` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndDiffParams` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndDiffParams`, if present.
  public func withUnexpectedBetweenLeftParenAndDiffParams(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DifferentiabilityParamsSyntax(newData)
  }

  /// The parameters for differentiation.
  public var diffParams: DifferentiabilityParamListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return DifferentiabilityParamsSyntax(newData)
  }

  /// Returns a copy of the receiver with its `diffParams` replaced.
  /// - param newChild: The new `diffParams` to replace the node's
  ///                   current `diffParams`, if present.
  public func withDiffParams(
    _ newChild: DifferentiabilityParamListSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.differentiabilityParamList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDiffParamsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDiffParamsAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenDiffParamsAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenDiffParamsAndRightParen`, if present.
  public func withUnexpectedBetweenDiffParamsAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DifferentiabilityParamsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndDiffParams,
      \Self.diffParams,
      \Self.unexpectedBetweenDiffParamsAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DifferentiabilityParamsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndDiffParams": unexpectedBetweenLeftParenAndDiffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": Syntax(diffParams).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDiffParamsAndRightParen": unexpectedBetweenDiffParamsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamSyntax

/// 
/// A differentiability parameter: either the "self" identifier, a function
/// parameter name, or a function parameter index.
/// 
public struct DifferentiabilityParamSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Parameter: SyntaxChildChoices {
    case `self`(TokenSyntax)
    case `name`(TokenSyntax)
    case `index`(TokenSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .self(let node): return node._syntaxNode
      case .name(let node): return node._syntaxNode
      case .index(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .selfKeyword: self = .self(tok)
        case .identifier: self = .name(tok)
        case .integerLiteral: self = .index(tok)
        default: return nil
        }
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.selfKeyword),
        .token(.identifier("")),
        .token(.integerLiteral("")),
      ])
    }
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

  public init(
    _ unexpectedBeforeParameter: UnexpectedNodesSyntax? = nil,
    parameter: Parameter,
    _ unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeParameter?.raw,
      parameter.raw,
      unexpectedBetweenParameterAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParam,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeParameter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeParameter` replaced.
  /// - param newChild: The new `unexpectedBeforeParameter` to replace the node's
  ///                   current `unexpectedBeforeParameter`, if present.
  public func withUnexpectedBeforeParameter(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DifferentiabilityParamSyntax(newData)
  }

  public var parameter: Parameter {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Parameter(childData!)
    }
    set(value) {
      self = withParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `parameter` replaced.
  /// - param newChild: The new `parameter` to replace the node's
  ///                   current `parameter`, if present.
  public func withParameter(
    _ newChild: Parameter?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DifferentiabilityParamSyntax(newData)
  }

  public var unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenParameterAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenParameterAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenParameterAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenParameterAndTrailingComma`, if present.
  public func withUnexpectedBetweenParameterAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DifferentiabilityParamSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return DifferentiabilityParamSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DifferentiabilityParamSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeParameter,
      \Self.parameter,
      \Self.unexpectedBetweenParameterAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DifferentiabilityParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeParameter": unexpectedBeforeParameter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "parameter": Syntax(parameter).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenParameterAndTrailingComma": unexpectedBetweenParameterAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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

  public init(
    _ unexpectedBeforeOfLabel: UnexpectedNodesSyntax? = nil,
    ofLabel: TokenSyntax,
    _ unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? = nil,
    originalDeclName: QualifiedDeclNameSyntax,
    _ unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax?,
    _ unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? = nil,
    accessorKind: TokenSyntax?,
    _ unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax?,
    _ unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamsClauseSyntax?,
    _ unexpectedAfterDiffParams: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.derivativeRegistrationAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeOfLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeOfLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeOfLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeOfLabel` to replace the node's
  ///                   current `unexpectedBeforeOfLabel`, if present.
  public func withUnexpectedBeforeOfLabel(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// The "of" label.
  public var ofLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOfLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOfLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenOfLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenOfLabelAndColon`, if present.
  public func withUnexpectedBetweenOfLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The colon separating the "of" label and the original
  /// declaration name.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndOriginalDeclName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndOriginalDeclName` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndOriginalDeclName` to replace the node's
  ///                   current `unexpectedBetweenColonAndOriginalDeclName`, if present.
  public func withUnexpectedBetweenColonAndOriginalDeclName(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// The referenced original declaration name.
  public var originalDeclName: QualifiedDeclNameSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.qualifiedDeclName, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOriginalDeclNameAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOriginalDeclNameAndPeriod` replaced.
  /// - param newChild: The new `unexpectedBetweenOriginalDeclNameAndPeriod` to replace the node's
  ///                   current `unexpectedBetweenOriginalDeclNameAndPeriod`, if present.
  public func withUnexpectedBetweenOriginalDeclNameAndPeriod(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The period separating the original declaration name and the
  /// accessor name.
  /// 
  public var period: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPeriodAndAccessorKind(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPeriodAndAccessorKind` replaced.
  /// - param newChild: The new `unexpectedBetweenPeriodAndAccessorKind` to replace the node's
  ///                   current `unexpectedBetweenPeriodAndAccessorKind`, if present.
  public func withUnexpectedBetweenPeriodAndAccessorKind(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// The accessor name.
  public var accessorKind: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAccessorKindAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAccessorKindAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenAccessorKindAndComma` to replace the node's
  ///                   current `unexpectedBetweenAccessorKindAndComma`, if present.
  public func withUnexpectedBetweenAccessorKindAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 11)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndDiffParams` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndDiffParams` to replace the node's
  ///                   current `unexpectedBetweenCommaAndDiffParams`, if present.
  public func withUnexpectedBetweenCommaAndDiffParams(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 13)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterDiffParams` replaced.
  /// - param newChild: The new `unexpectedAfterDiffParams` to replace the node's
  ///                   current `unexpectedAfterDiffParams`, if present.
  public func withUnexpectedAfterDiffParams(
    _ newChild: UnexpectedNodesSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeOfLabel,
      \Self.ofLabel,
      \Self.unexpectedBetweenOfLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndOriginalDeclName,
      \Self.originalDeclName,
      \Self.unexpectedBetweenOriginalDeclNameAndPeriod,
      \Self.period,
      \Self.unexpectedBetweenPeriodAndAccessorKind,
      \Self.accessorKind,
      \Self.unexpectedBetweenAccessorKindAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndDiffParams,
      \Self.diffParams,
      \Self.unexpectedAfterDiffParams,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return nil
    case 14:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DerivativeRegistrationAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeOfLabel": unexpectedBeforeOfLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ofLabel": Syntax(ofLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenOfLabelAndColon": unexpectedBetweenOfLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndOriginalDeclName": unexpectedBetweenColonAndOriginalDeclName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "originalDeclName": Syntax(originalDeclName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenOriginalDeclNameAndPeriod": unexpectedBetweenOriginalDeclNameAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": period.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenPeriodAndAccessorKind": unexpectedBetweenPeriodAndAccessorKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessorKind": accessorKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAccessorKindAndComma": unexpectedBetweenAccessorKindAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCommaAndDiffParams": unexpectedBetweenCommaAndDiffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": diffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterDiffParams": unexpectedAfterDiffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - QualifiedDeclNameSyntax

/// 
/// An optionally qualified function declaration name (e.g. `+(_:_:)`,
/// `A.B.C.foo(_:_:)`).
/// 
public struct QualifiedDeclNameSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax?,
    _ unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax?,
    _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentsSyntax?,
    _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.qualifiedDeclName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBaseType` replaced.
  /// - param newChild: The new `unexpectedBeforeBaseType` to replace the node's
  ///                   current `unexpectedBeforeBaseType`, if present.
  public func withUnexpectedBeforeBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return QualifiedDeclNameSyntax(newData)
  }

  /// 
  /// The base type of the qualified name, optionally specified.
  /// 
  public var baseType: TypeSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return QualifiedDeclNameSyntax(newData)
  }

  public var unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBaseTypeAndDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBaseTypeAndDot` replaced.
  /// - param newChild: The new `unexpectedBetweenBaseTypeAndDot` to replace the node's
  ///                   current `unexpectedBetweenBaseTypeAndDot`, if present.
  public func withUnexpectedBetweenBaseTypeAndDot(
    _ newChild: UnexpectedNodesSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return QualifiedDeclNameSyntax(newData)
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return QualifiedDeclNameSyntax(newData)
  }

  public var unexpectedBetweenDotAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDotAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDotAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenDotAndName` to replace the node's
  ///                   current `unexpectedBetweenDotAndName`, if present.
  public func withUnexpectedBetweenDotAndName(
    _ newChild: UnexpectedNodesSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return QualifiedDeclNameSyntax(newData)
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return QualifiedDeclNameSyntax(newData)
  }

  public var unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndArguments` to replace the node's
  ///                   current `unexpectedBetweenNameAndArguments`, if present.
  public func withUnexpectedBetweenNameAndArguments(
    _ newChild: UnexpectedNodesSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return QualifiedDeclNameSyntax(newData)
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return QualifiedDeclNameSyntax(newData)
  }

  public var unexpectedAfterArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterArguments` replaced.
  /// - param newChild: The new `unexpectedAfterArguments` to replace the node's
  ///                   current `unexpectedAfterArguments`, if present.
  public func withUnexpectedAfterArguments(
    _ newChild: UnexpectedNodesSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return QualifiedDeclNameSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBaseType,
      \Self.baseType,
      \Self.unexpectedBetweenBaseTypeAndDot,
      \Self.dot,
      \Self.unexpectedBetweenDotAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndArguments,
      \Self.arguments,
      \Self.unexpectedAfterArguments,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "base type"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "base name"
    case 6:
      return nil
    case 7:
      return "arguments"
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension QualifiedDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBaseType": unexpectedBeforeBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": baseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenBaseTypeAndDot": unexpectedBetweenBaseTypeAndDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDotAndName": unexpectedBetweenDotAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndArguments": unexpectedBetweenNameAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterArguments": unexpectedAfterArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionDeclNameSyntax

/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Name: SyntaxChildChoices {
    case `identifier`(TokenSyntax)
    case `prefixOperator`(TokenSyntax)
    case `spacedBinaryOperator`(TokenSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .identifier(let node): return node._syntaxNode
      case .prefixOperator(let node): return node._syntaxNode
      case .spacedBinaryOperator(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .identifier: self = .identifier(tok)
        case .prefixOperator: self = .prefixOperator(tok)
        case .spacedBinaryOperator: self = .spacedBinaryOperator(tok)
        default: return nil
        }
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.identifier("")),
        .token(.prefixOperator("")),
        .token(.spacedBinaryOperator("")),
      ])
    }
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: Name,
    _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentsSyntax?,
    _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndArguments?.raw,
      arguments?.raw,
      unexpectedAfterArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDeclName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return FunctionDeclNameSyntax(newData)
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: Name {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Name(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: Name?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return FunctionDeclNameSyntax(newData)
  }

  public var unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndArguments` to replace the node's
  ///                   current `unexpectedBetweenNameAndArguments`, if present.
  public func withUnexpectedBetweenNameAndArguments(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return FunctionDeclNameSyntax(newData)
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return FunctionDeclNameSyntax(newData)
  }

  public var unexpectedAfterArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterArguments` replaced.
  /// - param newChild: The new `unexpectedAfterArguments` to replace the node's
  ///                   current `unexpectedAfterArguments`, if present.
  public func withUnexpectedAfterArguments(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return FunctionDeclNameSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndArguments,
      \Self.arguments,
      \Self.unexpectedAfterArguments,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "base name"
    case 2:
      return nil
    case 3:
      return "arguments"
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension FunctionDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndArguments": unexpectedBetweenNameAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterArguments": unexpectedAfterArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BackDeployAttributeSpecListSyntax

/// 
/// A collection of arguments for the `@_backDeploy` attribute
/// 
public struct BackDeployAttributeSpecListSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? = nil,
    beforeLabel: TokenSyntax,
    _ unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? = nil,
    versionList: BackDeployVersionListSyntax,
    _ unexpectedAfterVersionList: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBeforeLabel?.raw,
      beforeLabel.raw,
      unexpectedBetweenBeforeLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndVersionList?.raw,
      versionList.raw,
      unexpectedAfterVersionList?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployAttributeSpecList,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeBeforeLabel`, if present.
  public func withUnexpectedBeforeBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// The "before" label.
  public var beforeLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  public var unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBeforeLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBeforeLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenBeforeLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenBeforeLabelAndColon`, if present.
  public func withUnexpectedBetweenBeforeLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// 
  /// The colon separating "before" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  public var unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndVersionList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndVersionList` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndVersionList` to replace the node's
  ///                   current `unexpectedBetweenColonAndVersionList`, if present.
  public func withUnexpectedBetweenColonAndVersionList(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// 
  /// The list of OS versions in which the declaration became ABI
  /// stable.
  /// 
  public var versionList: BackDeployVersionListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// Returns a copy of the receiver with its `versionList` replaced.
  /// - param newChild: The new `versionList` to replace the node's
  ///                   current `versionList`, if present.
  public func withVersionList(
    _ newChild: BackDeployVersionListSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.backDeployVersionList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  public var unexpectedAfterVersionList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterVersionList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterVersionList` replaced.
  /// - param newChild: The new `unexpectedAfterVersionList` to replace the node's
  ///                   current `unexpectedAfterVersionList`, if present.
  public func withUnexpectedAfterVersionList(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBeforeLabel,
      \Self.beforeLabel,
      \Self.unexpectedBetweenBeforeLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndVersionList,
      \Self.versionList,
      \Self.unexpectedAfterVersionList,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension BackDeployAttributeSpecListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBeforeLabel": unexpectedBeforeBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "beforeLabel": Syntax(beforeLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBeforeLabelAndColon": unexpectedBetweenBeforeLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndVersionList": unexpectedBetweenColonAndVersionList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "versionList": Syntax(versionList).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterVersionList": unexpectedAfterVersionList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BackDeployVersionArgumentSyntax

/// 
/// A single platform/version pair in a `@_backDeploy` attribute,
/// e.g. `iOS 10.1`.
/// 
public struct BackDeployVersionArgumentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? = nil,
    availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax,
    _ unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAvailabilityVersionRestriction?.raw,
      availabilityVersionRestriction.raw,
      unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAvailabilityVersionRestriction(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAvailabilityVersionRestriction` replaced.
  /// - param newChild: The new `unexpectedBeforeAvailabilityVersionRestriction` to replace the node's
  ///                   current `unexpectedBeforeAvailabilityVersionRestriction`, if present.
  public func withUnexpectedBeforeAvailabilityVersionRestriction(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployVersionArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return BackDeployVersionArgumentSyntax(newData)
  }

  public var availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilityVersionRestriction, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return BackDeployVersionArgumentSyntax(newData)
  }

  public var unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma`, if present.
  public func withUnexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployVersionArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return BackDeployVersionArgumentSyntax(newData)
  }

  /// 
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return BackDeployVersionArgumentSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> BackDeployVersionArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return BackDeployVersionArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAvailabilityVersionRestriction,
      \Self.availabilityVersionRestriction,
      \Self.unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension BackDeployVersionArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAvailabilityVersionRestriction": unexpectedBeforeAvailabilityVersionRestriction.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "availabilityVersionRestriction": Syntax(availabilityVersionRestriction).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma": unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OpaqueReturnTypeOfAttributeArgumentsSyntax

/// 
/// The arguments for the '@_opaqueReturnTypeOf()'.
/// 
public struct OpaqueReturnTypeOfAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OpaqueReturnTypeOfAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .opaqueReturnTypeOfAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OpaqueReturnTypeOfAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .opaqueReturnTypeOfAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeMangledName: UnexpectedNodesSyntax? = nil,
    mangledName: TokenSyntax,
    _ unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax,
    _ unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? = nil,
    ordinal: TokenSyntax,
    _ unexpectedAfterOrdinal: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMangledName?.raw,
      mangledName.raw,
      unexpectedBetweenMangledNameAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndOrdinal?.raw,
      ordinal.raw,
      unexpectedAfterOrdinal?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.opaqueReturnTypeOfAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeMangledName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeMangledName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeMangledName` replaced.
  /// - param newChild: The new `unexpectedBeforeMangledName` to replace the node's
  ///                   current `unexpectedBeforeMangledName`, if present.
  public func withUnexpectedBeforeMangledName(
    _ newChild: UnexpectedNodesSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  /// The mangled name of a declaration.
  public var mangledName: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withMangledName(value)
    }
  }

  /// Returns a copy of the receiver with its `mangledName` replaced.
  /// - param newChild: The new `mangledName` to replace the node's
  ///                   current `mangledName`, if present.
  public func withMangledName(
    _ newChild: TokenSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMangledNameAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMangledNameAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenMangledNameAndComma` to replace the node's
  ///                   current `unexpectedBetweenMangledNameAndComma`, if present.
  public func withUnexpectedBetweenMangledNameAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndOrdinal(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndOrdinal` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndOrdinal` to replace the node's
  ///                   current `unexpectedBetweenCommaAndOrdinal`, if present.
  public func withUnexpectedBetweenCommaAndOrdinal(
    _ newChild: UnexpectedNodesSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  /// The ordinal corresponding to the 'some' keyword that introduced this opaque type.
  public var ordinal: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOrdinal(value)
    }
  }

  /// Returns a copy of the receiver with its `ordinal` replaced.
  /// - param newChild: The new `ordinal` to replace the node's
  ///                   current `ordinal`, if present.
  public func withOrdinal(
    _ newChild: TokenSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterOrdinal: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterOrdinal(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterOrdinal` replaced.
  /// - param newChild: The new `unexpectedAfterOrdinal` to replace the node's
  ///                   current `unexpectedAfterOrdinal`, if present.
  public func withUnexpectedAfterOrdinal(
    _ newChild: UnexpectedNodesSyntax?) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeMangledName,
      \Self.mangledName,
      \Self.unexpectedBetweenMangledNameAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndOrdinal,
      \Self.ordinal,
      \Self.unexpectedAfterOrdinal,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension OpaqueReturnTypeOfAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeMangledName": unexpectedBeforeMangledName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "mangledName": Syntax(mangledName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMangledNameAndComma": unexpectedBetweenMangledNameAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCommaAndOrdinal": unexpectedBetweenCommaAndOrdinal.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ordinal": Syntax(ordinal).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterOrdinal": unexpectedAfterOrdinal.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConventionAttributeArgumentsSyntax

/// 
/// The arguments for the '@convention(...)'.
/// 
public struct ConventionAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ConventionAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .conventionAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ConventionAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conventionAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? = nil,
    conventionLabel: TokenSyntax,
    _ unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax?,
    _ unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? = nil,
    cTypeLabel: TokenSyntax?,
    _ unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? = nil,
    cTypeString: TokenSyntax?,
    _ unexpectedAfterCTypeString: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeConventionLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeConventionLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeConventionLabel` to replace the node's
  ///                   current `unexpectedBeforeConventionLabel`, if present.
  public func withUnexpectedBeforeConventionLabel(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  /// The convention label.
  public var conventionLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withConventionLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `conventionLabel` replaced.
  /// - param newChild: The new `conventionLabel` to replace the node's
  ///                   current `conventionLabel`, if present.
  public func withConventionLabel(
    _ newChild: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenConventionLabelAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenConventionLabelAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenConventionLabelAndComma` to replace the node's
  ///                   current `unexpectedBetweenConventionLabelAndComma`, if present.
  public func withUnexpectedBetweenConventionLabelAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndCTypeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndCTypeLabel` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndCTypeLabel` to replace the node's
  ///                   current `unexpectedBetweenCommaAndCTypeLabel`, if present.
  public func withUnexpectedBetweenCommaAndCTypeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var cTypeLabel: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCTypeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `cTypeLabel` replaced.
  /// - param newChild: The new `cTypeLabel` to replace the node's
  ///                   current `cTypeLabel`, if present.
  public func withCTypeLabel(
    _ newChild: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCTypeLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCTypeLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenCTypeLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenCTypeLabelAndColon`, if present.
  public func withUnexpectedBetweenCTypeLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndCTypeString(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndCTypeString` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndCTypeString` to replace the node's
  ///                   current `unexpectedBetweenColonAndCTypeString`, if present.
  public func withUnexpectedBetweenColonAndCTypeString(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var cTypeString: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCTypeString(value)
    }
  }

  /// Returns a copy of the receiver with its `cTypeString` replaced.
  /// - param newChild: The new `cTypeString` to replace the node's
  ///                   current `cTypeString`, if present.
  public func withCTypeString(
    _ newChild: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 9)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterCTypeString: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterCTypeString(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterCTypeString` replaced.
  /// - param newChild: The new `unexpectedAfterCTypeString` to replace the node's
  ///                   current `unexpectedAfterCTypeString`, if present.
  public func withUnexpectedAfterCTypeString(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return ConventionAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeConventionLabel,
      \Self.conventionLabel,
      \Self.unexpectedBetweenConventionLabelAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndCTypeLabel,
      \Self.cTypeLabel,
      \Self.unexpectedBetweenCTypeLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndCTypeString,
      \Self.cTypeString,
      \Self.unexpectedAfterCTypeString,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ConventionAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeConventionLabel": unexpectedBeforeConventionLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conventionLabel": Syntax(conventionLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenConventionLabelAndComma": unexpectedBetweenConventionLabelAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCommaAndCTypeLabel": unexpectedBetweenCommaAndCTypeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "cTypeLabel": cTypeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCTypeLabelAndColon": unexpectedBetweenCTypeLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndCTypeString": unexpectedBetweenColonAndCTypeString.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "cTypeString": cTypeString.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterCTypeString": unexpectedAfterCTypeString.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConventionWitnessMethodAttributeArgumentsSyntax

/// 
/// The arguments for the '@convention(witness_method: ...)'.
/// 
public struct ConventionWitnessMethodAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ConventionWitnessMethodAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .conventionWitnessMethodAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ConventionWitnessMethodAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conventionWitnessMethodAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? = nil,
    witnessMethodLabel: TokenSyntax,
    _ unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? = nil,
    protocolName: TokenSyntax,
    _ unexpectedAfterProtocolName: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWitnessMethodLabel?.raw,
      witnessMethodLabel.raw,
      unexpectedBetweenWitnessMethodLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndProtocolName?.raw,
      protocolName.raw,
      unexpectedAfterProtocolName?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionWitnessMethodAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWitnessMethodLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWitnessMethodLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeWitnessMethodLabel` to replace the node's
  ///                   current `unexpectedBeforeWitnessMethodLabel`, if present.
  public func withUnexpectedBeforeWitnessMethodLabel(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var witnessMethodLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWitnessMethodLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `witnessMethodLabel` replaced.
  /// - param newChild: The new `witnessMethodLabel` to replace the node's
  ///                   current `witnessMethodLabel`, if present.
  public func withWitnessMethodLabel(
    _ newChild: TokenSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWitnessMethodLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWitnessMethodLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenWitnessMethodLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenWitnessMethodLabelAndColon`, if present.
  public func withUnexpectedBetweenWitnessMethodLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndProtocolName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndProtocolName` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndProtocolName` to replace the node's
  ///                   current `unexpectedBetweenColonAndProtocolName`, if present.
  public func withUnexpectedBetweenColonAndProtocolName(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var protocolName: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withProtocolName(value)
    }
  }

  /// Returns a copy of the receiver with its `protocolName` replaced.
  /// - param newChild: The new `protocolName` to replace the node's
  ///                   current `protocolName`, if present.
  public func withProtocolName(
    _ newChild: TokenSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public var unexpectedAfterProtocolName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterProtocolName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterProtocolName` replaced.
  /// - param newChild: The new `unexpectedAfterProtocolName` to replace the node's
  ///                   current `unexpectedAfterProtocolName`, if present.
  public func withUnexpectedAfterProtocolName(
    _ newChild: UnexpectedNodesSyntax?) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ConventionWitnessMethodAttributeArgumentsSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWitnessMethodLabel,
      \Self.witnessMethodLabel,
      \Self.unexpectedBetweenWitnessMethodLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndProtocolName,
      \Self.protocolName,
      \Self.unexpectedAfterProtocolName,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ConventionWitnessMethodAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWitnessMethodLabel": unexpectedBeforeWitnessMethodLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "witnessMethodLabel": Syntax(witnessMethodLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWitnessMethodLabelAndColon": unexpectedBetweenWitnessMethodLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndProtocolName": unexpectedBetweenColonAndProtocolName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "protocolName": Syntax(protocolName).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterProtocolName": unexpectedAfterProtocolName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WhereClauseSyntax

public struct WhereClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil,
    whereKeyword: TokenSyntax,
    _ unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? = nil,
    guardResult: ExprSyntax,
    _ unexpectedAfterGuardResult: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndGuardResult?.raw,
      guardResult.raw,
      unexpectedAfterGuardResult?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.whereClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWhereKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWhereKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeWhereKeyword` to replace the node's
  ///                   current `unexpectedBeforeWhereKeyword`, if present.
  public func withUnexpectedBeforeWhereKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> WhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return WhereClauseSyntax(newData)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return WhereClauseSyntax(newData)
  }

  public var unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWhereKeywordAndGuardResult(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWhereKeywordAndGuardResult` replaced.
  /// - param newChild: The new `unexpectedBetweenWhereKeywordAndGuardResult` to replace the node's
  ///                   current `unexpectedBetweenWhereKeywordAndGuardResult`, if present.
  public func withUnexpectedBetweenWhereKeywordAndGuardResult(
    _ newChild: UnexpectedNodesSyntax?) -> WhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return WhereClauseSyntax(newData)
  }

  public var guardResult: ExprSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return WhereClauseSyntax(newData)
  }

  public var unexpectedAfterGuardResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterGuardResult(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterGuardResult` replaced.
  /// - param newChild: The new `unexpectedAfterGuardResult` to replace the node's
  ///                   current `unexpectedAfterGuardResult`, if present.
  public func withUnexpectedAfterGuardResult(
    _ newChild: UnexpectedNodesSyntax?) -> WhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return WhereClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWhereKeyword,
      \Self.whereKeyword,
      \Self.unexpectedBetweenWhereKeywordAndGuardResult,
      \Self.guardResult,
      \Self.unexpectedAfterGuardResult,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension WhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWhereKeyword": unexpectedBeforeWhereKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWhereKeywordAndGuardResult": unexpectedBetweenWhereKeywordAndGuardResult.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "guardResult": Syntax(guardResult).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterGuardResult": unexpectedAfterGuardResult.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - YieldListSyntax

public struct YieldListSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil,
    elementList: YieldExprListSyntax,
    _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldList,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return YieldListSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return YieldListSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndElementList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndElementList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndElementList` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndElementList`, if present.
  public func withUnexpectedBetweenLeftParenAndElementList(
    _ newChild: UnexpectedNodesSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return YieldListSyntax(newData)
  }

  public var elementList: YieldExprListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return YieldExprListSyntax(childData!)
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
  public func addElement(_ element: YieldExprListElementSyntax) -> YieldListSyntax {
    var collection: RawSyntax
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return YieldListSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elementList` replaced.
  /// - param newChild: The new `elementList` to replace the node's
  ///                   current `elementList`, if present.
  public func withElementList(
    _ newChild: YieldExprListSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.yieldExprList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return YieldListSyntax(newData)
  }

  public var unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenElementListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenElementListAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenElementListAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenElementListAndRightParen`, if present.
  public func withUnexpectedBetweenElementListAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return YieldListSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return YieldListSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return YieldListSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndElementList,
      \Self.elementList,
      \Self.unexpectedBetweenElementListAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension YieldListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndElementList": unexpectedBetweenLeftParenAndElementList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenElementListAndRightParen": unexpectedBetweenElementListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConditionElementSyntax

public struct ConditionElementSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Condition: SyntaxChildChoices {
    case `expression`(ExprSyntax)
    case `availability`(AvailabilityConditionSyntax)
    case `unavailability`(UnavailabilityConditionSyntax)
    case `matchingPattern`(MatchingPatternConditionSyntax)
    case `optionalBinding`(OptionalBindingConditionSyntax)
    case `hasSymbol`(HasSymbolConditionSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .expression(let node): return node._syntaxNode
      case .availability(let node): return node._syntaxNode
      case .unavailability(let node): return node._syntaxNode
      case .matchingPattern(let node): return node._syntaxNode
      case .optionalBinding(let node): return node._syntaxNode
      case .hasSymbol(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init<Node: ExprSyntaxProtocol>(_ node: Node) {
      self = .expression(ExprSyntax(node))
    }
    public init(_ node: AvailabilityConditionSyntax) {
      self = .availability(node)
    }
    public init(_ node: UnavailabilityConditionSyntax) {
      self = .unavailability(node)
    }
    public init(_ node: MatchingPatternConditionSyntax) {
      self = .matchingPattern(node)
    }
    public init(_ node: OptionalBindingConditionSyntax) {
      self = .optionalBinding(node)
    }
    public init(_ node: HasSymbolConditionSyntax) {
      self = .hasSymbol(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(ExprSyntax.self) {
        self = .expression(node)
        return
      }
      if let node = syntaxNode.as(AvailabilityConditionSyntax.self) {
        self = .availability(node)
        return
      }
      if let node = syntaxNode.as(UnavailabilityConditionSyntax.self) {
        self = .unavailability(node)
        return
      }
      if let node = syntaxNode.as(MatchingPatternConditionSyntax.self) {
        self = .matchingPattern(node)
        return
      }
      if let node = syntaxNode.as(OptionalBindingConditionSyntax.self) {
        self = .optionalBinding(node)
        return
      }
      if let node = syntaxNode.as(HasSymbolConditionSyntax.self) {
        self = .hasSymbol(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(ExprSyntax.self),
        .node(AvailabilityConditionSyntax.self),
        .node(UnavailabilityConditionSyntax.self),
        .node(MatchingPatternConditionSyntax.self),
        .node(OptionalBindingConditionSyntax.self),
        .node(HasSymbolConditionSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeCondition: UnexpectedNodesSyntax? = nil,
    condition: Condition,
    _ unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCondition?.raw,
      condition.raw,
      unexpectedBetweenConditionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeCondition: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCondition` replaced.
  /// - param newChild: The new `unexpectedBeforeCondition` to replace the node's
  ///                   current `unexpectedBeforeCondition`, if present.
  public func withUnexpectedBeforeCondition(
    _ newChild: UnexpectedNodesSyntax?) -> ConditionElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ConditionElementSyntax(newData)
  }

  public var condition: Condition {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Condition(childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: Condition?) -> ConditionElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ConditionElementSyntax(newData)
  }

  public var unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenConditionAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenConditionAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenConditionAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenConditionAndTrailingComma`, if present.
  public func withUnexpectedBetweenConditionAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ConditionElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ConditionElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return ConditionElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> ConditionElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ConditionElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeCondition,
      \Self.condition,
      \Self.unexpectedBetweenConditionAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ConditionElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCondition": unexpectedBeforeCondition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenConditionAndTrailingComma": unexpectedBetweenConditionAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityConditionSyntax

public struct AvailabilityConditionSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforePoundAvailableKeyword: UnexpectedNodesSyntax? = nil,
    poundAvailableKeyword: TokenSyntax,
    _ unexpectedBetweenPoundAvailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil,
    availabilitySpec: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePoundAvailableKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundAvailableKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundAvailableKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforePoundAvailableKeyword` to replace the node's
  ///                   current `unexpectedBeforePoundAvailableKeyword`, if present.
  public func withUnexpectedBeforePoundAvailableKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AvailabilityConditionSyntax(newData)
  }

  public var poundAvailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundAvailableKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AvailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenPoundAvailableKeywordAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundAvailableKeywordAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundAvailableKeywordAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundAvailableKeywordAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundAvailableKeywordAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundAvailableKeywordAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AvailabilityConditionSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AvailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndAvailabilitySpec(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndAvailabilitySpec` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndAvailabilitySpec` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndAvailabilitySpec`, if present.
  public func withUnexpectedBetweenLeftParenAndAvailabilitySpec(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AvailabilityConditionSyntax(newData)
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return AvailabilityConditionSyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilitySpec` replaced.
  /// - param newChild: The new `availabilitySpec` to replace the node's
  ///                   current `availabilitySpec`, if present.
  public func withAvailabilitySpec(
    _ newChild: AvailabilitySpecListSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AvailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAvailabilitySpecAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAvailabilitySpecAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenAvailabilitySpecAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenAvailabilitySpecAndRightParen`, if present.
  public func withUnexpectedBetweenAvailabilitySpecAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AvailabilityConditionSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return AvailabilityConditionSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return AvailabilityConditionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundAvailableKeyword,
      \Self.poundAvailableKeyword,
      \Self.unexpectedBetweenPoundAvailableKeywordAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndAvailabilitySpec,
      \Self.availabilitySpec,
      \Self.unexpectedBetweenAvailabilitySpecAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AvailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundAvailableKeyword": unexpectedBeforePoundAvailableKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundAvailableKeyword": Syntax(poundAvailableKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundAvailableKeywordAndLeftParen": unexpectedBetweenPoundAvailableKeywordAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndAvailabilitySpec": unexpectedBetweenLeftParenAndAvailabilitySpec.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAvailabilitySpecAndRightParen": unexpectedBetweenAvailabilitySpecAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MatchingPatternConditionSyntax

public struct MatchingPatternConditionSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax,
    _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax,
    _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.matchingPatternCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCaseKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeCaseKeyword` to replace the node's
  ///                   current `unexpectedBeforeCaseKeyword`, if present.
  public func withUnexpectedBeforeCaseKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MatchingPatternConditionSyntax(newData)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MatchingPatternConditionSyntax(newData)
  }

  public var unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaseKeywordAndPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaseKeywordAndPattern` replaced.
  /// - param newChild: The new `unexpectedBetweenCaseKeywordAndPattern` to replace the node's
  ///                   current `unexpectedBetweenCaseKeywordAndPattern`, if present.
  public func withUnexpectedBetweenCaseKeywordAndPattern(
    _ newChild: UnexpectedNodesSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MatchingPatternConditionSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return MatchingPatternConditionSyntax(newData)
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndTypeAnnotation` to replace the node's
  ///                   current `unexpectedBetweenPatternAndTypeAnnotation`, if present.
  public func withUnexpectedBetweenPatternAndTypeAnnotation(
    _ newChild: UnexpectedNodesSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MatchingPatternConditionSyntax(newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return MatchingPatternConditionSyntax(newData)
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAnnotationAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAnnotationAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAnnotationAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenTypeAnnotationAndInitializer`, if present.
  public func withUnexpectedBetweenTypeAnnotationAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return MatchingPatternConditionSyntax(newData)
  }

  public var initializer: InitializerClauseSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.initializerClause, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return MatchingPatternConditionSyntax(newData)
  }

  public var unexpectedAfterInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterInitializer` replaced.
  /// - param newChild: The new `unexpectedAfterInitializer` to replace the node's
  ///                   current `unexpectedAfterInitializer`, if present.
  public func withUnexpectedAfterInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return MatchingPatternConditionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeCaseKeyword,
      \Self.caseKeyword,
      \Self.unexpectedBetweenCaseKeywordAndPattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndTypeAnnotation,
      \Self.typeAnnotation,
      \Self.unexpectedBetweenTypeAnnotationAndInitializer,
      \Self.initializer,
      \Self.unexpectedAfterInitializer,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MatchingPatternConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCaseKeyword": unexpectedBeforeCaseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCaseKeywordAndPattern": unexpectedBetweenCaseKeywordAndPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndTypeAnnotation": unexpectedBetweenPatternAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTypeAnnotationAndInitializer": unexpectedBetweenTypeAnnotationAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": Syntax(initializer).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterInitializer": unexpectedAfterInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalBindingConditionSyntax

public struct OptionalBindingConditionSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax?,
    _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalBindingCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLetOrVarKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeLetOrVarKeyword` to replace the node's
  ///                   current `unexpectedBeforeLetOrVarKeyword`, if present.
  public func withUnexpectedBeforeLetOrVarKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return OptionalBindingConditionSyntax(newData)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return OptionalBindingConditionSyntax(newData)
  }

  public var unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLetOrVarKeywordAndPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLetOrVarKeywordAndPattern` replaced.
  /// - param newChild: The new `unexpectedBetweenLetOrVarKeywordAndPattern` to replace the node's
  ///                   current `unexpectedBetweenLetOrVarKeywordAndPattern`, if present.
  public func withUnexpectedBetweenLetOrVarKeywordAndPattern(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return OptionalBindingConditionSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return OptionalBindingConditionSyntax(newData)
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndTypeAnnotation` to replace the node's
  ///                   current `unexpectedBetweenPatternAndTypeAnnotation`, if present.
  public func withUnexpectedBetweenPatternAndTypeAnnotation(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return OptionalBindingConditionSyntax(newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return OptionalBindingConditionSyntax(newData)
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAnnotationAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAnnotationAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAnnotationAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenTypeAnnotationAndInitializer`, if present.
  public func withUnexpectedBetweenTypeAnnotationAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return OptionalBindingConditionSyntax(newData)
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return OptionalBindingConditionSyntax(newData)
  }

  public var unexpectedAfterInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterInitializer` replaced.
  /// - param newChild: The new `unexpectedAfterInitializer` to replace the node's
  ///                   current `unexpectedAfterInitializer`, if present.
  public func withUnexpectedAfterInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return OptionalBindingConditionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLetOrVarKeyword,
      \Self.letOrVarKeyword,
      \Self.unexpectedBetweenLetOrVarKeywordAndPattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndTypeAnnotation,
      \Self.typeAnnotation,
      \Self.unexpectedBetweenTypeAnnotationAndInitializer,
      \Self.initializer,
      \Self.unexpectedAfterInitializer,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension OptionalBindingConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLetOrVarKeyword": unexpectedBeforeLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLetOrVarKeywordAndPattern": unexpectedBetweenLetOrVarKeywordAndPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndTypeAnnotation": unexpectedBetweenPatternAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTypeAnnotationAndInitializer": unexpectedBetweenTypeAnnotationAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterInitializer": unexpectedAfterInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnavailabilityConditionSyntax

public struct UnavailabilityConditionSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforePoundUnavailableKeyword: UnexpectedNodesSyntax? = nil,
    poundUnavailableKeyword: TokenSyntax,
    _ unexpectedBetweenPoundUnavailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil,
    availabilitySpec: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unavailabilityCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePoundUnavailableKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundUnavailableKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundUnavailableKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforePoundUnavailableKeyword` to replace the node's
  ///                   current `unexpectedBeforePoundUnavailableKeyword`, if present.
  public func withUnexpectedBeforePoundUnavailableKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return UnavailabilityConditionSyntax(newData)
  }

  public var poundUnavailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundUnavailableKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return UnavailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenPoundUnavailableKeywordAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundUnavailableKeywordAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundUnavailableKeywordAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundUnavailableKeywordAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundUnavailableKeywordAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundUnavailableKeywordAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return UnavailabilityConditionSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return UnavailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndAvailabilitySpec(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndAvailabilitySpec` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndAvailabilitySpec` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndAvailabilitySpec`, if present.
  public func withUnexpectedBetweenLeftParenAndAvailabilitySpec(
    _ newChild: UnexpectedNodesSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return UnavailabilityConditionSyntax(newData)
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return UnavailabilityConditionSyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilitySpec` replaced.
  /// - param newChild: The new `availabilitySpec` to replace the node's
  ///                   current `availabilitySpec`, if present.
  public func withAvailabilitySpec(
    _ newChild: AvailabilitySpecListSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return UnavailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAvailabilitySpecAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAvailabilitySpecAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenAvailabilitySpecAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenAvailabilitySpecAndRightParen`, if present.
  public func withUnexpectedBetweenAvailabilitySpecAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return UnavailabilityConditionSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return UnavailabilityConditionSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return UnavailabilityConditionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundUnavailableKeyword,
      \Self.poundUnavailableKeyword,
      \Self.unexpectedBetweenPoundUnavailableKeywordAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndAvailabilitySpec,
      \Self.availabilitySpec,
      \Self.unexpectedBetweenAvailabilitySpecAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension UnavailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundUnavailableKeyword": unexpectedBeforePoundUnavailableKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundUnavailableKeyword": Syntax(poundUnavailableKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundUnavailableKeywordAndLeftParen": unexpectedBetweenPoundUnavailableKeywordAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndAvailabilitySpec": unexpectedBetweenLeftParenAndAvailabilitySpec.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAvailabilitySpecAndRightParen": unexpectedBetweenAvailabilitySpecAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - HasSymbolConditionSyntax

public struct HasSymbolConditionSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `HasSymbolConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .hasSymbolCondition else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `HasSymbolConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .hasSymbolCondition)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? = nil,
    hasSymbolKeyword: TokenSyntax,
    _ unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.hasSymbolCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeHasSymbolKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeHasSymbolKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeHasSymbolKeyword` to replace the node's
  ///                   current `unexpectedBeforeHasSymbolKeyword`, if present.
  public func withUnexpectedBeforeHasSymbolKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return HasSymbolConditionSyntax(newData)
  }

  public var hasSymbolKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withHasSymbolKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `hasSymbolKeyword` replaced.
  /// - param newChild: The new `hasSymbolKeyword` to replace the node's
  ///                   current `hasSymbolKeyword`, if present.
  public func withHasSymbolKeyword(
    _ newChild: TokenSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return HasSymbolConditionSyntax(newData)
  }

  public var unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenHasSymbolKeywordAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenHasSymbolKeywordAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenHasSymbolKeywordAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenHasSymbolKeywordAndLeftParen`, if present.
  public func withUnexpectedBetweenHasSymbolKeywordAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return HasSymbolConditionSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return HasSymbolConditionSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndExpression` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndExpression`, if present.
  public func withUnexpectedBetweenLeftParenAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return HasSymbolConditionSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    _ newChild: ExprSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return HasSymbolConditionSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndRightParen`, if present.
  public func withUnexpectedBetweenExpressionAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return HasSymbolConditionSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return HasSymbolConditionSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> HasSymbolConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return HasSymbolConditionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeHasSymbolKeyword,
      \Self.hasSymbolKeyword,
      \Self.unexpectedBetweenHasSymbolKeywordAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndExpression,
      \Self.expression,
      \Self.unexpectedBetweenExpressionAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension HasSymbolConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeHasSymbolKeyword": unexpectedBeforeHasSymbolKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "hasSymbolKeyword": Syntax(hasSymbolKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenHasSymbolKeywordAndLeftParen": unexpectedBetweenHasSymbolKeywordAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndExpression": unexpectedBetweenLeftParenAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndRightParen": unexpectedBetweenExpressionAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchCaseSyntax

public struct SwitchCaseSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Label: SyntaxChildChoices {
    case `default`(SwitchDefaultLabelSyntax)
    case `case`(SwitchCaseLabelSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .default(let node): return node._syntaxNode
      case .case(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: SwitchDefaultLabelSyntax) {
      self = .default(node)
    }
    public init(_ node: SwitchCaseLabelSyntax) {
      self = .case(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(SwitchDefaultLabelSyntax.self) {
        self = .default(node)
        return
      }
      if let node = syntaxNode.as(SwitchCaseLabelSyntax.self) {
        self = .case(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(SwitchDefaultLabelSyntax.self),
        .node(SwitchCaseLabelSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? = nil,
    unknownAttr: AttributeSyntax?,
    _ unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? = nil,
    label: Label,
    _ unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedAfterStatements: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeUnknownAttr?.raw,
      unknownAttr?.raw,
      unexpectedBetweenUnknownAttrAndLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndStatements?.raw,
      statements.raw,
      unexpectedAfterStatements?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCase,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeUnknownAttr(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeUnknownAttr` replaced.
  /// - param newChild: The new `unexpectedBeforeUnknownAttr` to replace the node's
  ///                   current `unexpectedBeforeUnknownAttr`, if present.
  public func withUnexpectedBeforeUnknownAttr(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SwitchCaseSyntax(newData)
  }

  public var unknownAttr: AttributeSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return SwitchCaseSyntax(newData)
  }

  public var unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenUnknownAttrAndLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenUnknownAttrAndLabel` replaced.
  /// - param newChild: The new `unexpectedBetweenUnknownAttrAndLabel` to replace the node's
  ///                   current `unexpectedBetweenUnknownAttrAndLabel`, if present.
  public func withUnexpectedBetweenUnknownAttrAndLabel(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SwitchCaseSyntax(newData)
  }

  public var label: Label {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return Label(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: Label?) -> SwitchCaseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return SwitchCaseSyntax(newData)
  }

  public var unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndStatements` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndStatements` to replace the node's
  ///                   current `unexpectedBetweenLabelAndStatements`, if present.
  public func withUnexpectedBetweenLabelAndStatements(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SwitchCaseSyntax(newData)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 5)
    return SwitchCaseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return SwitchCaseSyntax(newData)
  }

  public var unexpectedAfterStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterStatements` replaced.
  /// - param newChild: The new `unexpectedAfterStatements` to replace the node's
  ///                   current `unexpectedAfterStatements`, if present.
  public func withUnexpectedAfterStatements(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return SwitchCaseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeUnknownAttr,
      \Self.unknownAttr,
      \Self.unexpectedBetweenUnknownAttrAndLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndStatements,
      \Self.statements,
      \Self.unexpectedAfterStatements,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "label"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension SwitchCaseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeUnknownAttr": unexpectedBeforeUnknownAttr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unknownAttr": unknownAttr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenUnknownAttrAndLabel": unexpectedBetweenUnknownAttrAndLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndStatements": unexpectedBetweenLabelAndStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterStatements": unexpectedAfterStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchDefaultLabelSyntax

public struct SwitchDefaultLabelSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? = nil,
    defaultKeyword: TokenSyntax,
    _ unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDefaultKeyword?.raw,
      defaultKeyword.raw,
      unexpectedBetweenDefaultKeywordAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchDefaultLabel,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeDefaultKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeDefaultKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeDefaultKeyword` to replace the node's
  ///                   current `unexpectedBeforeDefaultKeyword`, if present.
  public func withUnexpectedBeforeDefaultKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SwitchDefaultLabelSyntax(newData)
  }

  public var defaultKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.defaultKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return SwitchDefaultLabelSyntax(newData)
  }

  public var unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDefaultKeywordAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDefaultKeywordAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenDefaultKeywordAndColon` to replace the node's
  ///                   current `unexpectedBetweenDefaultKeywordAndColon`, if present.
  public func withUnexpectedBetweenDefaultKeywordAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SwitchDefaultLabelSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return SwitchDefaultLabelSyntax(newData)
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterColon` replaced.
  /// - param newChild: The new `unexpectedAfterColon` to replace the node's
  ///                   current `unexpectedAfterColon`, if present.
  public func withUnexpectedAfterColon(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SwitchDefaultLabelSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeDefaultKeyword,
      \Self.defaultKeyword,
      \Self.unexpectedBetweenDefaultKeywordAndColon,
      \Self.colon,
      \Self.unexpectedAfterColon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension SwitchDefaultLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeDefaultKeyword": unexpectedBeforeDefaultKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "defaultKeyword": Syntax(defaultKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDefaultKeywordAndColon": unexpectedBetweenDefaultKeywordAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterColon": unexpectedAfterColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CaseItemSyntax

public struct CaseItemSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: WhereClauseSyntax?,
    _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePattern` replaced.
  /// - param newChild: The new `unexpectedBeforePattern` to replace the node's
  ///                   current `unexpectedBeforePattern`, if present.
  public func withUnexpectedBeforePattern(
    _ newChild: UnexpectedNodesSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CaseItemSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CaseItemSyntax(newData)
  }

  public var unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndWhereClause` to replace the node's
  ///                   current `unexpectedBetweenPatternAndWhereClause`, if present.
  public func withUnexpectedBetweenPatternAndWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CaseItemSyntax(newData)
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return CaseItemSyntax(newData)
  }

  public var unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWhereClauseAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWhereClauseAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenWhereClauseAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenWhereClauseAndTrailingComma`, if present.
  public func withUnexpectedBetweenWhereClauseAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CaseItemSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return CaseItemSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CaseItemSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndWhereClause,
      \Self.whereClause,
      \Self.unexpectedBetweenWhereClauseAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CaseItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePattern": unexpectedBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndWhereClause": unexpectedBetweenPatternAndWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenWhereClauseAndTrailingComma": unexpectedBetweenWhereClauseAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CatchItemSyntax

public struct CatchItemSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax?,
    _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: WhereClauseSyntax?,
    _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern?.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePattern` replaced.
  /// - param newChild: The new `unexpectedBeforePattern` to replace the node's
  ///                   current `unexpectedBeforePattern`, if present.
  public func withUnexpectedBeforePattern(
    _ newChild: UnexpectedNodesSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CatchItemSyntax(newData)
  }

  public var pattern: PatternSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return CatchItemSyntax(newData)
  }

  public var unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndWhereClause` to replace the node's
  ///                   current `unexpectedBetweenPatternAndWhereClause`, if present.
  public func withUnexpectedBetweenPatternAndWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CatchItemSyntax(newData)
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return CatchItemSyntax(newData)
  }

  public var unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWhereClauseAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWhereClauseAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenWhereClauseAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenWhereClauseAndTrailingComma`, if present.
  public func withUnexpectedBetweenWhereClauseAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CatchItemSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return CatchItemSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CatchItemSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndWhereClause,
      \Self.whereClause,
      \Self.unexpectedBetweenWhereClauseAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CatchItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePattern": unexpectedBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": pattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenPatternAndWhereClause": unexpectedBetweenPatternAndWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenWhereClauseAndTrailingComma": unexpectedBetweenWhereClauseAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchCaseLabelSyntax

public struct SwitchCaseLabelSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax,
    _ unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? = nil,
    caseItems: CaseItemListSyntax,
    _ unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndCaseItems?.raw,
      caseItems.raw,
      unexpectedBetweenCaseItemsAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseLabel,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCaseKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeCaseKeyword` to replace the node's
  ///                   current `unexpectedBeforeCaseKeyword`, if present.
  public func withUnexpectedBeforeCaseKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SwitchCaseLabelSyntax(newData)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return SwitchCaseLabelSyntax(newData)
  }

  public var unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaseKeywordAndCaseItems(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaseKeywordAndCaseItems` replaced.
  /// - param newChild: The new `unexpectedBetweenCaseKeywordAndCaseItems` to replace the node's
  ///                   current `unexpectedBetweenCaseKeywordAndCaseItems`, if present.
  public func withUnexpectedBetweenCaseKeywordAndCaseItems(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SwitchCaseLabelSyntax(newData)
  }

  public var caseItems: CaseItemListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.caseItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return SwitchCaseLabelSyntax(newData)
  }

  /// Returns a copy of the receiver with its `caseItems` replaced.
  /// - param newChild: The new `caseItems` to replace the node's
  ///                   current `caseItems`, if present.
  public func withCaseItems(
    _ newChild: CaseItemListSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.caseItemList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return SwitchCaseLabelSyntax(newData)
  }

  public var unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaseItemsAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaseItemsAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenCaseItemsAndColon` to replace the node's
  ///                   current `unexpectedBetweenCaseItemsAndColon`, if present.
  public func withUnexpectedBetweenCaseItemsAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SwitchCaseLabelSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return SwitchCaseLabelSyntax(newData)
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterColon` replaced.
  /// - param newChild: The new `unexpectedAfterColon` to replace the node's
  ///                   current `unexpectedAfterColon`, if present.
  public func withUnexpectedAfterColon(
    _ newChild: UnexpectedNodesSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return SwitchCaseLabelSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeCaseKeyword,
      \Self.caseKeyword,
      \Self.unexpectedBetweenCaseKeywordAndCaseItems,
      \Self.caseItems,
      \Self.unexpectedBetweenCaseItemsAndColon,
      \Self.colon,
      \Self.unexpectedAfterColon,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension SwitchCaseLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCaseKeyword": unexpectedBeforeCaseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCaseKeywordAndCaseItems": unexpectedBetweenCaseKeywordAndCaseItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseItems": Syntax(caseItems).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCaseItemsAndColon": unexpectedBetweenCaseItemsAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterColon": unexpectedAfterColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CatchClauseSyntax

public struct CatchClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? = nil,
    catchKeyword: TokenSyntax,
    _ unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? = nil,
    catchItems: CatchItemListSyntax?,
    _ unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCatchKeyword?.raw,
      catchKeyword.raw,
      unexpectedBetweenCatchKeywordAndCatchItems?.raw,
      catchItems?.raw,
      unexpectedBetweenCatchItemsAndBody?.raw,
      body.raw,
      unexpectedAfterBody?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCatchKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCatchKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeCatchKeyword` to replace the node's
  ///                   current `unexpectedBeforeCatchKeyword`, if present.
  public func withUnexpectedBeforeCatchKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CatchClauseSyntax(newData)
  }

  public var catchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.catchKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CatchClauseSyntax(newData)
  }

  public var unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCatchKeywordAndCatchItems(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCatchKeywordAndCatchItems` replaced.
  /// - param newChild: The new `unexpectedBetweenCatchKeywordAndCatchItems` to replace the node's
  ///                   current `unexpectedBetweenCatchKeywordAndCatchItems`, if present.
  public func withUnexpectedBetweenCatchKeywordAndCatchItems(
    _ newChild: UnexpectedNodesSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CatchClauseSyntax(newData)
  }

  public var catchItems: CatchItemListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.catchItemList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return CatchClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `catchItems` replaced.
  /// - param newChild: The new `catchItems` to replace the node's
  ///                   current `catchItems`, if present.
  public func withCatchItems(
    _ newChild: CatchItemListSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return CatchClauseSyntax(newData)
  }

  public var unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCatchItemsAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCatchItemsAndBody` replaced.
  /// - param newChild: The new `unexpectedBetweenCatchItemsAndBody` to replace the node's
  ///                   current `unexpectedBetweenCatchItemsAndBody`, if present.
  public func withUnexpectedBetweenCatchItemsAndBody(
    _ newChild: UnexpectedNodesSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CatchClauseSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return CatchClauseSyntax(newData)
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterBody` replaced.
  /// - param newChild: The new `unexpectedAfterBody` to replace the node's
  ///                   current `unexpectedAfterBody`, if present.
  public func withUnexpectedAfterBody(
    _ newChild: UnexpectedNodesSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return CatchClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeCatchKeyword,
      \Self.catchKeyword,
      \Self.unexpectedBetweenCatchKeywordAndCatchItems,
      \Self.catchItems,
      \Self.unexpectedBetweenCatchItemsAndBody,
      \Self.body,
      \Self.unexpectedAfterBody,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CatchClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCatchKeyword": unexpectedBeforeCatchKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "catchKeyword": Syntax(catchKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCatchKeywordAndCatchItems": unexpectedBetweenCatchKeywordAndCatchItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "catchItems": catchItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCatchItemsAndBody": unexpectedBetweenCatchItemsAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterBody": unexpectedAfterBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericWhereClauseSyntax

public struct GenericWhereClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil,
    whereKeyword: TokenSyntax,
    _ unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? = nil,
    requirementList: GenericRequirementListSyntax,
    _ unexpectedAfterRequirementList: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndRequirementList?.raw,
      requirementList.raw,
      unexpectedAfterRequirementList?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericWhereClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWhereKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWhereKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeWhereKeyword` to replace the node's
  ///                   current `unexpectedBeforeWhereKeyword`, if present.
  public func withUnexpectedBeforeWhereKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericWhereClauseSyntax(newData)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return GenericWhereClauseSyntax(newData)
  }

  public var unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWhereKeywordAndRequirementList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWhereKeywordAndRequirementList` replaced.
  /// - param newChild: The new `unexpectedBetweenWhereKeywordAndRequirementList` to replace the node's
  ///                   current `unexpectedBetweenWhereKeywordAndRequirementList`, if present.
  public func withUnexpectedBetweenWhereKeywordAndRequirementList(
    _ newChild: UnexpectedNodesSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericWhereClauseSyntax(newData)
  }

  public var requirementList: GenericRequirementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return GenericWhereClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `requirementList` replaced.
  /// - param newChild: The new `requirementList` to replace the node's
  ///                   current `requirementList`, if present.
  public func withRequirementList(
    _ newChild: GenericRequirementListSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericRequirementList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return GenericWhereClauseSyntax(newData)
  }

  public var unexpectedAfterRequirementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRequirementList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRequirementList` replaced.
  /// - param newChild: The new `unexpectedAfterRequirementList` to replace the node's
  ///                   current `unexpectedAfterRequirementList`, if present.
  public func withUnexpectedAfterRequirementList(
    _ newChild: UnexpectedNodesSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericWhereClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWhereKeyword,
      \Self.whereKeyword,
      \Self.unexpectedBetweenWhereKeywordAndRequirementList,
      \Self.requirementList,
      \Self.unexpectedAfterRequirementList,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericWhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWhereKeyword": unexpectedBeforeWhereKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWhereKeywordAndRequirementList": unexpectedBetweenWhereKeywordAndRequirementList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "requirementList": Syntax(requirementList).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRequirementList": unexpectedAfterRequirementList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericRequirementSyntax

public struct GenericRequirementSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Body: SyntaxChildChoices {
    case `sameTypeRequirement`(SameTypeRequirementSyntax)
    case `conformanceRequirement`(ConformanceRequirementSyntax)
    case `layoutRequirement`(LayoutRequirementSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .sameTypeRequirement(let node): return node._syntaxNode
      case .conformanceRequirement(let node): return node._syntaxNode
      case .layoutRequirement(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: SameTypeRequirementSyntax) {
      self = .sameTypeRequirement(node)
    }
    public init(_ node: ConformanceRequirementSyntax) {
      self = .conformanceRequirement(node)
    }
    public init(_ node: LayoutRequirementSyntax) {
      self = .layoutRequirement(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let node = syntaxNode.as(SameTypeRequirementSyntax.self) {
        self = .sameTypeRequirement(node)
        return
      }
      if let node = syntaxNode.as(ConformanceRequirementSyntax.self) {
        self = .conformanceRequirement(node)
        return
      }
      if let node = syntaxNode.as(LayoutRequirementSyntax.self) {
        self = .layoutRequirement(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(SameTypeRequirementSyntax.self),
        .node(ConformanceRequirementSyntax.self),
        .node(LayoutRequirementSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeBody: UnexpectedNodesSyntax? = nil,
    body: Body,
    _ unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBody` replaced.
  /// - param newChild: The new `unexpectedBeforeBody` to replace the node's
  ///                   current `unexpectedBeforeBody`, if present.
  public func withUnexpectedBeforeBody(
    _ newChild: UnexpectedNodesSyntax?) -> GenericRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericRequirementSyntax(newData)
  }

  public var body: Body {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Body(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: Body?) -> GenericRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return GenericRequirementSyntax(newData)
  }

  public var unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBodyAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBodyAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenBodyAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenBodyAndTrailingComma`, if present.
  public func withUnexpectedBetweenBodyAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericRequirementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return GenericRequirementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericRequirementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBody,
      \Self.body,
      \Self.unexpectedBetweenBodyAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBody": unexpectedBeforeBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBodyAndTrailingComma": unexpectedBetweenBodyAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SameTypeRequirementSyntax

public struct SameTypeRequirementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: TypeSyntax,
    _ unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? = nil,
    equalityToken: TokenSyntax,
    _ unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: TypeSyntax,
    _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndEqualityToken?.raw,
      equalityToken.raw,
      unexpectedBetweenEqualityTokenAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
      unexpectedAfterRightTypeIdentifier?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sameTypeRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftTypeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeLeftTypeIdentifier`, if present.
  public func withUnexpectedBeforeLeftTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SameTypeRequirementSyntax(newData)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return SameTypeRequirementSyntax(newData)
  }

  public var unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftTypeIdentifierAndEqualityToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftTypeIdentifierAndEqualityToken` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftTypeIdentifierAndEqualityToken` to replace the node's
  ///                   current `unexpectedBetweenLeftTypeIdentifierAndEqualityToken`, if present.
  public func withUnexpectedBetweenLeftTypeIdentifierAndEqualityToken(
    _ newChild: UnexpectedNodesSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SameTypeRequirementSyntax(newData)
  }

  public var equalityToken: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.spacedBinaryOperator(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return SameTypeRequirementSyntax(newData)
  }

  public var unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEqualityTokenAndRightTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEqualityTokenAndRightTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenEqualityTokenAndRightTypeIdentifier` to replace the node's
  ///                   current `unexpectedBetweenEqualityTokenAndRightTypeIdentifier`, if present.
  public func withUnexpectedBetweenEqualityTokenAndRightTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SameTypeRequirementSyntax(newData)
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return SameTypeRequirementSyntax(newData)
  }

  public var unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedAfterRightTypeIdentifier` to replace the node's
  ///                   current `unexpectedAfterRightTypeIdentifier`, if present.
  public func withUnexpectedAfterRightTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return SameTypeRequirementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftTypeIdentifier,
      \Self.leftTypeIdentifier,
      \Self.unexpectedBetweenLeftTypeIdentifierAndEqualityToken,
      \Self.equalityToken,
      \Self.unexpectedBetweenEqualityTokenAndRightTypeIdentifier,
      \Self.rightTypeIdentifier,
      \Self.unexpectedAfterRightTypeIdentifier,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "left-hand type"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "right-hand type"
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension SameTypeRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftTypeIdentifier": unexpectedBeforeLeftTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftTypeIdentifierAndEqualityToken": unexpectedBetweenLeftTypeIdentifierAndEqualityToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "equalityToken": Syntax(equalityToken).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenEqualityTokenAndRightTypeIdentifier": unexpectedBetweenEqualityTokenAndRightTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightTypeIdentifier": unexpectedAfterRightTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - LayoutRequirementSyntax

public struct LayoutRequirementSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `LayoutRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .layoutRequirement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `LayoutRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .layoutRequirement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? = nil,
    typeIdentifier: TypeSyntax,
    _ unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? = nil,
    layoutConstraint: TokenSyntax,
    _ unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? = nil,
    size: TokenSyntax?,
    _ unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax?,
    _ unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? = nil,
    alignment: TokenSyntax?,
    _ unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.layoutRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeTypeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeTypeIdentifier`, if present.
  public func withUnexpectedBeforeTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return LayoutRequirementSyntax(newData)
  }

  public var typeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `typeIdentifier` replaced.
  /// - param newChild: The new `typeIdentifier` to replace the node's
  ///                   current `typeIdentifier`, if present.
  public func withTypeIdentifier(
    _ newChild: TypeSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeIdentifierAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeIdentifierAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeIdentifierAndColon` to replace the node's
  ///                   current `unexpectedBetweenTypeIdentifierAndColon`, if present.
  public func withUnexpectedBetweenTypeIdentifierAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return LayoutRequirementSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndLayoutConstraint(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndLayoutConstraint` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndLayoutConstraint` to replace the node's
  ///                   current `unexpectedBetweenColonAndLayoutConstraint`, if present.
  public func withUnexpectedBetweenColonAndLayoutConstraint(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return LayoutRequirementSyntax(newData)
  }

  public var layoutConstraint: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLayoutConstraint(value)
    }
  }

  /// Returns a copy of the receiver with its `layoutConstraint` replaced.
  /// - param newChild: The new `layoutConstraint` to replace the node's
  ///                   current `layoutConstraint`, if present.
  public func withLayoutConstraint(
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLayoutConstraintAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLayoutConstraintAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenLayoutConstraintAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenLayoutConstraintAndLeftParen`, if present.
  public func withUnexpectedBetweenLayoutConstraintAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return LayoutRequirementSyntax(newData)
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndSize(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndSize` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndSize` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndSize`, if present.
  public func withUnexpectedBetweenLeftParenAndSize(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return LayoutRequirementSyntax(newData)
  }

  public var size: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSize(value)
    }
  }

  /// Returns a copy of the receiver with its `size` replaced.
  /// - param newChild: The new `size` to replace the node's
  ///                   current `size`, if present.
  public func withSize(
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 9)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSizeAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSizeAndComma` replaced.
  /// - param newChild: The new `unexpectedBetweenSizeAndComma` to replace the node's
  ///                   current `unexpectedBetweenSizeAndComma`, if present.
  public func withUnexpectedBetweenSizeAndComma(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return LayoutRequirementSyntax(newData)
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 11)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCommaAndAlignment(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCommaAndAlignment` replaced.
  /// - param newChild: The new `unexpectedBetweenCommaAndAlignment` to replace the node's
  ///                   current `unexpectedBetweenCommaAndAlignment`, if present.
  public func withUnexpectedBetweenCommaAndAlignment(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return LayoutRequirementSyntax(newData)
  }

  public var alignment: TokenSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAlignment(value)
    }
  }

  /// Returns a copy of the receiver with its `alignment` replaced.
  /// - param newChild: The new `alignment` to replace the node's
  ///                   current `alignment`, if present.
  public func withAlignment(
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 13)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAlignmentAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAlignmentAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenAlignmentAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenAlignmentAndRightParen`, if present.
  public func withUnexpectedBetweenAlignmentAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return LayoutRequirementSyntax(newData)
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 15)
    return LayoutRequirementSyntax(newData)
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightParen` replaced.
  /// - param newChild: The new `unexpectedAfterRightParen` to replace the node's
  ///                   current `unexpectedAfterRightParen`, if present.
  public func withUnexpectedAfterRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> LayoutRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 16)
    return LayoutRequirementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeTypeIdentifier,
      \Self.typeIdentifier,
      \Self.unexpectedBetweenTypeIdentifierAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndLayoutConstraint,
      \Self.layoutConstraint,
      \Self.unexpectedBetweenLayoutConstraintAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndSize,
      \Self.size,
      \Self.unexpectedBetweenSizeAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndAlignment,
      \Self.alignment,
      \Self.unexpectedBetweenAlignmentAndRightParen,
      \Self.rightParen,
      \Self.unexpectedAfterRightParen,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "constrained type"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return "size"
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return "alignment"
    case 14:
      return nil
    case 15:
      return nil
    case 16:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension LayoutRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeTypeIdentifier": unexpectedBeforeTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeIdentifier": Syntax(typeIdentifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypeIdentifierAndColon": unexpectedBetweenTypeIdentifierAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndLayoutConstraint": unexpectedBetweenColonAndLayoutConstraint.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "layoutConstraint": Syntax(layoutConstraint).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLayoutConstraintAndLeftParen": unexpectedBetweenLayoutConstraintAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndSize": unexpectedBetweenLeftParenAndSize.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "size": size.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSizeAndComma": unexpectedBetweenSizeAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCommaAndAlignment": unexpectedBetweenCommaAndAlignment.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "alignment": alignment.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAlignmentAndRightParen": unexpectedBetweenAlignmentAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericParameterSyntax

public struct GenericParameterSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax?,
    _ unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? = nil,
    inheritedType: TypeSyntax?,
    _ unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericParameterSyntax(newData)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return GenericParameterSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 1)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributesAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributesAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributesAndName` to replace the node's
  ///                   current `unexpectedBetweenAttributesAndName`, if present.
  public func withUnexpectedBetweenAttributesAndName(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericParameterSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndEllipsis(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndEllipsis` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndEllipsis` to replace the node's
  ///                   current `unexpectedBetweenNameAndEllipsis`, if present.
  public func withUnexpectedBetweenNameAndEllipsis(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericParameterSyntax(newData)
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEllipsisAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEllipsisAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenEllipsisAndColon` to replace the node's
  ///                   current `unexpectedBetweenEllipsisAndColon`, if present.
  public func withUnexpectedBetweenEllipsisAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return GenericParameterSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndInheritedType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndInheritedType` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndInheritedType` to replace the node's
  ///                   current `unexpectedBetweenColonAndInheritedType`, if present.
  public func withUnexpectedBetweenColonAndInheritedType(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return GenericParameterSyntax(newData)
  }

  public var inheritedType: TypeSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritedTypeAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritedTypeAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritedTypeAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenInheritedTypeAndTrailingComma`, if present.
  public func withUnexpectedBetweenInheritedTypeAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return GenericParameterSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 11)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return GenericParameterSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndEllipsis,
      \Self.ellipsis,
      \Self.unexpectedBetweenEllipsisAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndInheritedType,
      \Self.inheritedType,
      \Self.unexpectedBetweenInheritedTypeAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "name"
    case 4:
      return nil
    case 5:
      return "parameter pack specifier"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return "inherited type"
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndName": unexpectedBetweenAttributesAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndEllipsis": unexpectedBetweenNameAndEllipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenEllipsisAndColon": unexpectedBetweenEllipsisAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndInheritedType": unexpectedBetweenColonAndInheritedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritedType": inheritedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritedTypeAndTrailingComma": unexpectedBetweenInheritedTypeAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrimaryAssociatedTypeSyntax

public struct PrimaryAssociatedTypeSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeName` replaced.
  /// - param newChild: The new `unexpectedBeforeName` to replace the node's
  ///                   current `unexpectedBeforeName`, if present.
  public func withUnexpectedBeforeName(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenNameAndTrailingComma`, if present.
  public func withUnexpectedBetweenNameAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "name"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrimaryAssociatedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndTrailingComma": unexpectedBetweenNameAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericParameterClauseSyntax

public struct GenericParameterClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? = nil,
    genericParameterList: GenericParameterListSyntax,
    _ unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax,
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftAngleBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftAngleBracket`, if present.
  public func withUnexpectedBeforeLeftAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericParameterClauseSyntax(newData)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return GenericParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftAngleBracketAndGenericParameterList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftAngleBracketAndGenericParameterList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftAngleBracketAndGenericParameterList` to replace the node's
  ///                   current `unexpectedBetweenLeftAngleBracketAndGenericParameterList`, if present.
  public func withUnexpectedBetweenLeftAngleBracketAndGenericParameterList(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericParameterClauseSyntax(newData)
  }

  public var genericParameterList: GenericParameterListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return GenericParameterClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `genericParameterList` replaced.
  /// - param newChild: The new `genericParameterList` to replace the node's
  ///                   current `genericParameterList`, if present.
  public func withGenericParameterList(
    _ newChild: GenericParameterListSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return GenericParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterListAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterListAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterListAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterListAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenGenericParameterListAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericParameterClauseSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericWhereClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 5)
    return GenericParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndRightAngleBracket` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndRightAngleBracket`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return GenericParameterClauseSyntax(newData)
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return GenericParameterClauseSyntax(newData)
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightAngleBracket` to replace the node's
  ///                   current `unexpectedAfterRightAngleBracket`, if present.
  public func withUnexpectedAfterRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return GenericParameterClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftAngleBracket,
      \Self.leftAngleBracket,
      \Self.unexpectedBetweenLeftAngleBracketAndGenericParameterList,
      \Self.genericParameterList,
      \Self.unexpectedBetweenGenericParameterListAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndRightAngleBracket,
      \Self.rightAngleBracket,
      \Self.unexpectedAfterRightAngleBracket,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftAngleBracket": unexpectedBeforeLeftAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftAngleBracketAndGenericParameterList": unexpectedBetweenLeftAngleBracketAndGenericParameterList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterList": Syntax(genericParameterList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenGenericParameterListAndGenericWhereClause": unexpectedBetweenGenericParameterListAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndRightAngleBracket": unexpectedBetweenGenericWhereClauseAndRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightAngleBracket": unexpectedAfterRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConformanceRequirementSyntax

public struct ConformanceRequirementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: TypeSyntax,
    _ unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: TypeSyntax,
    _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
      unexpectedAfterRightTypeIdentifier?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conformanceRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftTypeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeLeftTypeIdentifier`, if present.
  public func withUnexpectedBeforeLeftTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ConformanceRequirementSyntax(newData)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ConformanceRequirementSyntax(newData)
  }

  public var unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftTypeIdentifierAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftTypeIdentifierAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftTypeIdentifierAndColon` to replace the node's
  ///                   current `unexpectedBetweenLeftTypeIdentifierAndColon`, if present.
  public func withUnexpectedBetweenLeftTypeIdentifierAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ConformanceRequirementSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ConformanceRequirementSyntax(newData)
  }

  public var unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndRightTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndRightTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndRightTypeIdentifier` to replace the node's
  ///                   current `unexpectedBetweenColonAndRightTypeIdentifier`, if present.
  public func withUnexpectedBetweenColonAndRightTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ConformanceRequirementSyntax(newData)
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ConformanceRequirementSyntax(newData)
  }

  public var unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightTypeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightTypeIdentifier` replaced.
  /// - param newChild: The new `unexpectedAfterRightTypeIdentifier` to replace the node's
  ///                   current `unexpectedAfterRightTypeIdentifier`, if present.
  public func withUnexpectedAfterRightTypeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ConformanceRequirementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftTypeIdentifier,
      \Self.leftTypeIdentifier,
      \Self.unexpectedBetweenLeftTypeIdentifierAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndRightTypeIdentifier,
      \Self.rightTypeIdentifier,
      \Self.unexpectedAfterRightTypeIdentifier,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ConformanceRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftTypeIdentifier": unexpectedBeforeLeftTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftTypeIdentifierAndColon": unexpectedBetweenLeftTypeIdentifierAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndRightTypeIdentifier": unexpectedBetweenColonAndRightTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightTypeIdentifier": unexpectedAfterRightTypeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrimaryAssociatedTypeClauseSyntax

public struct PrimaryAssociatedTypeClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax,
    _ unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax,
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw,
      primaryAssociatedTypeList.raw,
      unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
      unexpectedAfterRightAngleBracket?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftAngleBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftAngleBracket`, if present.
  public func withUnexpectedBeforeLeftAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList` to replace the node's
  ///                   current `unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList`, if present.
  public func withUnexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `primaryAssociatedTypeList` replaced.
  /// - param newChild: The new `primaryAssociatedTypeList` to replace the node's
  ///                   current `primaryAssociatedTypeList`, if present.
  public func withPrimaryAssociatedTypeList(
    _ newChild: PrimaryAssociatedTypeListSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.primaryAssociatedTypeList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket` to replace the node's
  ///                   current `unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket`, if present.
  public func withUnexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightAngleBracket` to replace the node's
  ///                   current `unexpectedAfterRightAngleBracket`, if present.
  public func withUnexpectedAfterRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftAngleBracket,
      \Self.leftAngleBracket,
      \Self.unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList,
      \Self.primaryAssociatedTypeList,
      \Self.unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket,
      \Self.rightAngleBracket,
      \Self.unexpectedAfterRightAngleBracket,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension PrimaryAssociatedTypeClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftAngleBracket": unexpectedBeforeLeftAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList": unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "primaryAssociatedTypeList": Syntax(primaryAssociatedTypeList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket": unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightAngleBracket": unexpectedAfterRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CompositionTypeElementSyntax

public struct CompositionTypeElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax,
    _ unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? = nil,
    ampersand: TokenSyntax?,
    _ unexpectedAfterAmpersand: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedBetweenTypeAndAmpersand?.raw,
      ampersand?.raw,
      unexpectedAfterAmpersand?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeType` replaced.
  /// - param newChild: The new `unexpectedBeforeType` to replace the node's
  ///                   current `unexpectedBeforeType`, if present.
  public func withUnexpectedBeforeType(
    _ newChild: UnexpectedNodesSyntax?) -> CompositionTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CompositionTypeElementSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CompositionTypeElementSyntax(newData)
  }

  public var unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAndAmpersand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAndAmpersand` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAndAmpersand` to replace the node's
  ///                   current `unexpectedBetweenTypeAndAmpersand`, if present.
  public func withUnexpectedBetweenTypeAndAmpersand(
    _ newChild: UnexpectedNodesSyntax?) -> CompositionTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CompositionTypeElementSyntax(newData)
  }

  public var ampersand: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return CompositionTypeElementSyntax(newData)
  }

  public var unexpectedAfterAmpersand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterAmpersand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterAmpersand` replaced.
  /// - param newChild: The new `unexpectedAfterAmpersand` to replace the node's
  ///                   current `unexpectedAfterAmpersand`, if present.
  public func withUnexpectedAfterAmpersand(
    _ newChild: UnexpectedNodesSyntax?) -> CompositionTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return CompositionTypeElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeType,
      \Self.type,
      \Self.unexpectedBetweenTypeAndAmpersand,
      \Self.ampersand,
      \Self.unexpectedAfterAmpersand,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension CompositionTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeType": unexpectedBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypeAndAmpersand": unexpectedBetweenTypeAndAmpersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ampersand": ampersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterAmpersand": unexpectedAfterAmpersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleTypeElementSyntax

public struct TupleTypeElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeInOut: UnexpectedNodesSyntax? = nil,
    inOut: TokenSyntax?,
    _ unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax?,
    _ unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? = nil,
    secondName: TokenSyntax?,
    _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax,
    _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax?,
    _ unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeInOut: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeInOut(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeInOut` replaced.
  /// - param newChild: The new `unexpectedBeforeInOut` to replace the node's
  ///                   current `unexpectedBeforeInOut`, if present.
  public func withUnexpectedBeforeInOut(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TupleTypeElementSyntax(newData)
  }

  public var inOut: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInOutAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInOutAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenInOutAndName` to replace the node's
  ///                   current `unexpectedBetweenInOutAndName`, if present.
  public func withUnexpectedBetweenInOutAndName(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TupleTypeElementSyntax(newData)
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndSecondName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndSecondName` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndSecondName` to replace the node's
  ///                   current `unexpectedBetweenNameAndSecondName`, if present.
  public func withUnexpectedBetweenNameAndSecondName(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TupleTypeElementSyntax(newData)
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSecondNameAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSecondNameAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenSecondNameAndColon` to replace the node's
  ///                   current `unexpectedBetweenSecondNameAndColon`, if present.
  public func withUnexpectedBetweenSecondNameAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return TupleTypeElementSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndType` to replace the node's
  ///                   current `unexpectedBetweenColonAndType`, if present.
  public func withUnexpectedBetweenColonAndType(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return TupleTypeElementSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 9)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAndEllipsis(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAndEllipsis` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAndEllipsis` to replace the node's
  ///                   current `unexpectedBetweenTypeAndEllipsis`, if present.
  public func withUnexpectedBetweenTypeAndEllipsis(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return TupleTypeElementSyntax(newData)
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 11)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEllipsisAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEllipsisAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenEllipsisAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenEllipsisAndInitializer`, if present.
  public func withUnexpectedBetweenEllipsisAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return TupleTypeElementSyntax(newData)
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 13)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInitializerAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInitializerAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenInitializerAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenInitializerAndTrailingComma`, if present.
  public func withUnexpectedBetweenInitializerAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return TupleTypeElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 15)
    return TupleTypeElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 16)
    return TupleTypeElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeInOut,
      \Self.inOut,
      \Self.unexpectedBetweenInOutAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndSecondName,
      \Self.secondName,
      \Self.unexpectedBetweenSecondNameAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndType,
      \Self.type,
      \Self.unexpectedBetweenTypeAndEllipsis,
      \Self.ellipsis,
      \Self.unexpectedBetweenEllipsisAndInitializer,
      \Self.initializer,
      \Self.unexpectedBetweenInitializerAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return "name"
    case 4:
      return nil
    case 5:
      return "internal name"
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    case 9:
      return nil
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return nil
    case 14:
      return nil
    case 15:
      return nil
    case 16:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TupleTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeInOut": unexpectedBeforeInOut.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inOut": inOut.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInOutAndName": unexpectedBetweenInOutAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenNameAndSecondName": unexpectedBetweenNameAndSecondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondName": secondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSecondNameAndColon": unexpectedBetweenSecondNameAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndType": unexpectedBetweenColonAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypeAndEllipsis": unexpectedBetweenTypeAndEllipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenEllipsisAndInitializer": unexpectedBetweenEllipsisAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInitializerAndTrailingComma": unexpectedBetweenInitializerAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentSyntax

public struct GenericArgumentSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeArgumentType: UnexpectedNodesSyntax? = nil,
    argumentType: TypeSyntax,
    _ unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArgumentType?.raw,
      argumentType.raw,
      unexpectedBetweenArgumentTypeAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeArgumentType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeArgumentType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeArgumentType` replaced.
  /// - param newChild: The new `unexpectedBeforeArgumentType` to replace the node's
  ///                   current `unexpectedBeforeArgumentType`, if present.
  public func withUnexpectedBeforeArgumentType(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericArgumentSyntax(newData)
  }

  public var argumentType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return GenericArgumentSyntax(newData)
  }

  public var unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentTypeAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentTypeAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentTypeAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenArgumentTypeAndTrailingComma`, if present.
  public func withUnexpectedBetweenArgumentTypeAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericArgumentSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return GenericArgumentSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeArgumentType,
      \Self.argumentType,
      \Self.unexpectedBetweenArgumentTypeAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeArgumentType": unexpectedBeforeArgumentType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentType": Syntax(argumentType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentTypeAndTrailingComma": unexpectedBetweenArgumentTypeAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentClauseSyntax

public struct GenericArgumentClauseSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: GenericArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax,
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
      unexpectedAfterRightAngleBracket?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftAngleBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftAngleBracket`, if present.
  public func withUnexpectedBeforeLeftAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return GenericArgumentClauseSyntax(newData)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return GenericArgumentClauseSyntax(newData)
  }

  public var unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftAngleBracketAndArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftAngleBracketAndArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftAngleBracketAndArguments` to replace the node's
  ///                   current `unexpectedBetweenLeftAngleBracketAndArguments`, if present.
  public func withUnexpectedBetweenLeftAngleBracketAndArguments(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return GenericArgumentClauseSyntax(newData)
  }

  public var arguments: GenericArgumentListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return GenericArgumentClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: GenericArgumentListSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return GenericArgumentClauseSyntax(newData)
  }

  public var unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentsAndRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentsAndRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentsAndRightAngleBracket` to replace the node's
  ///                   current `unexpectedBetweenArgumentsAndRightAngleBracket`, if present.
  public func withUnexpectedBetweenArgumentsAndRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return GenericArgumentClauseSyntax(newData)
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return GenericArgumentClauseSyntax(newData)
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightAngleBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightAngleBracket` to replace the node's
  ///                   current `unexpectedAfterRightAngleBracket`, if present.
  public func withUnexpectedAfterRightAngleBracket(
    _ newChild: UnexpectedNodesSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return GenericArgumentClauseSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftAngleBracket,
      \Self.leftAngleBracket,
      \Self.unexpectedBetweenLeftAngleBracketAndArguments,
      \Self.arguments,
      \Self.unexpectedBetweenArgumentsAndRightAngleBracket,
      \Self.rightAngleBracket,
      \Self.unexpectedAfterRightAngleBracket,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension GenericArgumentClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftAngleBracket": unexpectedBeforeLeftAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftAngleBracketAndArguments": unexpectedBetweenLeftAngleBracketAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentsAndRightAngleBracket": unexpectedBetweenArgumentsAndRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightAngleBracket": unexpectedAfterRightAngleBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeAnnotationSyntax

public struct TypeAnnotationSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax,
    _ unexpectedAfterType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeAnnotation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeColon` replaced.
  /// - param newChild: The new `unexpectedBeforeColon` to replace the node's
  ///                   current `unexpectedBeforeColon`, if present.
  public func withUnexpectedBeforeColon(
    _ newChild: UnexpectedNodesSyntax?) -> TypeAnnotationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TypeAnnotationSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return TypeAnnotationSyntax(newData)
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndType` to replace the node's
  ///                   current `unexpectedBetweenColonAndType`, if present.
  public func withUnexpectedBetweenColonAndType(
    _ newChild: UnexpectedNodesSyntax?) -> TypeAnnotationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TypeAnnotationSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return TypeAnnotationSyntax(newData)
  }

  public var unexpectedAfterType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterType` replaced.
  /// - param newChild: The new `unexpectedAfterType` to replace the node's
  ///                   current `unexpectedAfterType`, if present.
  public func withUnexpectedAfterType(
    _ newChild: UnexpectedNodesSyntax?) -> TypeAnnotationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TypeAnnotationSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndType,
      \Self.type,
      \Self.unexpectedAfterType,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TypeAnnotationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeColon": unexpectedBeforeColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndType": unexpectedBetweenColonAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterType": unexpectedAfterType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TuplePatternElementSyntax

public struct TuplePatternElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil,
    labelName: TokenSyntax?,
    _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil,
    labelColon: TokenSyntax?,
    _ unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabelName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabelName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabelName` replaced.
  /// - param newChild: The new `unexpectedBeforeLabelName` to replace the node's
  ///                   current `unexpectedBeforeLabelName`, if present.
  public func withUnexpectedBeforeLabelName(
    _ newChild: UnexpectedNodesSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TuplePatternElementSyntax(newData)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return TuplePatternElementSyntax(newData)
  }

  public var unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelNameAndLabelColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelNameAndLabelColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelNameAndLabelColon` to replace the node's
  ///                   current `unexpectedBetweenLabelNameAndLabelColon`, if present.
  public func withUnexpectedBetweenLabelNameAndLabelColon(
    _ newChild: UnexpectedNodesSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TuplePatternElementSyntax(newData)
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return TuplePatternElementSyntax(newData)
  }

  public var unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelColonAndPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelColonAndPattern` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelColonAndPattern` to replace the node's
  ///                   current `unexpectedBetweenLabelColonAndPattern`, if present.
  public func withUnexpectedBetweenLabelColonAndPattern(
    _ newChild: UnexpectedNodesSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TuplePatternElementSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return TuplePatternElementSyntax(newData)
  }

  public var unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenPatternAndTrailingComma`, if present.
  public func withUnexpectedBetweenPatternAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return TuplePatternElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return TuplePatternElementSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return TuplePatternElementSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabelName,
      \Self.labelName,
      \Self.unexpectedBetweenLabelNameAndLabelColon,
      \Self.labelColon,
      \Self.unexpectedBetweenLabelColonAndPattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TuplePatternElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabelName": unexpectedBeforeLabelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLabelNameAndLabelColon": unexpectedBetweenLabelNameAndLabelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLabelColonAndPattern": unexpectedBetweenLabelColonAndPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndTrailingComma": unexpectedBetweenPatternAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityArgumentSyntax

/// 
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,
/// or `message: "This has been deprecated"`.
/// 
public struct AvailabilityArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Entry: SyntaxChildChoices {
    case `star`(TokenSyntax)
    case `identifierRestriction`(TokenSyntax)
    case `availabilityVersionRestriction`(AvailabilityVersionRestrictionSyntax)
    case `availabilityLabeledArgument`(AvailabilityLabeledArgumentSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .star(let node): return node._syntaxNode
      case .identifierRestriction(let node): return node._syntaxNode
      case .availabilityVersionRestriction(let node): return node._syntaxNode
      case .availabilityLabeledArgument(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: AvailabilityVersionRestrictionSyntax) {
      self = .availabilityVersionRestriction(node)
    }
    public init(_ node: AvailabilityLabeledArgumentSyntax) {
      self = .availabilityLabeledArgument(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .spacedBinaryOperator: self = .star(tok)
        case .identifier: self = .identifierRestriction(tok)
        default: return nil
        }
        return
      }
      if let node = syntaxNode.as(AvailabilityVersionRestrictionSyntax.self) {
        self = .availabilityVersionRestriction(node)
        return
      }
      if let node = syntaxNode.as(AvailabilityLabeledArgumentSyntax.self) {
        self = .availabilityLabeledArgument(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.spacedBinaryOperator("")),
        .token(.identifier("")),
        .node(AvailabilityVersionRestrictionSyntax.self),
        .node(AvailabilityLabeledArgumentSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeEntry: UnexpectedNodesSyntax? = nil,
    entry: Entry,
    _ unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax?,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEntry?.raw,
      entry.raw,
      unexpectedBetweenEntryAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeEntry: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeEntry(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeEntry` replaced.
  /// - param newChild: The new `unexpectedBeforeEntry` to replace the node's
  ///                   current `unexpectedBeforeEntry`, if present.
  public func withUnexpectedBeforeEntry(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AvailabilityArgumentSyntax(newData)
  }

  /// The actual argument
  public var entry: Entry {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Entry(childData!)
    }
    set(value) {
      self = withEntry(value)
    }
  }

  /// Returns a copy of the receiver with its `entry` replaced.
  /// - param newChild: The new `entry` to replace the node's
  ///                   current `entry`, if present.
  public func withEntry(
    _ newChild: Entry?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AvailabilityArgumentSyntax(newData)
  }

  public var unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEntryAndTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEntryAndTrailingComma` replaced.
  /// - param newChild: The new `unexpectedBetweenEntryAndTrailingComma` to replace the node's
  ///                   current `unexpectedBetweenEntryAndTrailingComma`, if present.
  public func withUnexpectedBetweenEntryAndTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AvailabilityArgumentSyntax(newData)
  }

  /// 
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return AvailabilityArgumentSyntax(newData)
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTrailingComma` replaced.
  /// - param newChild: The new `unexpectedAfterTrailingComma` to replace the node's
  ///                   current `unexpectedAfterTrailingComma`, if present.
  public func withUnexpectedAfterTrailingComma(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AvailabilityArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeEntry,
      \Self.entry,
      \Self.unexpectedBetweenEntryAndTrailingComma,
      \Self.trailingComma,
      \Self.unexpectedAfterTrailingComma,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AvailabilityArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeEntry": unexpectedBeforeEntry.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "entry": Syntax(entry).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenEntryAndTrailingComma": unexpectedBetweenEntryAndTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTrailingComma": unexpectedAfterTrailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityLabeledArgumentSyntax

/// 
/// A argument to an `@available` attribute that consists of a label and
/// a value, e.g. `message: "This has been deprecated"`.
/// 
public struct AvailabilityLabeledArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Value: SyntaxChildChoices {
    case `string`(TokenSyntax)
    case `version`(VersionTupleSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .string(let node): return node._syntaxNode
      case .version(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: VersionTupleSyntax) {
      self = .version(node)
    }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .stringLiteral: self = .string(tok)
        default: return nil
        }
        return
      }
      if let node = syntaxNode.as(VersionTupleSyntax.self) {
        self = .version(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.stringLiteral("")),
        .node(VersionTupleSyntax.self),
      ])
    }
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

  public init(
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: Value,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityLabeledArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLabel` replaced.
  /// - param newChild: The new `unexpectedBeforeLabel` to replace the node's
  ///                   current `unexpectedBeforeLabel`, if present.
  public func withUnexpectedBeforeLabel(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLabelAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLabelAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenLabelAndColon` to replace the node's
  ///                   current `unexpectedBetweenLabelAndColon`, if present.
  public func withUnexpectedBetweenLabelAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  /// The colon separating label and value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndValue` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndValue` to replace the node's
  ///                   current `unexpectedBetweenColonAndValue`, if present.
  public func withUnexpectedBetweenColonAndValue(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  /// The value of this labeled argument
  public var value: Value {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return Value(childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: Value?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValue(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValue` replaced.
  /// - param newChild: The new `unexpectedAfterValue` to replace the node's
  ///                   current `unexpectedAfterValue`, if present.
  public func withUnexpectedAfterValue(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLabel,
      \Self.label,
      \Self.unexpectedBetweenLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndValue,
      \Self.value,
      \Self.unexpectedAfterValue,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "label"
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return "value"
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AvailabilityLabeledArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLabel": unexpectedBeforeLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLabelAndColon": unexpectedBetweenLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndValue": unexpectedBetweenColonAndValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValue": unexpectedAfterValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityVersionRestrictionSyntax

/// 
/// An argument to `@available` that restricts the availability on a
/// certain platform to a version, e.g. `iOS 10` or `swift 3.4`.
/// 
public struct AvailabilityVersionRestrictionSyntax: SyntaxProtocol, SyntaxHashable {
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

  public init(
    _ unexpectedBeforePlatform: UnexpectedNodesSyntax? = nil,
    platform: TokenSyntax,
    _ unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? = nil,
    version: VersionTupleSyntax?,
    _ unexpectedAfterVersion: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePlatform?.raw,
      platform.raw,
      unexpectedBetweenPlatformAndVersion?.raw,
      version?.raw,
      unexpectedAfterVersion?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityVersionRestriction,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePlatform: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePlatform(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePlatform` replaced.
  /// - param newChild: The new `unexpectedBeforePlatform` to replace the node's
  ///                   current `unexpectedBeforePlatform`, if present.
  public func withUnexpectedBeforePlatform(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  /// 
  /// The name of the OS on which the availability should be
  /// restricted or 'swift' if the availability should be
  /// restricted based on a Swift version.
  /// 
  public var platform: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  public var unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPlatformAndVersion(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPlatformAndVersion` replaced.
  /// - param newChild: The new `unexpectedBetweenPlatformAndVersion` to replace the node's
  ///                   current `unexpectedBetweenPlatformAndVersion`, if present.
  public func withUnexpectedBetweenPlatformAndVersion(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  public var version: VersionTupleSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  public var unexpectedAfterVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterVersion(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterVersion` replaced.
  /// - param newChild: The new `unexpectedAfterVersion` to replace the node's
  ///                   current `unexpectedAfterVersion`, if present.
  public func withUnexpectedAfterVersion(
    _ newChild: UnexpectedNodesSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePlatform,
      \Self.platform,
      \Self.unexpectedBetweenPlatformAndVersion,
      \Self.version,
      \Self.unexpectedAfterVersion,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return "platform"
    case 2:
      return nil
    case 3:
      return "version"
    case 4:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AvailabilityVersionRestrictionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePlatform": unexpectedBeforePlatform.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "platform": Syntax(platform).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPlatformAndVersion": unexpectedBetweenPlatformAndVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "version": version.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterVersion": unexpectedAfterVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - VersionTupleSyntax

/// 
/// A version number of the form major.minor.patch in which the minor
/// and patch part may be omitted.
/// 
public struct VersionTupleSyntax: SyntaxProtocol, SyntaxHashable {
  public enum MajorMinor: SyntaxChildChoices {
    case `major`(TokenSyntax)
    case `majorMinor`(TokenSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .major(let node): return node._syntaxNode
      case .majorMinor(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init?<Node: SyntaxProtocol>(_ syntaxNode: Node) {
      if let tok = syntaxNode.as(TokenSyntax.self) {
        switch tok.rawTokenKind {
        case .integerLiteral: self = .major(tok)
        case .floatingLiteral: self = .majorMinor(tok)
        default: return nil
        }
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .token(.integerLiteral("")),
        .token(.floatingLiteral("")),
      ])
    }
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

  public init(
    _ unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? = nil,
    majorMinor: MajorMinor,
    _ unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? = nil,
    patchPeriod: TokenSyntax?,
    _ unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? = nil,
    patchVersion: TokenSyntax?,
    _ unexpectedAfterPatchVersion: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMajorMinor?.raw,
      majorMinor.raw,
      unexpectedBetweenMajorMinorAndPatchPeriod?.raw,
      patchPeriod?.raw,
      unexpectedBetweenPatchPeriodAndPatchVersion?.raw,
      patchVersion?.raw,
      unexpectedAfterPatchVersion?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.versionTuple,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeMajorMinor(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeMajorMinor` replaced.
  /// - param newChild: The new `unexpectedBeforeMajorMinor` to replace the node's
  ///                   current `unexpectedBeforeMajorMinor`, if present.
  public func withUnexpectedBeforeMajorMinor(
    _ newChild: UnexpectedNodesSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return VersionTupleSyntax(newData)
  }

  /// 
  /// In case the version consists only of the major version, an
  /// integer literal that specifies the major version. In case
  /// the version consists of major and minor version number, a
  /// floating literal in which the decimal part is interpreted
  /// as the minor version.
  /// 
  public var majorMinor: MajorMinor {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return MajorMinor(childData!)
    }
    set(value) {
      self = withMajorMinor(value)
    }
  }

  /// Returns a copy of the receiver with its `majorMinor` replaced.
  /// - param newChild: The new `majorMinor` to replace the node's
  ///                   current `majorMinor`, if present.
  public func withMajorMinor(
    _ newChild: MajorMinor?) -> VersionTupleSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return VersionTupleSyntax(newData)
  }

  public var unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMajorMinorAndPatchPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMajorMinorAndPatchPeriod` replaced.
  /// - param newChild: The new `unexpectedBetweenMajorMinorAndPatchPeriod` to replace the node's
  ///                   current `unexpectedBetweenMajorMinorAndPatchPeriod`, if present.
  public func withUnexpectedBetweenMajorMinorAndPatchPeriod(
    _ newChild: UnexpectedNodesSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return VersionTupleSyntax(newData)
  }

  /// 
  /// If the version contains a patch number, the period
  /// separating the minor from the patch number.
  /// 
  public var patchPeriod: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return VersionTupleSyntax(newData)
  }

  public var unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatchPeriodAndPatchVersion(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatchPeriodAndPatchVersion` replaced.
  /// - param newChild: The new `unexpectedBetweenPatchPeriodAndPatchVersion` to replace the node's
  ///                   current `unexpectedBetweenPatchPeriodAndPatchVersion`, if present.
  public func withUnexpectedBetweenPatchPeriodAndPatchVersion(
    _ newChild: UnexpectedNodesSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return VersionTupleSyntax(newData)
  }

  /// 
  /// The patch version if specified.
  /// 
  public var patchVersion: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 5)
    return VersionTupleSyntax(newData)
  }

  public var unexpectedAfterPatchVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterPatchVersion(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterPatchVersion` replaced.
  /// - param newChild: The new `unexpectedAfterPatchVersion` to replace the node's
  ///                   current `unexpectedAfterPatchVersion`, if present.
  public func withUnexpectedAfterPatchVersion(
    _ newChild: UnexpectedNodesSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return VersionTupleSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeMajorMinor,
      \Self.majorMinor,
      \Self.unexpectedBetweenMajorMinorAndPatchPeriod,
      \Self.patchPeriod,
      \Self.unexpectedBetweenPatchPeriodAndPatchVersion,
      \Self.patchVersion,
      \Self.unexpectedAfterPatchVersion,
    ])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch index.data?.indexInParent {
    case 0:
      return nil
    case 1:
      return nil
    case 2:
      return nil
    case 3:
      return nil
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension VersionTupleSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeMajorMinor": unexpectedBeforeMajorMinor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "majorMinor": Syntax(majorMinor).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMajorMinorAndPatchPeriod": unexpectedBetweenMajorMinorAndPatchPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "patchPeriod": patchPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenPatchPeriodAndPatchVersion": unexpectedBetweenPatchPeriodAndPatchVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "patchVersion": patchVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterPatchVersion": unexpectedAfterPatchVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

