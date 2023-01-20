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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .missing else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MissingSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missing)
    self._syntaxNode = Syntax(data)
  }

  public init() {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), ())) { (arena, _) in
      let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena)
      return SyntaxData.forRoot(raw)
    }
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
    public var _syntaxNode: Syntax {
      switch self {
      case .decl(let node): return node._syntaxNode
      case .stmt(let node): return node._syntaxNode
      case .expr(let node): return node._syntaxNode
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(DeclSyntax.self) {
        self = .decl(node)
        return
      }
      if let node = node.as(StmtSyntax.self) {
        self = .stmt(node)
        return
      }
      if let node = node.as(ExprSyntax.self) {
        self = .expr(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(DeclSyntax.self),
        .node(StmtSyntax.self),
        .node(ExprSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .codeBlockItem else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CodeBlockItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .codeBlockItem)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeItem: UnexpectedNodesSyntax? = nil,
    item: Item,
    _ unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax? = nil,
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeItem, item, unexpectedBetweenItemAndSemicolon, semicolon, unexpectedAfterSemicolon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeItem?.raw,
        item.raw,
        unexpectedBetweenItemAndSemicolon?.raw,
        semicolon?.raw,
        unexpectedAfterSemicolon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.codeBlockItem, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeItem: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CodeBlockItemSyntax(newData)
    }
  }

  /// The underlying node inside the code block.
  public var item: Item {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Item(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CodeBlockItemSyntax(newData)
    }
  }

  public var unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CodeBlockItemSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CodeBlockItemSyntax(newData)
    }
  }

  public var unexpectedAfterSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CodeBlockItemSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeItem,
      \Self.item,
      \Self.unexpectedBetweenItemAndSemicolon,
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

extension CodeBlockItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeItem": unexpectedBeforeItem.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "item": Syntax(item).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenItemAndSemicolon": unexpectedBetweenItemAndSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterSemicolon": unexpectedAfterSemicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CodeBlockSyntax

public struct CodeBlockSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .codeBlock else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CodeBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .codeBlock)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax = .leftBraceToken(),
    _ unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax = .rightBraceToken(),
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftBrace, leftBrace, unexpectedBetweenLeftBraceAndStatements, statements, unexpectedBetweenStatementsAndRightBrace, rightBrace, unexpectedAfterRightBrace))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftBrace?.raw,
        leftBrace.raw,
        unexpectedBetweenLeftBraceAndStatements?.raw,
        statements.raw,
        unexpectedBetweenStatementsAndRightBrace?.raw,
        rightBrace.raw,
        unexpectedAfterRightBrace?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.codeBlock, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return CodeBlockSyntax(newData)
  }

  public var unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = CodeBlockSyntax(newData)
    }
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

// MARK: - DeclEffectSpecifiersSyntax

public struct DeclEffectSpecifiersSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declEffectSpecifiers else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclEffectSpecifiersSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declEffectSpecifiers)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? = nil,
    asyncSpecifier: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    throwsSpecifier: TokenSyntax? = nil,
    _ unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAsyncSpecifier, asyncSpecifier, unexpectedBetweenAsyncSpecifierAndThrowsSpecifier, throwsSpecifier, unexpectedAfterThrowsSpecifier))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAsyncSpecifier?.raw,
        asyncSpecifier?.raw,
        unexpectedBetweenAsyncSpecifierAndThrowsSpecifier?.raw,
        throwsSpecifier?.raw,
        unexpectedAfterThrowsSpecifier?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declEffectSpecifiers, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclEffectSpecifiersSyntax(newData)
    }
  }

  public var asyncSpecifier: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclEffectSpecifiersSyntax(newData)
    }
  }

  public var unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclEffectSpecifiersSyntax(newData)
    }
  }

  public var throwsSpecifier: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclEffectSpecifiersSyntax(newData)
    }
  }

  public var unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclEffectSpecifiersSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAsyncSpecifier,
      \Self.asyncSpecifier,
      \Self.unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      \Self.throwsSpecifier,
      \Self.unexpectedAfterThrowsSpecifier,
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

extension DeclEffectSpecifiersSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAsyncSpecifier": unexpectedBeforeAsyncSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncSpecifier": asyncSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncSpecifierAndThrowsSpecifier": unexpectedBetweenAsyncSpecifierAndThrowsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsSpecifier": throwsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterThrowsSpecifier": unexpectedAfterThrowsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeEffectSpecifiersSyntax

public struct TypeEffectSpecifiersSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .typeEffectSpecifiers else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TypeEffectSpecifiersSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeEffectSpecifiers)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? = nil,
    asyncSpecifier: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    throwsSpecifier: TokenSyntax? = nil,
    _ unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAsyncSpecifier, asyncSpecifier, unexpectedBetweenAsyncSpecifierAndThrowsSpecifier, throwsSpecifier, unexpectedAfterThrowsSpecifier))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAsyncSpecifier?.raw,
        asyncSpecifier?.raw,
        unexpectedBetweenAsyncSpecifierAndThrowsSpecifier?.raw,
        throwsSpecifier?.raw,
        unexpectedAfterThrowsSpecifier?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.typeEffectSpecifiers, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TypeEffectSpecifiersSyntax(newData)
    }
  }

  public var asyncSpecifier: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TypeEffectSpecifiersSyntax(newData)
    }
  }

  public var unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TypeEffectSpecifiersSyntax(newData)
    }
  }

  public var throwsSpecifier: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TypeEffectSpecifiersSyntax(newData)
    }
  }

  public var unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TypeEffectSpecifiersSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAsyncSpecifier,
      \Self.asyncSpecifier,
      \Self.unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      \Self.throwsSpecifier,
      \Self.unexpectedAfterThrowsSpecifier,
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

extension TypeEffectSpecifiersSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAsyncSpecifier": unexpectedBeforeAsyncSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncSpecifier": asyncSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncSpecifierAndThrowsSpecifier": unexpectedBetweenAsyncSpecifierAndThrowsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsSpecifier": throwsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterThrowsSpecifier": unexpectedAfterThrowsSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameArgumentSyntax

public struct DeclNameArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declNameArgument else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclNameArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declNameArgument)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndColon, colon, unexpectedAfterColon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndColon?.raw,
        colon.raw,
        unexpectedAfterColon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declNameArgument, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclNameArgumentSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclNameArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclNameArgumentSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclNameArgumentSyntax(newData)
    }
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclNameArgumentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declNameArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclNameArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declNameArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndArguments, arguments, unexpectedBetweenArgumentsAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndArguments?.raw,
        arguments.raw,
        unexpectedBetweenArgumentsAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declNameArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
  }

  public var arguments: DeclNameArgumentListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return DeclNameArgumentListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgumentList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return DeclNameArgumentsSyntax(newData)
  }

  public var unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DeclNameArgumentsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tupleExprElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TupleExprElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleExprElement)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax? = nil,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndExpression, expression, unexpectedBetweenExpressionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.tupleExprElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = TupleExprElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .arrayElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ArrayElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrayElement)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeExpression, expression, unexpectedBetweenExpressionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeExpression?.raw,
        expression.raw,
        unexpectedBetweenExpressionAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.arrayElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ArrayElementSyntax(newData)
    }
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ArrayElementSyntax(newData)
    }
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ArrayElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ArrayElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ArrayElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .dictionaryElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DictionaryElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dictionaryElement)
    self._syntaxNode = Syntax(data)
  }

  public init<K: ExprSyntaxProtocol, V: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? = nil,
    keyExpression: K,
    _ unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? = nil,
    valueExpression: V,
    _ unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeKeyExpression, keyExpression, unexpectedBetweenKeyExpressionAndColon, colon, unexpectedBetweenColonAndValueExpression, valueExpression, unexpectedBetweenValueExpressionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.dictionaryElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var keyExpression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var valueExpression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = DictionaryElementSyntax(newData)
    }
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

// MARK: - ClosureCaptureItemSpecifierSyntax

public struct ClosureCaptureItemSpecifierSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureCaptureItemSpecifier else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClosureCaptureItemSpecifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureItemSpecifier)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: TokenSyntax,
    _ unexpectedBetweenSpecifierAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    _ unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? = nil,
    detail: TokenSyntax? = nil,
    _ unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeSpecifier, specifier, unexpectedBetweenSpecifierAndLeftParen, leftParen, unexpectedBetweenLeftParenAndDetail, detail, unexpectedBetweenDetailAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeSpecifier?.raw,
        specifier.raw,
        unexpectedBetweenSpecifierAndLeftParen?.raw,
        leftParen?.raw,
        unexpectedBetweenLeftParenAndDetail?.raw,
        detail?.raw,
        unexpectedBetweenDetailAndRightParen?.raw,
        rightParen?.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.closureCaptureItemSpecifier, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var specifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var unexpectedBetweenSpecifierAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var detail: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ClosureCaptureItemSpecifierSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSpecifier,
      \Self.specifier,
      \Self.unexpectedBetweenSpecifierAndLeftParen,
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
    case 7:
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension ClosureCaptureItemSpecifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSpecifier": unexpectedBeforeSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "specifier": Syntax(specifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSpecifierAndLeftParen": unexpectedBetweenSpecifierAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndDetail": unexpectedBetweenLeftParenAndDetail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "detail": detail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDetailAndRightParen": unexpectedBetweenDetailAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureItemSyntax

public struct ClosureCaptureItemSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureCaptureItem else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClosureCaptureItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureItem)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: ClosureCaptureItemSpecifierSyntax? = nil,
    _ unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax? = nil,
    _ unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? = nil,
    assignToken: TokenSyntax? = nil,
    _ unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeSpecifier, specifier, unexpectedBetweenSpecifierAndName, name, unexpectedBetweenNameAndAssignToken, assignToken, unexpectedBetweenAssignTokenAndExpression, expression, unexpectedBetweenExpressionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.closureCaptureItem, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeSpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var specifier: ClosureCaptureItemSpecifierSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureCaptureItemSpecifierSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var assignToken: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = ClosureCaptureItemSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureCaptureSignature else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClosureCaptureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureSignature)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil,
    leftSquare: TokenSyntax = .leftSquareBracketToken(),
    _ unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? = nil,
    items: ClosureCaptureItemListSyntax? = nil,
    _ unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? = nil,
    rightSquare: TokenSyntax = .rightSquareBracketToken(),
    _ unexpectedAfterRightSquare: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftSquare, leftSquare, unexpectedBetweenLeftSquareAndItems, items, unexpectedBetweenItemsAndRightSquare, rightSquare, unexpectedAfterRightSquare))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftSquare?.raw,
        leftSquare.raw,
        unexpectedBetweenLeftSquareAndItems?.raw,
        items?.raw,
        unexpectedBetweenItemsAndRightSquare?.raw,
        rightSquare.raw,
        unexpectedAfterRightSquare?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.closureCaptureSignature, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
  }

  public var items: ClosureCaptureItemListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureCaptureItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ClosureCaptureSignatureSyntax(newData)
  }

  public var unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
  }

  public var unexpectedAfterRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ClosureCaptureSignatureSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureParam else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClosureParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureParam)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.closureParam, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ClosureParamSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ClosureParamSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ClosureParamSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ClosureParamSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ClosureParamSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(ClosureParamListSyntax.self) {
        self = .simpleInput(node)
        return
      }
      if let node = node.as(ParameterClauseSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureSignature else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClosureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureSignature)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? = nil,
    capture: ClosureCaptureSignatureSyntax? = nil,
    _ unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? = nil,
    input: Input? = nil,
    _ unexpectedBetweenInputAndEffectSpecifiers: UnexpectedNodesSyntax? = nil,
    effectSpecifiers: TypeEffectSpecifiersSyntax? = nil,
    _ unexpectedBetweenEffectSpecifiersAndOutput: UnexpectedNodesSyntax? = nil,
    output: ReturnClauseSyntax? = nil,
    _ unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? = nil,
    inTok: TokenSyntax = .keyword(.in),
    _ unexpectedAfterInTok: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAttributes, attributes, unexpectedBetweenAttributesAndCapture, capture, unexpectedBetweenCaptureAndInput, input, unexpectedBetweenInputAndEffectSpecifiers, effectSpecifiers, unexpectedBetweenEffectSpecifiersAndOutput, output, unexpectedBetweenOutputAndInTok, inTok, unexpectedAfterInTok))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAttributes?.raw,
        attributes?.raw,
        unexpectedBetweenAttributesAndCapture?.raw,
        capture?.raw,
        unexpectedBetweenCaptureAndInput?.raw,
        input?.raw,
        unexpectedBetweenInputAndEffectSpecifiers?.raw,
        effectSpecifiers?.raw,
        unexpectedBetweenEffectSpecifiersAndOutput?.raw,
        output?.raw,
        unexpectedBetweenOutputAndInTok?.raw,
        inTok.raw,
        unexpectedAfterInTok?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.closureSignature, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ClosureSignatureSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var capture: ClosureCaptureSignatureSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureCaptureSignatureSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var input: Input? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return Input(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenInputAndEffectSpecifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var effectSpecifiers: TypeEffectSpecifiersSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeEffectSpecifiersSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenEffectSpecifiersAndOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return ReturnClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var inTok: TokenSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public var unexpectedAfterInTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = ClosureSignatureSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndCapture,
      \Self.capture,
      \Self.unexpectedBetweenCaptureAndInput,
      \Self.input,
      \Self.unexpectedBetweenInputAndEffectSpecifiers,
      \Self.effectSpecifiers,
      \Self.unexpectedBetweenEffectSpecifiersAndOutput,
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
      "unexpectedBetweenInputAndEffectSpecifiers": unexpectedBetweenInputAndEffectSpecifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "effectSpecifiers": effectSpecifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenEffectSpecifiersAndOutput": unexpectedBetweenEffectSpecifiersAndOutput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .multipleTrailingClosureElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MultipleTrailingClosureElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .multipleTrailingClosureElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? = nil,
    closure: ClosureExprSyntax,
    _ unexpectedAfterClosure: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndClosure, closure, unexpectedAfterClosure))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLabel?.raw,
        label.raw,
        unexpectedBetweenLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndClosure?.raw,
        closure.raw,
        unexpectedAfterClosure?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.multipleTrailingClosureElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var closure: ClosureExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return ClosureExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
  }

  public var unexpectedAfterClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = MultipleTrailingClosureElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .stringSegment else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `StringSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .stringSegment)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeContent: UnexpectedNodesSyntax? = nil,
    content: TokenSyntax,
    _ unexpectedAfterContent: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeContent, content, unexpectedAfterContent))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeContent?.raw,
        content.raw,
        unexpectedAfterContent?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.stringSegment, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeContent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = StringSegmentSyntax(newData)
    }
  }

  public var content: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = StringSegmentSyntax(newData)
    }
  }

  public var unexpectedAfterContent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = StringSegmentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .expressionSegment else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ExpressionSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionSegment)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil,
    backslash: TokenSyntax = .backslashToken(),
    _ unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? = nil,
    delimiter: TokenSyntax? = nil,
    _ unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? = nil,
    expressions: TupleExprElementListSyntax,
    _ unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeBackslash, backslash, unexpectedBetweenBackslashAndDelimiter, delimiter, unexpectedBetweenDelimiterAndLeftParen, leftParen, unexpectedBetweenLeftParenAndExpressions, expressions, unexpectedBetweenExpressionsAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.expressionSegment, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeBackslash: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var delimiter: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var expressions: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TupleExprElementListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[7] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 7, with: collection, arena: arena)
    return ExpressionSegmentSyntax(newData)
  }

  public var unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = ExpressionSegmentSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(KeyPathPropertyComponentSyntax.self) {
        self = .property(node)
        return
      }
      if let node = node.as(KeyPathSubscriptComponentSyntax.self) {
        self = .subscript(node)
        return
      }
      if let node = node.as(KeyPathOptionalComponentSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .keyPathComponent else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `KeyPathComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax? = nil,
    _ unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? = nil,
    component: Component,
    _ unexpectedAfterComponent: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePeriod, period, unexpectedBetweenPeriodAndComponent, component, unexpectedAfterComponent))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforePeriod?.raw,
        period?.raw,
        unexpectedBetweenPeriodAndComponent?.raw,
        component.raw,
        unexpectedAfterComponent?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.keyPathComponent, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = KeyPathComponentSyntax(newData)
    }
  }

  public var period: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = KeyPathComponentSyntax(newData)
    }
  }

  public var unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = KeyPathComponentSyntax(newData)
    }
  }

  public var component: Component {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return Component(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = KeyPathComponentSyntax(newData)
    }
  }

  public var unexpectedAfterComponent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = KeyPathComponentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .keyPathPropertyComponent else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `KeyPathPropertyComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathPropertyComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax? = nil,
    _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeIdentifier, identifier, unexpectedBetweenIdentifierAndDeclNameArguments, declNameArguments, unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause, genericArgumentClause, unexpectedAfterGenericArgumentClause))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeIdentifier?.raw,
        identifier.raw,
        unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
        declNameArguments?.raw,
        unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause?.raw,
        genericArgumentClause?.raw,
        unexpectedAfterGenericArgumentClause?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.keyPathPropertyComponent, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericArgumentClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
  }

  public var unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = KeyPathPropertyComponentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .keyPathSubscriptComponent else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `KeyPathSubscriptComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathSubscriptComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? = nil,
    leftBracket: TokenSyntax = .leftSquareBracketToken(),
    _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil,
    rightBracket: TokenSyntax = .rightSquareBracketToken(),
    _ unexpectedAfterRightBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftBracket, leftBracket, unexpectedBetweenLeftBracketAndArgumentList, argumentList, unexpectedBetweenArgumentListAndRightBracket, rightBracket, unexpectedAfterRightBracket))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftBracket?.raw,
        leftBracket.raw,
        unexpectedBetweenLeftBracketAndArgumentList?.raw,
        argumentList.raw,
        unexpectedBetweenArgumentListAndRightBracket?.raw,
        rightBracket.raw,
        unexpectedAfterRightBracket?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.keyPathSubscriptComponent, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
  }

  public var leftBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TupleExprElementListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return KeyPathSubscriptComponentSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
  }

  public var rightBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
  }

  public var unexpectedAfterRightBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = KeyPathSubscriptComponentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .keyPathOptionalComponent else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `KeyPathOptionalComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathOptionalComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax,
    _ unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeQuestionOrExclamationMark, questionOrExclamationMark, unexpectedAfterQuestionOrExclamationMark))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeQuestionOrExclamationMark?.raw,
        questionOrExclamationMark.raw,
        unexpectedAfterQuestionOrExclamationMark?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.keyPathOptionalComponent, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = KeyPathOptionalComponentSyntax(newData)
    }
  }

  public var questionOrExclamationMark: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = KeyPathOptionalComponentSyntax(newData)
    }
  }

  public var unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = KeyPathOptionalComponentSyntax(newData)
    }
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

// MARK: - YieldExprListElementSyntax

public struct YieldExprListElementSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .yieldExprListElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `YieldExprListElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldExprListElement)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax? = nil,
    _ unexpectedAfterComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeExpression, expression, unexpectedBetweenExpressionAndComma, comma, unexpectedAfterComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeExpression?.raw,
        expression.raw,
        unexpectedBetweenExpressionAndComma?.raw,
        comma?.raw,
        unexpectedAfterComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.yieldExprListElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = YieldExprListElementSyntax(newData)
    }
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = YieldExprListElementSyntax(newData)
    }
  }

  public var unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = YieldExprListElementSyntax(newData)
    }
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = YieldExprListElementSyntax(newData)
    }
  }

  public var unexpectedAfterComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = YieldExprListElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .typeInitializerClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TypeInitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeInitializerClause)
    self._syntaxNode = Syntax(data)
  }

  public init<V: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil,
    equal: TokenSyntax = .equalToken(),
    _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil,
    value: V,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeEqual, equal, unexpectedBetweenEqualAndValue, value, unexpectedAfterValue))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeEqual?.raw,
        equal.raw,
        unexpectedBetweenEqualAndValue?.raw,
        value.raw,
        unexpectedAfterValue?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.typeInitializerClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeEqual: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TypeInitializerClauseSyntax(newData)
    }
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TypeInitializerClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TypeInitializerClauseSyntax(newData)
    }
  }

  public var value: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TypeInitializerClauseSyntax(newData)
    }
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TypeInitializerClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .parameterClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .parameterClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? = nil,
    parameterList: FunctionParameterListSyntax,
    _ unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndParameterList, parameterList, unexpectedBetweenParameterListAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndParameterList?.raw,
        parameterList.raw,
        unexpectedBetweenParameterListAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.parameterClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
  }

  public var parameterList: FunctionParameterListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return FunctionParameterListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.functionParameterList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ParameterClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .returnClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ReturnClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .returnClause)
    self._syntaxNode = Syntax(data)
  }

  public init<R: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeArrow: UnexpectedNodesSyntax? = nil,
    arrow: TokenSyntax = .arrowToken(),
    _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil,
    returnType: R,
    _ unexpectedAfterReturnType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeArrow, arrow, unexpectedBetweenArrowAndReturnType, returnType, unexpectedAfterReturnType))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeArrow?.raw,
        arrow.raw,
        unexpectedBetweenArrowAndReturnType?.raw,
        returnType.raw,
        unexpectedAfterReturnType?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.returnClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeArrow: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ReturnClauseSyntax(newData)
    }
  }

  public var arrow: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ReturnClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ReturnClauseSyntax(newData)
    }
  }

  public var returnType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ReturnClauseSyntax(newData)
    }
  }

  public var unexpectedAfterReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ReturnClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .functionSignature else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `FunctionSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionSignature)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeInput: UnexpectedNodesSyntax? = nil,
    input: ParameterClauseSyntax,
    _ unexpectedBetweenInputAndEffectSpecifiers: UnexpectedNodesSyntax? = nil,
    effectSpecifiers: DeclEffectSpecifiersSyntax? = nil,
    _ unexpectedBetweenEffectSpecifiersAndOutput: UnexpectedNodesSyntax? = nil,
    output: ReturnClauseSyntax? = nil,
    _ unexpectedAfterOutput: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeInput, input, unexpectedBetweenInputAndEffectSpecifiers, effectSpecifiers, unexpectedBetweenEffectSpecifiersAndOutput, output, unexpectedAfterOutput))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeInput?.raw,
        input.raw,
        unexpectedBetweenInputAndEffectSpecifiers?.raw,
        effectSpecifiers?.raw,
        unexpectedBetweenEffectSpecifiersAndOutput?.raw,
        output?.raw,
        unexpectedAfterOutput?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.functionSignature, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeInput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var input: ParameterClauseSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return ParameterClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenInputAndEffectSpecifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var effectSpecifiers: DeclEffectSpecifiersSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclEffectSpecifiersSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var unexpectedBetweenEffectSpecifiersAndOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return ReturnClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public var unexpectedAfterOutput: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = FunctionSignatureSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeInput,
      \Self.input,
      \Self.unexpectedBetweenInputAndEffectSpecifiers,
      \Self.effectSpecifiers,
      \Self.unexpectedBetweenEffectSpecifiersAndOutput,
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
      "unexpectedBetweenInputAndEffectSpecifiers": unexpectedBetweenInputAndEffectSpecifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "effectSpecifiers": effectSpecifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenEffectSpecifiersAndOutput": unexpectedBetweenEffectSpecifiersAndOutput.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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
    case `attributes`(AttributeListSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .statements(let node): return node._syntaxNode
      case .switchCases(let node): return node._syntaxNode
      case .decls(let node): return node._syntaxNode
      case .postfixExpression(let node): return node._syntaxNode
      case .attributes(let node): return node._syntaxNode
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
    public init(_ node: AttributeListSyntax) {
      self = .attributes(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(CodeBlockItemListSyntax.self) {
        self = .statements(node)
        return
      }
      if let node = node.as(SwitchCaseListSyntax.self) {
        self = .switchCases(node)
        return
      }
      if let node = node.as(MemberDeclListSyntax.self) {
        self = .decls(node)
        return
      }
      if let node = node.as(ExprSyntax.self) {
        self = .postfixExpression(node)
        return
      }
      if let node = node.as(AttributeListSyntax.self) {
        self = .attributes(node)
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
        .node(AttributeListSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .ifConfigClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IfConfigClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifConfigClause)
    self._syntaxNode = Syntax(data)
  }

  public init<C: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? = nil,
    poundKeyword: TokenSyntax,
    _ unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? = nil,
    condition: C? = nil,
    _ unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? = nil,
    elements: Elements? = nil,
    _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePoundKeyword, poundKeyword, unexpectedBetweenPoundKeywordAndCondition, condition, unexpectedBetweenConditionAndElements, elements, unexpectedAfterElements))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforePoundKeyword?.raw,
        poundKeyword.raw,
        unexpectedBetweenPoundKeywordAndCondition?.raw,
        condition?.raw,
        unexpectedBetweenConditionAndElements?.raw,
        elements?.raw,
        unexpectedAfterElements?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.ifConfigClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? = nil,
    poundKeyword: TokenSyntax,
    _ unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? = nil,
    condition: MissingExprSyntax? = nil,
    _ unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? = nil,
    elements: Elements? = nil,
    _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforePoundKeyword,
      poundKeyword: poundKeyword,
      unexpectedBetweenPoundKeywordAndCondition,
      condition: Optional<ExprSyntax>.none,
      unexpectedBetweenConditionAndElements,
      elements: elements,
      unexpectedAfterElements,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var poundKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var condition: ExprSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var elements: Elements? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return Elements(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
  }

  public var unexpectedAfterElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = IfConfigClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .poundSourceLocationArgs else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PoundSourceLocationArgsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundSourceLocationArgs)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? = nil,
    fileArgLabel: TokenSyntax = .identifier("file"),
    _ unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? = nil,
    fileArgColon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? = nil,
    fileName: StringLiteralExprSyntax,
    _ unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax = .commaToken(),
    _ unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? = nil,
    lineArgLabel: TokenSyntax = .identifier("line"),
    _ unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? = nil,
    lineArgColon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? = nil,
    lineNumber: TokenSyntax,
    _ unexpectedAfterLineNumber: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeFileArgLabel, fileArgLabel, unexpectedBetweenFileArgLabelAndFileArgColon, fileArgColon, unexpectedBetweenFileArgColonAndFileName, fileName, unexpectedBetweenFileNameAndComma, comma, unexpectedBetweenCommaAndLineArgLabel, lineArgLabel, unexpectedBetweenLineArgLabelAndLineArgColon, lineArgColon, unexpectedBetweenLineArgColonAndLineNumber, lineNumber, unexpectedAfterLineNumber))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.poundSourceLocationArgs, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var fileArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var fileArgColon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var fileName: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var lineArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var lineArgColon: TokenSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var lineNumber: TokenSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 13, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
  }

  public var unexpectedAfterLineNumber: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 14, with: raw, arena: arena)
      self = PoundSourceLocationArgsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declModifierDetail else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclModifierDetailSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declModifierDetail)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? = nil,
    detail: TokenSyntax,
    _ unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndDetail, detail, unexpectedBetweenDetailAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndDetail?.raw,
        detail.raw,
        unexpectedBetweenDetailAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declModifierDetail, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var detail: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DeclModifierDetailSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declModifier else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclModifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declModifier)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? = nil,
    detail: DeclModifierDetailSyntax? = nil,
    _ unexpectedAfterDetail: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndDetail, detail, unexpectedAfterDetail))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndDetail?.raw,
        detail?.raw,
        unexpectedAfterDetail?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declModifier, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclModifierSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclModifierSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclModifierSyntax(newData)
    }
  }

  public var detail: DeclModifierDetailSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclModifierDetailSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclModifierSyntax(newData)
    }
  }

  public var unexpectedAfterDetail: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclModifierSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .inheritedType else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `InheritedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .inheritedType)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeTypeName: UnexpectedNodesSyntax? = nil,
    typeName: T,
    _ unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeTypeName, typeName, unexpectedBetweenTypeNameAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeTypeName?.raw,
        typeName.raw,
        unexpectedBetweenTypeNameAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.inheritedType, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeTypeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = InheritedTypeSyntax(newData)
    }
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = InheritedTypeSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = InheritedTypeSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = InheritedTypeSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = InheritedTypeSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .typeInheritanceClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TypeInheritanceClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeInheritanceClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? = nil,
    inheritedTypeCollection: InheritedTypeListSyntax,
    _ unexpectedAfterInheritedTypeCollection: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeColon, colon, unexpectedBetweenColonAndInheritedTypeCollection, inheritedTypeCollection, unexpectedAfterInheritedTypeCollection))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndInheritedTypeCollection?.raw,
        inheritedTypeCollection.raw,
        unexpectedAfterInheritedTypeCollection?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.typeInheritanceClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TypeInheritanceClauseSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TypeInheritanceClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TypeInheritanceClauseSyntax(newData)
    }
  }

  public var inheritedTypeCollection: InheritedTypeListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return InheritedTypeListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TypeInheritanceClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.inheritedTypeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return TypeInheritanceClauseSyntax(newData)
  }

  public var unexpectedAfterInheritedTypeCollection: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TypeInheritanceClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .memberDeclBlock else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MemberDeclBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberDeclBlock)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax = .leftBraceToken(),
    _ unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclListSyntax,
    _ unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax = .rightBraceToken(),
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftBrace, leftBrace, unexpectedBetweenLeftBraceAndMembers, members, unexpectedBetweenMembersAndRightBrace, rightBrace, unexpectedAfterRightBrace))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftBrace?.raw,
        leftBrace.raw,
        unexpectedBetweenLeftBraceAndMembers?.raw,
        members.raw,
        unexpectedBetweenMembersAndRightBrace?.raw,
        rightBrace.raw,
        unexpectedAfterRightBrace?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.memberDeclBlock, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
  }

  public var members: MemberDeclListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return MemberDeclListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return MemberDeclBlockSyntax(newData)
  }

  public var unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = MemberDeclBlockSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .memberDeclListItem else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MemberDeclListItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberDeclListItem)
    self._syntaxNode = Syntax(data)
  }

  public init<D: DeclSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeDecl: UnexpectedNodesSyntax? = nil,
    decl: D,
    _ unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax? = nil,
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeDecl, decl, unexpectedBetweenDeclAndSemicolon, semicolon, unexpectedAfterSemicolon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeDecl?.raw,
        decl.raw,
        unexpectedBetweenDeclAndSemicolon?.raw,
        semicolon?.raw,
        unexpectedAfterSemicolon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.memberDeclListItem, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeDecl: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = MemberDeclListItemSyntax(newData)
    }
  }

  /// The declaration of the type member.
  public var decl: DeclSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return DeclSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = MemberDeclListItemSyntax(newData)
    }
  }

  public var unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = MemberDeclListItemSyntax(newData)
    }
  }

  /// An optional trailing semicolon.
  public var semicolon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = MemberDeclListItemSyntax(newData)
    }
  }

  public var unexpectedAfterSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = MemberDeclListItemSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .sourceFile else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SourceFileSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .sourceFile)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? = nil,
    eofToken: TokenSyntax,
    _ unexpectedAfterEOFToken: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeStatements, statements, unexpectedBetweenStatementsAndEOFToken, eofToken, unexpectedAfterEOFToken))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeStatements?.raw,
        statements.raw,
        unexpectedBetweenStatementsAndEOFToken?.raw,
        eofToken.raw,
        unexpectedAfterEOFToken?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.sourceFile, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = SourceFileSyntax(newData)
    }
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = SourceFileSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return SourceFileSyntax(newData)
  }

  public var unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = SourceFileSyntax(newData)
    }
  }

  public var eofToken: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = SourceFileSyntax(newData)
    }
  }

  public var unexpectedAfterEOFToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = SourceFileSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .initializerClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `InitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .initializerClause)
    self._syntaxNode = Syntax(data)
  }

  public init<V: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil,
    equal: TokenSyntax = .equalToken(),
    _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil,
    value: V,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeEqual, equal, unexpectedBetweenEqualAndValue, value, unexpectedAfterValue))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeEqual?.raw,
        equal.raw,
        unexpectedBetweenEqualAndValue?.raw,
        value.raw,
        unexpectedAfterValue?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.initializerClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeEqual: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = InitializerClauseSyntax(newData)
    }
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = InitializerClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = InitializerClauseSyntax(newData)
    }
  }

  public var value: ExprSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = InitializerClauseSyntax(newData)
    }
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = InitializerClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .functionParameter else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `FunctionParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionParameter)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? = nil,
    firstName: TokenSyntax? = nil,
    _ unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? = nil,
    secondName: TokenSyntax? = nil,
    _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: T? = nil,
    _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax? = nil,
    _ unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? = nil,
    defaultArgument: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAttributes, attributes, unexpectedBetweenAttributesAndModifiers, modifiers, unexpectedBetweenModifiersAndFirstName, firstName, unexpectedBetweenFirstNameAndSecondName, secondName, unexpectedBetweenSecondNameAndColon, colon, unexpectedBetweenColonAndType, type, unexpectedBetweenTypeAndEllipsis, ellipsis, unexpectedBetweenEllipsisAndDefaultArgument, defaultArgument, unexpectedBetweenDefaultArgumentAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.functionParameter, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? = nil,
    firstName: TokenSyntax? = nil,
    _ unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? = nil,
    secondName: TokenSyntax? = nil,
    _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: MissingTypeSyntax? = nil,
    _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax? = nil,
    _ unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? = nil,
    defaultArgument: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAttributes,
      attributes: attributes,
      unexpectedBetweenAttributesAndModifiers,
      modifiers: modifiers,
      unexpectedBetweenModifiersAndFirstName,
      firstName: firstName,
      unexpectedBetweenFirstNameAndSecondName,
      secondName: secondName,
      unexpectedBetweenSecondNameAndColon,
      colon: colon,
      unexpectedBetweenColonAndType,
      type: Optional<TypeSyntax>.none,
      unexpectedBetweenTypeAndEllipsis,
      ellipsis: ellipsis,
      unexpectedBetweenEllipsisAndDefaultArgument,
      defaultArgument: defaultArgument,
      unexpectedBetweenDefaultArgumentAndTrailingComma,
      trailingComma: trailingComma,
      unexpectedAfterTrailingComma,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ModifierListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return FunctionParameterSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var firstName: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 13, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 14, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var defaultArgument: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 15, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 16, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 17, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 17, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 18, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 18, with: raw, arena: arena)
      self = FunctionParameterSyntax(newData)
    }
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

// MARK: - AccessPathComponentSyntax

public struct AccessPathComponentSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessPathComponent else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AccessPathComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessPathComponent)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? = nil,
    trailingDot: TokenSyntax? = nil,
    _ unexpectedAfterTrailingDot: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndTrailingDot, trailingDot, unexpectedAfterTrailingDot))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndTrailingDot?.raw,
        trailingDot?.raw,
        unexpectedAfterTrailingDot?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.accessPathComponent, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AccessPathComponentSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AccessPathComponentSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AccessPathComponentSyntax(newData)
    }
  }

  public var trailingDot: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AccessPathComponentSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AccessPathComponentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessorParameter else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AccessorParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorParameter)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndName, name, unexpectedBetweenNameAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndName?.raw,
        name.raw,
        unexpectedBetweenNameAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.accessorParameter, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AccessorParameterSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessorBlock else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AccessorBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorBlock)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax = .leftBraceToken(),
    _ unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? = nil,
    accessors: AccessorListSyntax,
    _ unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax = .rightBraceToken(),
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftBrace, leftBrace, unexpectedBetweenLeftBraceAndAccessors, accessors, unexpectedBetweenAccessorsAndRightBrace, rightBrace, unexpectedAfterRightBrace))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftBrace?.raw,
        leftBrace.raw,
        unexpectedBetweenLeftBraceAndAccessors?.raw,
        accessors.raw,
        unexpectedBetweenAccessorsAndRightBrace?.raw,
        rightBrace.raw,
        unexpectedAfterRightBrace?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.accessorBlock, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
  }

  public var accessors: AccessorListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return AccessorListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.accessorList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return AccessorBlockSyntax(newData)
  }

  public var unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AccessorBlockSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(AccessorBlockSyntax.self) {
        self = .accessors(node)
        return
      }
      if let node = node.as(CodeBlockSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .patternBinding else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PatternBindingSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .patternBinding)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? = nil,
    accessor: Accessor? = nil,
    _ unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePattern, pattern, unexpectedBetweenPatternAndTypeAnnotation, typeAnnotation, unexpectedBetweenTypeAnnotationAndInitializer, initializer, unexpectedBetweenInitializerAndAccessor, accessor, unexpectedBetweenAccessorAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.patternBinding, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var accessor: Accessor? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return Accessor(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = PatternBindingSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .enumCaseElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `EnumCaseElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCaseElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? = nil,
    associatedValue: ParameterClauseSyntax? = nil,
    _ unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? = nil,
    rawValue: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeIdentifier, identifier, unexpectedBetweenIdentifierAndAssociatedValue, associatedValue, unexpectedBetweenAssociatedValueAndRawValue, rawValue, unexpectedBetweenRawValueAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.enumCaseElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  /// The name of this case.
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  public var unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  /// The set of associated values of the case.
  public var associatedValue: ParameterClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return ParameterClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  public var unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  public var unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = EnumCaseElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .designatedTypeElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DesignatedTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .designatedTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? = nil,
    leadingComma: TokenSyntax = .commaToken(),
    _ unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedAfterName: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeadingComma, leadingComma, unexpectedBetweenLeadingCommaAndName, name, unexpectedAfterName))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeadingComma?.raw,
        leadingComma.raw,
        unexpectedBetweenLeadingCommaAndName?.raw,
        name.raw,
        unexpectedAfterName?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.designatedTypeElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DesignatedTypeElementSyntax(newData)
    }
  }

  public var leadingComma: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DesignatedTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DesignatedTypeElementSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DesignatedTypeElementSyntax(newData)
    }
  }

  public var unexpectedAfterName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DesignatedTypeElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .operatorPrecedenceAndTypes else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OperatorPrecedenceAndTypesSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .operatorPrecedenceAndTypes)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? = nil,
    precedenceGroup: TokenSyntax,
    _ unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? = nil,
    designatedTypes: DesignatedTypeListSyntax,
    _ unexpectedAfterDesignatedTypes: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeColon, colon, unexpectedBetweenColonAndPrecedenceGroup, precedenceGroup, unexpectedBetweenPrecedenceGroupAndDesignatedTypes, designatedTypes, unexpectedAfterDesignatedTypes))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndPrecedenceGroup?.raw,
        precedenceGroup.raw,
        unexpectedBetweenPrecedenceGroupAndDesignatedTypes?.raw,
        designatedTypes.raw,
        unexpectedAfterDesignatedTypes?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.operatorPrecedenceAndTypes, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
  }

  public var unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  public var unexpectedAfterDesignatedTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = OperatorPrecedenceAndTypesSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupRelation else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrecedenceGroupRelationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupRelation)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? = nil,
    higherThanOrLowerThan: TokenSyntax,
    _ unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? = nil,
    otherNames: PrecedenceGroupNameListSyntax,
    _ unexpectedAfterOtherNames: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeHigherThanOrLowerThan, higherThanOrLowerThan, unexpectedBetweenHigherThanOrLowerThanAndColon, colon, unexpectedBetweenColonAndOtherNames, otherNames, unexpectedAfterOtherNames))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeHigherThanOrLowerThan?.raw,
        higherThanOrLowerThan.raw,
        unexpectedBetweenHigherThanOrLowerThanAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndOtherNames?.raw,
        otherNames.raw,
        unexpectedAfterOtherNames?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.precedenceGroupRelation, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
  }

  public var unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return PrecedenceGroupRelationSyntax(newData)
  }

  public var unexpectedAfterOtherNames: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PrecedenceGroupRelationSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupNameElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrecedenceGroupNameElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupNameElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.precedenceGroupNameElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrecedenceGroupNameElementSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrecedenceGroupNameElementSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrecedenceGroupNameElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrecedenceGroupNameElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrecedenceGroupNameElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupAssignment else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrecedenceGroupAssignmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupAssignment)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? = nil,
    assignmentKeyword: TokenSyntax = .identifier("assignment"),
    _ unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? = nil,
    flag: TokenSyntax,
    _ unexpectedAfterFlag: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAssignmentKeyword, assignmentKeyword, unexpectedBetweenAssignmentKeywordAndColon, colon, unexpectedBetweenColonAndFlag, flag, unexpectedAfterFlag))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAssignmentKeyword?.raw,
        assignmentKeyword.raw,
        unexpectedBetweenAssignmentKeywordAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndFlag?.raw,
        flag.raw,
        unexpectedAfterFlag?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.precedenceGroupAssignment, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
  }

  public var assignmentKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
  }

  public var unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
  }

  public var unexpectedAfterFlag: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PrecedenceGroupAssignmentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupAssociativity else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrecedenceGroupAssociativitySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupAssociativity)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? = nil,
    associativityKeyword: TokenSyntax = .identifier("associativity"),
    _ unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: TokenSyntax,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAssociativityKeyword, associativityKeyword, unexpectedBetweenAssociativityKeywordAndColon, colon, unexpectedBetweenColonAndValue, value, unexpectedAfterValue))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAssociativityKeyword?.raw,
        associativityKeyword.raw,
        unexpectedBetweenAssociativityKeywordAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndValue?.raw,
        value.raw,
        unexpectedAfterValue?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.precedenceGroupAssociativity, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
  }

  public var associativityKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
  }

  public var unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PrecedenceGroupAssociativitySyntax(newData)
    }
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

// MARK: - AttributeSyntax

/// 
/// An `@` attribute.
/// 
public struct AttributeSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Argument: SyntaxChildChoices {
    case `argumentList`(TupleExprElementListSyntax)
    case `token`(TokenSyntax)
    case `string`(StringLiteralExprSyntax)
    case `availability`(AvailabilitySpecListSyntax)
    case `specializeArguments`(SpecializeAttributeSpecListSyntax)
    case `objCName`(ObjCSelectorSyntax)
    case `implementsArguments`(ImplementsAttributeArgumentsSyntax)
    case `differentiableArguments`(DifferentiableAttributeArgumentsSyntax)
    case `derivativeRegistrationArguments`(DerivativeRegistrationAttributeArgumentsSyntax)
    case `backDeployArguments`(BackDeployAttributeSpecListSyntax)
    case `conventionArguments`(ConventionAttributeArgumentsSyntax)
    case `conventionWitnessMethodArguments`(ConventionWitnessMethodAttributeArgumentsSyntax)
    case `opaqueReturnTypeOfAttributeArguments`(OpaqueReturnTypeOfAttributeArgumentsSyntax)
    case `exposeAttributeArguments`(ExposeAttributeArgumentsSyntax)
    case `originallyDefinedInArguments`(OriginallyDefinedInArgumentsSyntax)
    case `underscorePrivateAttributeArguments`(UnderscorePrivateAttributeArgumentsSyntax)
    case `dynamicReplacementArguments`(DynamicReplacementArgumentsSyntax)
    case `unavailableFromAsyncArguments`(UnavailableFromAsyncArgumentsSyntax)
    case `effectsArguments`(EffectsArgumentsSyntax)
    case `documentationArguments`(DocumentationAttributeArgumentsSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .argumentList(let node): return node._syntaxNode
      case .token(let node): return node._syntaxNode
      case .string(let node): return node._syntaxNode
      case .availability(let node): return node._syntaxNode
      case .specializeArguments(let node): return node._syntaxNode
      case .objCName(let node): return node._syntaxNode
      case .implementsArguments(let node): return node._syntaxNode
      case .differentiableArguments(let node): return node._syntaxNode
      case .derivativeRegistrationArguments(let node): return node._syntaxNode
      case .backDeployArguments(let node): return node._syntaxNode
      case .conventionArguments(let node): return node._syntaxNode
      case .conventionWitnessMethodArguments(let node): return node._syntaxNode
      case .opaqueReturnTypeOfAttributeArguments(let node): return node._syntaxNode
      case .exposeAttributeArguments(let node): return node._syntaxNode
      case .originallyDefinedInArguments(let node): return node._syntaxNode
      case .underscorePrivateAttributeArguments(let node): return node._syntaxNode
      case .dynamicReplacementArguments(let node): return node._syntaxNode
      case .unavailableFromAsyncArguments(let node): return node._syntaxNode
      case .effectsArguments(let node): return node._syntaxNode
      case .documentationArguments(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: TupleExprElementListSyntax) {
      self = .argumentList(node)
    }
    public init(_ node: TokenSyntax) {
      self = .token(node)
    }
    public init(_ node: StringLiteralExprSyntax) {
      self = .string(node)
    }
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
    public init(_ node: BackDeployAttributeSpecListSyntax) {
      self = .backDeployArguments(node)
    }
    public init(_ node: ConventionAttributeArgumentsSyntax) {
      self = .conventionArguments(node)
    }
    public init(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) {
      self = .conventionWitnessMethodArguments(node)
    }
    public init(_ node: OpaqueReturnTypeOfAttributeArgumentsSyntax) {
      self = .opaqueReturnTypeOfAttributeArguments(node)
    }
    public init(_ node: ExposeAttributeArgumentsSyntax) {
      self = .exposeAttributeArguments(node)
    }
    public init(_ node: OriginallyDefinedInArgumentsSyntax) {
      self = .originallyDefinedInArguments(node)
    }
    public init(_ node: UnderscorePrivateAttributeArgumentsSyntax) {
      self = .underscorePrivateAttributeArguments(node)
    }
    public init(_ node: DynamicReplacementArgumentsSyntax) {
      self = .dynamicReplacementArguments(node)
    }
    public init(_ node: UnavailableFromAsyncArgumentsSyntax) {
      self = .unavailableFromAsyncArguments(node)
    }
    public init(_ node: EffectsArgumentsSyntax) {
      self = .effectsArguments(node)
    }
    public init(_ node: DocumentationAttributeArgumentsSyntax) {
      self = .documentationArguments(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(TupleExprElementListSyntax.self) {
        self = .argumentList(node)
        return
      }
      if let node = node.as(TokenSyntax.self) {
        self = .token(node)
        return
      }
      if let node = node.as(StringLiteralExprSyntax.self) {
        self = .string(node)
        return
      }
      if let node = node.as(AvailabilitySpecListSyntax.self) {
        self = .availability(node)
        return
      }
      if let node = node.as(SpecializeAttributeSpecListSyntax.self) {
        self = .specializeArguments(node)
        return
      }
      if let node = node.as(ObjCSelectorSyntax.self) {
        self = .objCName(node)
        return
      }
      if let node = node.as(ImplementsAttributeArgumentsSyntax.self) {
        self = .implementsArguments(node)
        return
      }
      if let node = node.as(DifferentiableAttributeArgumentsSyntax.self) {
        self = .differentiableArguments(node)
        return
      }
      if let node = node.as(DerivativeRegistrationAttributeArgumentsSyntax.self) {
        self = .derivativeRegistrationArguments(node)
        return
      }
      if let node = node.as(BackDeployAttributeSpecListSyntax.self) {
        self = .backDeployArguments(node)
        return
      }
      if let node = node.as(ConventionAttributeArgumentsSyntax.self) {
        self = .conventionArguments(node)
        return
      }
      if let node = node.as(ConventionWitnessMethodAttributeArgumentsSyntax.self) {
        self = .conventionWitnessMethodArguments(node)
        return
      }
      if let node = node.as(OpaqueReturnTypeOfAttributeArgumentsSyntax.self) {
        self = .opaqueReturnTypeOfAttributeArguments(node)
        return
      }
      if let node = node.as(ExposeAttributeArgumentsSyntax.self) {
        self = .exposeAttributeArguments(node)
        return
      }
      if let node = node.as(OriginallyDefinedInArgumentsSyntax.self) {
        self = .originallyDefinedInArguments(node)
        return
      }
      if let node = node.as(UnderscorePrivateAttributeArgumentsSyntax.self) {
        self = .underscorePrivateAttributeArguments(node)
        return
      }
      if let node = node.as(DynamicReplacementArgumentsSyntax.self) {
        self = .dynamicReplacementArguments(node)
        return
      }
      if let node = node.as(UnavailableFromAsyncArgumentsSyntax.self) {
        self = .unavailableFromAsyncArguments(node)
        return
      }
      if let node = node.as(EffectsArgumentsSyntax.self) {
        self = .effectsArguments(node)
        return
      }
      if let node = node.as(DocumentationAttributeArgumentsSyntax.self) {
        self = .documentationArguments(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(TupleExprElementListSyntax.self),
        .node(TokenSyntax.self),
        .node(StringLiteralExprSyntax.self),
        .node(AvailabilitySpecListSyntax.self),
        .node(SpecializeAttributeSpecListSyntax.self),
        .node(ObjCSelectorSyntax.self),
        .node(ImplementsAttributeArgumentsSyntax.self),
        .node(DifferentiableAttributeArgumentsSyntax.self),
        .node(DerivativeRegistrationAttributeArgumentsSyntax.self),
        .node(BackDeployAttributeSpecListSyntax.self),
        .node(ConventionAttributeArgumentsSyntax.self),
        .node(ConventionWitnessMethodAttributeArgumentsSyntax.self),
        .node(OpaqueReturnTypeOfAttributeArgumentsSyntax.self),
        .node(ExposeAttributeArgumentsSyntax.self),
        .node(OriginallyDefinedInArgumentsSyntax.self),
        .node(UnderscorePrivateAttributeArgumentsSyntax.self),
        .node(DynamicReplacementArgumentsSyntax.self),
        .node(UnavailableFromAsyncArgumentsSyntax.self),
        .node(EffectsArgumentsSyntax.self),
        .node(DocumentationAttributeArgumentsSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .attribute else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AttributeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .attribute)
    self._syntaxNode = Syntax(data)
  }

  public init<A: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil,
    atSignToken: TokenSyntax = .atSignToken(),
    _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil,
    attributeName: A,
    _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? = nil,
    argument: Argument? = nil,
    _ unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAtSignToken, atSignToken, unexpectedBetweenAtSignTokenAndAttributeName, attributeName, unexpectedBetweenAttributeNameAndLeftParen, leftParen, unexpectedBetweenLeftParenAndArgument, argument, unexpectedBetweenArgumentAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
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
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.attribute, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  public var unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  /// The name of the attribute.
  public var attributeName: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  public var unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  public var unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = AttributeSyntax(newData)
    }
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
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityEntrySyntax

/// 
/// The availability argument for the _specialize attribute
/// 
public struct AvailabilityEntrySyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityEntry else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityEntry)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? = nil,
    availabilityList: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax = .semicolonToken(),
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndAvailabilityList, availabilityList, unexpectedBetweenAvailabilityListAndSemicolon, semicolon, unexpectedAfterSemicolon))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityEntry, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  public var availabilityList: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return AvailabilitySpecListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return AvailabilityEntrySyntax(newData)
  }

  public var unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  public var semicolon: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
  }

  public var unexpectedAfterSemicolon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = AvailabilityEntrySyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .labeledSpecializeEntry else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `LabeledSpecializeEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .labeledSpecializeEntry)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: TokenSyntax,
    _ unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndValue, value, unexpectedBetweenValueAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.labeledSpecializeEntry, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  /// The value for this argument
  public var value: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = LabeledSpecializeEntrySyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .targetFunctionEntry else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TargetFunctionEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .targetFunctionEntry)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? = nil,
    declname: DeclNameSyntax,
    _ unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndDeclname, declname, unexpectedBetweenDeclnameAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.targetFunctionEntry, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  /// The value for this argument
  public var declname: DeclNameSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return DeclNameSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = TargetFunctionEntrySyntax(newData)
    }
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

// MARK: - DeclNameSyntax

public struct DeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declName else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declName)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? = nil,
    declBaseName: TokenSyntax,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeDeclBaseName, declBaseName, unexpectedBetweenDeclBaseNameAndDeclNameArguments, declNameArguments, unexpectedAfterDeclNameArguments))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeDeclBaseName?.raw,
        declBaseName.raw,
        unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
        declNameArguments?.raw,
        unexpectedAfterDeclNameArguments?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.declName, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DeclNameSyntax(newData)
    }
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DeclNameSyntax(newData)
    }
  }

  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DeclNameSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DeclNameSyntax(newData)
    }
  }

  public var unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DeclNameSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .implementsAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ImplementsAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .implementsAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax = .commaToken(),
    _ unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? = nil,
    declBaseName: TokenSyntax,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeType, type, unexpectedBetweenTypeAndComma, comma, unexpectedBetweenCommaAndDeclBaseName, declBaseName, unexpectedBetweenDeclBaseNameAndDeclNameArguments, declNameArguments, unexpectedAfterDeclNameArguments))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.implementsAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ImplementsAttributeArgumentsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .objCSelectorPiece else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ObjCSelectorPieceSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objCSelectorPiece)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax? = nil,
    _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndColon, colon, unexpectedAfterColon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name?.raw,
        unexpectedBetweenNameAndColon?.raw,
        colon?.raw,
        unexpectedAfterColon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.objCSelectorPiece, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ObjCSelectorPieceSyntax(newData)
    }
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ObjCSelectorPieceSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ObjCSelectorPieceSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ObjCSelectorPieceSyntax(newData)
    }
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ObjCSelectorPieceSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .differentiableAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DifferentiableAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiableAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeDiffKind: UnexpectedNodesSyntax? = nil,
    diffKind: TokenSyntax? = nil,
    _ unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? = nil,
    diffKindComma: TokenSyntax? = nil,
    _ unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamsClauseSyntax? = nil,
    _ unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? = nil,
    diffParamsComma: TokenSyntax? = nil,
    _ unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedAfterWhereClause: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeDiffKind, diffKind, unexpectedBetweenDiffKindAndDiffKindComma, diffKindComma, unexpectedBetweenDiffKindCommaAndDiffParams, diffParams, unexpectedBetweenDiffParamsAndDiffParamsComma, diffParamsComma, unexpectedBetweenDiffParamsCommaAndWhereClause, whereClause, unexpectedAfterWhereClause))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.differentiableAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeDiffKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var diffKind: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return DifferentiabilityParamsClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var whereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericWhereClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = DifferentiableAttributeArgumentsSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(DifferentiabilityParamSyntax.self) {
        self = .parameter(node)
        return
      }
      if let node = node.as(DifferentiabilityParamsSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .differentiabilityParamsClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DifferentiabilityParamsClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParamsClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? = nil,
    wrtLabel: TokenSyntax = .identifier("wrt"),
    _ unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? = nil,
    parameters: Parameters,
    _ unexpectedAfterParameters: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeWrtLabel, wrtLabel, unexpectedBetweenWrtLabelAndColon, colon, unexpectedBetweenColonAndParameters, parameters, unexpectedAfterParameters))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeWrtLabel?.raw,
        wrtLabel.raw,
        unexpectedBetweenWrtLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndParameters?.raw,
        parameters.raw,
        unexpectedAfterParameters?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.differentiabilityParamsClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
  }

  /// The "wrt" label.
  public var wrtLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
  }

  public var parameters: Parameters {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return Parameters(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
  }

  public var unexpectedAfterParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DifferentiabilityParamsClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .differentiabilityParams else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DifferentiabilityParamsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParams)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamListSyntax,
    _ unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndDiffParams, diffParams, unexpectedBetweenDiffParamsAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndDiffParams?.raw,
        diffParams.raw,
        unexpectedBetweenDiffParamsAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.differentiabilityParams, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
  }

  /// The parameters for differentiation.
  public var diffParams: DifferentiabilityParamListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return DifferentiabilityParamListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DifferentiabilityParamsSyntax(newData)
    }
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
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .differentiabilityParam else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DifferentiabilityParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParam)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeParameter: UnexpectedNodesSyntax? = nil,
    parameter: TokenSyntax,
    _ unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeParameter, parameter, unexpectedBetweenParameterAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeParameter?.raw,
        parameter.raw,
        unexpectedBetweenParameterAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.differentiabilityParam, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeParameter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DifferentiabilityParamSyntax(newData)
    }
  }

  public var parameter: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DifferentiabilityParamSyntax(newData)
    }
  }

  public var unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DifferentiabilityParamSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DifferentiabilityParamSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DifferentiabilityParamSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .derivativeRegistrationAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DerivativeRegistrationAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .derivativeRegistrationAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeOfLabel: UnexpectedNodesSyntax? = nil,
    ofLabel: TokenSyntax = .identifier("of"),
    _ unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? = nil,
    originalDeclName: QualifiedDeclNameSyntax,
    _ unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax? = nil,
    _ unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? = nil,
    accessorKind: TokenSyntax? = nil,
    _ unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax? = nil,
    _ unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? = nil,
    diffParams: DifferentiabilityParamsClauseSyntax? = nil,
    _ unexpectedAfterDiffParams: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeOfLabel, ofLabel, unexpectedBetweenOfLabelAndColon, colon, unexpectedBetweenColonAndOriginalDeclName, originalDeclName, unexpectedBetweenOriginalDeclNameAndPeriod, period, unexpectedBetweenPeriodAndAccessorKind, accessorKind, unexpectedBetweenAccessorKindAndComma, comma, unexpectedBetweenCommaAndDiffParams, diffParams, unexpectedAfterDiffParams))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.derivativeRegistrationAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeOfLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  /// The "of" label.
  public var ofLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  /// The referenced original declaration name.
  public var originalDeclName: QualifiedDeclNameSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return QualifiedDeclNameSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  /// The accessor name.
  public var accessorKind: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return DifferentiabilityParamsClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 13, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterDiffParams: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 14, with: raw, arena: arena)
      self = DerivativeRegistrationAttributeArgumentsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .qualifiedDeclName else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `QualifiedDeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .qualifiedDeclName)
    self._syntaxNode = Syntax(data)
  }

  public init<B: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil,
    baseType: B? = nil,
    _ unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax? = nil,
    _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeBaseType, baseType, unexpectedBetweenBaseTypeAndDot, dot, unexpectedBetweenDotAndName, name, unexpectedBetweenNameAndArguments, arguments, unexpectedAfterArguments))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.qualifiedDeclName, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil,
    baseType: MissingTypeSyntax? = nil,
    _ unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax? = nil,
    _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeBaseType,
      baseType: Optional<TypeSyntax>.none,
      unexpectedBetweenBaseTypeAndDot,
      dot: dot,
      unexpectedBetweenDotAndName,
      name: name,
      unexpectedBetweenNameAndArguments,
      arguments: arguments,
      unexpectedAfterArguments,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforeBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
  }

  public var unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
  }

  public var unexpectedBetweenDotAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
  }

  public var unexpectedAfterArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = QualifiedDeclNameSyntax(newData)
    }
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

// MARK: - BackDeployAttributeSpecListSyntax

/// 
/// A collection of arguments for the `@_backDeploy` attribute
/// 
public struct BackDeployAttributeSpecListSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .backDeployAttributeSpecList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `BackDeployAttributeSpecListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .backDeployAttributeSpecList)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? = nil,
    beforeLabel: TokenSyntax = .identifier("before"),
    _ unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? = nil,
    versionList: AvailabilityVersionRestrictionListSyntax,
    _ unexpectedAfterVersionList: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeBeforeLabel, beforeLabel, unexpectedBetweenBeforeLabelAndColon, colon, unexpectedBetweenColonAndVersionList, versionList, unexpectedAfterVersionList))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeBeforeLabel?.raw,
        beforeLabel.raw,
        unexpectedBetweenBeforeLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndVersionList?.raw,
        versionList.raw,
        unexpectedAfterVersionList?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.backDeployAttributeSpecList, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
  }

  /// The "before" label.
  public var beforeLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
  }

  public var unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
  }

  /// 
  /// The list of OS versions in which the declaration became ABI
  /// stable.
  /// 
  public var versionList: AvailabilityVersionRestrictionListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return AvailabilityVersionRestrictionListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
  }

  /// Adds the provided `Availability` to the node's `versionList`
  /// collection.
  /// - param element: The new `Availability` to add to the node's
  ///                  `versionList` collection.
  /// - returns: A copy of the receiver with the provided `Availability`
  ///            appended to its `versionList` collection.
  public func addAvailability(_ element: AvailabilityVersionRestrictionListEntrySyntax) -> BackDeployAttributeSpecListSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilityVersionRestrictionList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  public var unexpectedAfterVersionList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = BackDeployAttributeSpecListSyntax(newData)
    }
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

// MARK: - AvailabilityVersionRestrictionListEntrySyntax

/// 
/// A single platform/version pair in an attribute, e.g. `iOS 10.1`.
/// 
public struct AvailabilityVersionRestrictionListEntrySyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityVersionRestrictionListEntry else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityVersionRestrictionListEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityVersionRestrictionListEntry)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? = nil,
    availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax,
    _ unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAvailabilityVersionRestriction, availabilityVersionRestriction, unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAvailabilityVersionRestriction?.raw,
        availabilityVersionRestriction.raw,
        unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityVersionRestrictionListEntry, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionListEntrySyntax(newData)
    }
  }

  public var availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return AvailabilityVersionRestrictionSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionListEntrySyntax(newData)
    }
  }

  public var unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionListEntrySyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionListEntrySyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionListEntrySyntax(newData)
    }
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

extension AvailabilityVersionRestrictionListEntrySyntax: CustomReflectable {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .opaqueReturnTypeOfAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OpaqueReturnTypeOfAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .opaqueReturnTypeOfAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeMangledName: UnexpectedNodesSyntax? = nil,
    mangledName: StringLiteralExprSyntax,
    _ unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax = .commaToken(),
    _ unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? = nil,
    ordinal: TokenSyntax,
    _ unexpectedAfterOrdinal: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeMangledName, mangledName, unexpectedBetweenMangledNameAndComma, comma, unexpectedBetweenCommaAndOrdinal, ordinal, unexpectedAfterOrdinal))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeMangledName?.raw,
        mangledName.raw,
        unexpectedBetweenMangledNameAndComma?.raw,
        comma.raw,
        unexpectedBetweenCommaAndOrdinal?.raw,
        ordinal.raw,
        unexpectedAfterOrdinal?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.opaqueReturnTypeOfAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeMangledName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  /// The mangled name of a declaration.
  public var mangledName: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  /// The ordinal corresponding to the 'some' keyword that introduced this opaque type.
  public var ordinal: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterOrdinal: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = OpaqueReturnTypeOfAttributeArgumentsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .conventionAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ConventionAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conventionAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? = nil,
    conventionLabel: TokenSyntax,
    _ unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax? = nil,
    _ unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? = nil,
    cTypeLabel: TokenSyntax? = nil,
    _ unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? = nil,
    cTypeString: StringLiteralExprSyntax? = nil,
    _ unexpectedAfterCTypeString: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeConventionLabel, conventionLabel, unexpectedBetweenConventionLabelAndComma, comma, unexpectedBetweenCommaAndCTypeLabel, cTypeLabel, unexpectedBetweenCTypeLabelAndColon, colon, unexpectedBetweenColonAndCTypeString, cTypeString, unexpectedAfterCTypeString))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.conventionAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  /// The convention label.
  public var conventionLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var cTypeLabel: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var cTypeString: StringLiteralExprSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterCTypeString: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = ConventionAttributeArgumentsSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .conventionWitnessMethodAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ConventionWitnessMethodAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conventionWitnessMethodAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? = nil,
    witnessMethodLabel: TokenSyntax,
    _ unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? = nil,
    protocolName: TokenSyntax,
    _ unexpectedAfterProtocolName: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeWitnessMethodLabel, witnessMethodLabel, unexpectedBetweenWitnessMethodLabelAndColon, colon, unexpectedBetweenColonAndProtocolName, protocolName, unexpectedAfterProtocolName))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeWitnessMethodLabel?.raw,
        witnessMethodLabel.raw,
        unexpectedBetweenWitnessMethodLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndProtocolName?.raw,
        protocolName.raw,
        unexpectedAfterProtocolName?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.conventionWitnessMethodAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var witnessMethodLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var protocolName: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterProtocolName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ConventionWitnessMethodAttributeArgumentsSyntax(newData)
    }
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

// MARK: - ExposeAttributeArgumentsSyntax

/// 
/// The arguments for the '@_expose' attribute
/// 
public struct ExposeAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .exposeAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ExposeAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .exposeAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLanguage: UnexpectedNodesSyntax? = nil,
    language: TokenSyntax,
    _ unexpectedBetweenLanguageAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax? = nil,
    _ unexpectedBetweenCommaAndCxxName: UnexpectedNodesSyntax? = nil,
    cxxName: StringLiteralExprSyntax? = nil,
    _ unexpectedAfterCxxName: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLanguage, language, unexpectedBetweenLanguageAndComma, comma, unexpectedBetweenCommaAndCxxName, cxxName, unexpectedAfterCxxName))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLanguage?.raw,
        language.raw,
        unexpectedBetweenLanguageAndComma?.raw,
        comma?.raw,
        unexpectedBetweenCommaAndCxxName?.raw,
        cxxName?.raw,
        unexpectedAfterCxxName?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.exposeAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLanguage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var language: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenLanguageAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndCxxName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var cxxName: StringLiteralExprSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterCxxName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ExposeAttributeArgumentsSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLanguage,
      \Self.language,
      \Self.unexpectedBetweenLanguageAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndCxxName,
      \Self.cxxName,
      \Self.unexpectedAfterCxxName,
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

extension ExposeAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLanguage": unexpectedBeforeLanguage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "language": Syntax(language).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLanguageAndComma": unexpectedBetweenLanguageAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenCommaAndCxxName": unexpectedBetweenCommaAndCxxName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "cxxName": cxxName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterCxxName": unexpectedAfterCxxName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OriginallyDefinedInArgumentsSyntax

/// 
/// The arguments for the '@_originallyDefinedIn' attribute
/// 
public struct OriginallyDefinedInArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .originallyDefinedInArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OriginallyDefinedInArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .originallyDefinedInArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeModuleLabel: UnexpectedNodesSyntax? = nil,
    moduleLabel: TokenSyntax = .identifier("module"),
    _ unexpectedBetweenModuleLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndModuleName: UnexpectedNodesSyntax? = nil,
    moduleName: StringLiteralExprSyntax,
    _ unexpectedBetweenModuleNameAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax = .commaToken(),
    _ unexpectedBetweenCommaAndPlatforms: UnexpectedNodesSyntax? = nil,
    platforms: AvailabilityVersionRestrictionListSyntax,
    _ unexpectedAfterPlatforms: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeModuleLabel, moduleLabel, unexpectedBetweenModuleLabelAndColon, colon, unexpectedBetweenColonAndModuleName, moduleName, unexpectedBetweenModuleNameAndComma, comma, unexpectedBetweenCommaAndPlatforms, platforms, unexpectedAfterPlatforms))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeModuleLabel?.raw,
        moduleLabel.raw,
        unexpectedBetweenModuleLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndModuleName?.raw,
        moduleName.raw,
        unexpectedBetweenModuleNameAndComma?.raw,
        comma.raw,
        unexpectedBetweenCommaAndPlatforms?.raw,
        platforms.raw,
        unexpectedAfterPlatforms?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.originallyDefinedInArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeModuleLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var moduleLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenModuleLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndModuleName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var moduleName: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenModuleNameAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndPlatforms: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public var platforms: AvailabilityVersionRestrictionListSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return AvailabilityVersionRestrictionListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  /// Adds the provided `Platform` to the node's `platforms`
  /// collection.
  /// - param element: The new `Platform` to add to the node's
  ///                  `platforms` collection.
  /// - returns: A copy of the receiver with the provided `Platform`
  ///            appended to its `platforms` collection.
  public func addPlatform(_ element: AvailabilityVersionRestrictionListEntrySyntax) -> OriginallyDefinedInArgumentsSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[9] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilityVersionRestrictionList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 9, with: collection, arena: arena)
    return OriginallyDefinedInArgumentsSyntax(newData)
  }

  public var unexpectedAfterPlatforms: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = OriginallyDefinedInArgumentsSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeModuleLabel,
      \Self.moduleLabel,
      \Self.unexpectedBetweenModuleLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndModuleName,
      \Self.moduleName,
      \Self.unexpectedBetweenModuleNameAndComma,
      \Self.comma,
      \Self.unexpectedBetweenCommaAndPlatforms,
      \Self.platforms,
      \Self.unexpectedAfterPlatforms,
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

extension OriginallyDefinedInArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeModuleLabel": unexpectedBeforeModuleLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "moduleLabel": Syntax(moduleLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenModuleLabelAndColon": unexpectedBetweenModuleLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndModuleName": unexpectedBetweenColonAndModuleName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "moduleName": Syntax(moduleName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenModuleNameAndComma": unexpectedBetweenModuleNameAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCommaAndPlatforms": unexpectedBetweenCommaAndPlatforms.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "platforms": Syntax(platforms).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterPlatforms": unexpectedAfterPlatforms.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnderscorePrivateAttributeArgumentsSyntax

/// 
/// The arguments for the '@_private' attribute
/// 
public struct UnderscorePrivateAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .underscorePrivateAttributeArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `UnderscorePrivateAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .underscorePrivateAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSourceFileLabel: UnexpectedNodesSyntax? = nil,
    sourceFileLabel: TokenSyntax = .identifier("sourceFile"),
    _ unexpectedBetweenSourceFileLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndFilename: UnexpectedNodesSyntax? = nil,
    filename: StringLiteralExprSyntax,
    _ unexpectedAfterFilename: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeSourceFileLabel, sourceFileLabel, unexpectedBetweenSourceFileLabelAndColon, colon, unexpectedBetweenColonAndFilename, filename, unexpectedAfterFilename))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeSourceFileLabel?.raw,
        sourceFileLabel.raw,
        unexpectedBetweenSourceFileLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndFilename?.raw,
        filename.raw,
        unexpectedAfterFilename?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.underscorePrivateAttributeArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeSourceFileLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var sourceFileLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenSourceFileLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndFilename: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var filename: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterFilename: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = UnderscorePrivateAttributeArgumentsSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSourceFileLabel,
      \Self.sourceFileLabel,
      \Self.unexpectedBetweenSourceFileLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndFilename,
      \Self.filename,
      \Self.unexpectedAfterFilename,
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

extension UnderscorePrivateAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSourceFileLabel": unexpectedBeforeSourceFileLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "sourceFileLabel": Syntax(sourceFileLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSourceFileLabelAndColon": unexpectedBetweenSourceFileLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndFilename": unexpectedBetweenColonAndFilename.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "filename": Syntax(filename).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterFilename": unexpectedAfterFilename.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DynamicReplacementArgumentsSyntax

/// 
/// The arguments for the '@_dynamicReplacement' attribute
/// 
public struct DynamicReplacementArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .dynamicReplacementArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DynamicReplacementArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dynamicReplacementArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeForLabel: UnexpectedNodesSyntax? = nil,
    forLabel: TokenSyntax = .identifier("for"),
    _ unexpectedBetweenForLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? = nil,
    declname: DeclNameSyntax,
    _ unexpectedAfterDeclname: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeForLabel, forLabel, unexpectedBetweenForLabelAndColon, colon, unexpectedBetweenColonAndDeclname, declname, unexpectedAfterDeclname))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeForLabel?.raw,
        forLabel.raw,
        unexpectedBetweenForLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndDeclname?.raw,
        declname.raw,
        unexpectedAfterDeclname?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.dynamicReplacementArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeForLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var forLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenForLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var declname: DeclNameSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return DeclNameSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterDeclname: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DynamicReplacementArgumentsSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeForLabel,
      \Self.forLabel,
      \Self.unexpectedBetweenForLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndDeclname,
      \Self.declname,
      \Self.unexpectedAfterDeclname,
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

extension DynamicReplacementArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeForLabel": unexpectedBeforeForLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "forLabel": Syntax(forLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenForLabelAndColon": unexpectedBetweenForLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndDeclname": unexpectedBetweenColonAndDeclname.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declname": Syntax(declname).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterDeclname": unexpectedAfterDeclname.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnavailableFromAsyncArgumentsSyntax

/// 
/// The arguments for the '@_unavailableFromAsync' attribute
/// 
public struct UnavailableFromAsyncArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .unavailableFromAsyncArguments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `UnavailableFromAsyncArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unavailableFromAsyncArguments)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeMessageLabel: UnexpectedNodesSyntax? = nil,
    messageLabel: TokenSyntax = .identifier("message"),
    _ unexpectedBetweenMessageLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndMessage: UnexpectedNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ unexpectedAfterMessage: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeMessageLabel, messageLabel, unexpectedBetweenMessageLabelAndColon, colon, unexpectedBetweenColonAndMessage, message, unexpectedAfterMessage))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeMessageLabel?.raw,
        messageLabel.raw,
        unexpectedBetweenMessageLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndMessage?.raw,
        message.raw,
        unexpectedAfterMessage?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.unavailableFromAsyncArguments, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeMessageLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var messageLabel: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenMessageLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var message: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public var unexpectedAfterMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = UnavailableFromAsyncArgumentsSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeMessageLabel,
      \Self.messageLabel,
      \Self.unexpectedBetweenMessageLabelAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndMessage,
      \Self.message,
      \Self.unexpectedAfterMessage,
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

extension UnavailableFromAsyncArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeMessageLabel": unexpectedBeforeMessageLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "messageLabel": Syntax(messageLabel).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMessageLabelAndColon": unexpectedBetweenMessageLabelAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndMessage": unexpectedBetweenColonAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": Syntax(message).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMessage": unexpectedAfterMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DocumentationAttributeArgumentSyntax

public struct DocumentationAttributeArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  public enum Value: SyntaxChildChoices {
    case `token`(TokenSyntax)
    case `string`(StringLiteralExprSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .token(let node): return node._syntaxNode
      case .string(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: TokenSyntax) {
      self = .token(node)
    }
    public init(_ node: StringLiteralExprSyntax) {
      self = .string(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(TokenSyntax.self) {
        self = .token(node)
        return
      }
      if let node = node.as(StringLiteralExprSyntax.self) {
        self = .string(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(TokenSyntax.self),
        .node(StringLiteralExprSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .documentationAttributeArgument else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DocumentationAttributeArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .documentationAttributeArgument)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: Value,
    _ unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndValue, value, unexpectedBetweenValueAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.documentationAttributeArgument, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var value: Value {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return Value(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = DocumentationAttributeArgumentSyntax(newData)
    }
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

extension DocumentationAttributeArgumentSyntax: CustomReflectable {
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

// MARK: - WhereClauseSyntax

public struct WhereClauseSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .whereClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `WhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .whereClause)
    self._syntaxNode = Syntax(data)
  }

  public init<G: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil,
    whereKeyword: TokenSyntax = .keyword(.where),
    _ unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? = nil,
    guardResult: G,
    _ unexpectedAfterGuardResult: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeWhereKeyword, whereKeyword, unexpectedBetweenWhereKeywordAndGuardResult, guardResult, unexpectedAfterGuardResult))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeWhereKeyword?.raw,
        whereKeyword.raw,
        unexpectedBetweenWhereKeywordAndGuardResult?.raw,
        guardResult.raw,
        unexpectedAfterGuardResult?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.whereClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = WhereClauseSyntax(newData)
    }
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = WhereClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = WhereClauseSyntax(newData)
    }
  }

  public var guardResult: ExprSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = WhereClauseSyntax(newData)
    }
  }

  public var unexpectedAfterGuardResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = WhereClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .yieldList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `YieldListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldList)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil,
    elementList: YieldExprListSyntax,
    _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndElementList, elementList, unexpectedBetweenElementListAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndElementList?.raw,
        elementList.raw,
        unexpectedBetweenElementListAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.yieldList, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
  }

  public var elementList: YieldExprListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return YieldExprListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = YieldListSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return YieldListSyntax(newData)
  }

  public var unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = YieldListSyntax(newData)
    }
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
    case `matchingPattern`(MatchingPatternConditionSyntax)
    case `optionalBinding`(OptionalBindingConditionSyntax)
    case `hasSymbol`(HasSymbolConditionSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .expression(let node): return node._syntaxNode
      case .availability(let node): return node._syntaxNode
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
    public init(_ node: MatchingPatternConditionSyntax) {
      self = .matchingPattern(node)
    }
    public init(_ node: OptionalBindingConditionSyntax) {
      self = .optionalBinding(node)
    }
    public init(_ node: HasSymbolConditionSyntax) {
      self = .hasSymbol(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(ExprSyntax.self) {
        self = .expression(node)
        return
      }
      if let node = node.as(AvailabilityConditionSyntax.self) {
        self = .availability(node)
        return
      }
      if let node = node.as(MatchingPatternConditionSyntax.self) {
        self = .matchingPattern(node)
        return
      }
      if let node = node.as(OptionalBindingConditionSyntax.self) {
        self = .optionalBinding(node)
        return
      }
      if let node = node.as(HasSymbolConditionSyntax.self) {
        self = .hasSymbol(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(ExprSyntax.self),
        .node(AvailabilityConditionSyntax.self),
        .node(MatchingPatternConditionSyntax.self),
        .node(OptionalBindingConditionSyntax.self),
        .node(HasSymbolConditionSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .conditionElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ConditionElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conditionElement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCondition: UnexpectedNodesSyntax? = nil,
    condition: Condition,
    _ unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeCondition, condition, unexpectedBetweenConditionAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeCondition?.raw,
        condition.raw,
        unexpectedBetweenConditionAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.conditionElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeCondition: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ConditionElementSyntax(newData)
    }
  }

  public var condition: Condition {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Condition(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ConditionElementSyntax(newData)
    }
  }

  public var unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ConditionElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ConditionElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ConditionElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityCondition else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityCondition)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAvailabilityKeyword: UnexpectedNodesSyntax? = nil,
    availabilityKeyword: TokenSyntax,
    _ unexpectedBetweenAvailabilityKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil,
    availabilitySpec: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAvailabilityKeyword, availabilityKeyword, unexpectedBetweenAvailabilityKeywordAndLeftParen, leftParen, unexpectedBetweenLeftParenAndAvailabilitySpec, availabilitySpec, unexpectedBetweenAvailabilitySpecAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeAvailabilityKeyword?.raw,
        availabilityKeyword.raw,
        unexpectedBetweenAvailabilityKeywordAndLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndAvailabilitySpec?.raw,
        availabilitySpec.raw,
        unexpectedBetweenAvailabilitySpecAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityCondition, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeAvailabilityKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var availabilityKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenAvailabilityKeywordAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return AvailabilitySpecListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return AvailabilityConditionSyntax(newData)
  }

  public var unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = AvailabilityConditionSyntax(newData)
    }
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAvailabilityKeyword,
      \Self.availabilityKeyword,
      \Self.unexpectedBetweenAvailabilityKeywordAndLeftParen,
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
      "unexpectedBeforeAvailabilityKeyword": unexpectedBeforeAvailabilityKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "availabilityKeyword": Syntax(availabilityKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAvailabilityKeywordAndLeftParen": unexpectedBetweenAvailabilityKeywordAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .matchingPatternCondition else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MatchingPatternConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .matchingPatternCondition)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax = .keyword(.case),
    _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax,
    _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeCaseKeyword, caseKeyword, unexpectedBetweenCaseKeywordAndPattern, pattern, unexpectedBetweenPatternAndTypeAnnotation, typeAnnotation, unexpectedBetweenTypeAnnotationAndInitializer, initializer, unexpectedAfterInitializer))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.matchingPatternCondition, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var initializer: InitializerClauseSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
  }

  public var unexpectedAfterInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = MatchingPatternConditionSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .optionalBindingCondition else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OptionalBindingConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalBindingCondition)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax? = nil,
    _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLetOrVarKeyword, letOrVarKeyword, unexpectedBetweenLetOrVarKeywordAndPattern, pattern, unexpectedBetweenPatternAndTypeAnnotation, typeAnnotation, unexpectedBetweenTypeAnnotationAndInitializer, initializer, unexpectedAfterInitializer))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.optionalBindingCondition, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
  }

  public var unexpectedAfterInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = OptionalBindingConditionSyntax(newData)
    }
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

// MARK: - HasSymbolConditionSyntax

public struct HasSymbolConditionSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .hasSymbolCondition else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `HasSymbolConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .hasSymbolCondition)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? = nil,
    hasSymbolKeyword: TokenSyntax,
    _ unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeHasSymbolKeyword, hasSymbolKeyword, unexpectedBetweenHasSymbolKeywordAndLeftParen, leftParen, unexpectedBetweenLeftParenAndExpression, expression, unexpectedBetweenExpressionAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.hasSymbolCondition, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var hasSymbolKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = HasSymbolConditionSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(SwitchDefaultLabelSyntax.self) {
        self = .default(node)
        return
      }
      if let node = node.as(SwitchCaseLabelSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .switchCase else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SwitchCaseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchCase)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? = nil,
    unknownAttr: AttributeSyntax? = nil,
    _ unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? = nil,
    label: Label,
    _ unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedAfterStatements: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeUnknownAttr, unknownAttr, unexpectedBetweenUnknownAttrAndLabel, label, unexpectedBetweenLabelAndStatements, statements, unexpectedAfterStatements))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeUnknownAttr?.raw,
        unknownAttr?.raw,
        unexpectedBetweenUnknownAttrAndLabel?.raw,
        label.raw,
        unexpectedBetweenLabelAndStatements?.raw,
        statements.raw,
        unexpectedAfterStatements?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.switchCase, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
  }

  public var unknownAttr: AttributeSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
  }

  public var unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
  }

  public var label: Label {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return Label(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[5] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 5, with: collection, arena: arena)
    return SwitchCaseSyntax(newData)
  }

  public var unexpectedAfterStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = SwitchCaseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .switchDefaultLabel else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SwitchDefaultLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchDefaultLabel)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? = nil,
    defaultKeyword: TokenSyntax = .keyword(.default),
    _ unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeDefaultKeyword, defaultKeyword, unexpectedBetweenDefaultKeywordAndColon, colon, unexpectedAfterColon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeDefaultKeyword?.raw,
        defaultKeyword.raw,
        unexpectedBetweenDefaultKeywordAndColon?.raw,
        colon.raw,
        unexpectedAfterColon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.switchDefaultLabel, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = SwitchDefaultLabelSyntax(newData)
    }
  }

  public var defaultKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = SwitchDefaultLabelSyntax(newData)
    }
  }

  public var unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = SwitchDefaultLabelSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = SwitchDefaultLabelSyntax(newData)
    }
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = SwitchDefaultLabelSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .caseItem else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CaseItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .caseItem)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: WhereClauseSyntax? = nil,
    _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePattern, pattern, unexpectedBetweenPatternAndWhereClause, whereClause, unexpectedBetweenWhereClauseAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforePattern?.raw,
        pattern.raw,
        unexpectedBetweenPatternAndWhereClause?.raw,
        whereClause?.raw,
        unexpectedBetweenWhereClauseAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.caseItem, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return WhereClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = CaseItemSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .catchItem else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CatchItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchItem)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: P? = nil,
    _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: WhereClauseSyntax? = nil,
    _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePattern, pattern, unexpectedBetweenPatternAndWhereClause, whereClause, unexpectedBetweenWhereClauseAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforePattern?.raw,
        pattern?.raw,
        unexpectedBetweenPatternAndWhereClause?.raw,
        whereClause?.raw,
        unexpectedBetweenWhereClauseAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.catchItem, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: MissingPatternSyntax? = nil,
    _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil,
    whereClause: WhereClauseSyntax? = nil,
    _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforePattern,
      pattern: Optional<PatternSyntax>.none,
      unexpectedBetweenPatternAndWhereClause,
      whereClause: whereClause,
      unexpectedBetweenWhereClauseAndTrailingComma,
      trailingComma: trailingComma,
      unexpectedAfterTrailingComma,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var pattern: PatternSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return WhereClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = CatchItemSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .switchCaseLabel else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SwitchCaseLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchCaseLabel)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax = .keyword(.case),
    _ unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? = nil,
    caseItems: CaseItemListSyntax,
    _ unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeCaseKeyword, caseKeyword, unexpectedBetweenCaseKeywordAndCaseItems, caseItems, unexpectedBetweenCaseItemsAndColon, colon, unexpectedAfterColon))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeCaseKeyword?.raw,
        caseKeyword.raw,
        unexpectedBetweenCaseKeywordAndCaseItems?.raw,
        caseItems.raw,
        unexpectedBetweenCaseItemsAndColon?.raw,
        colon.raw,
        unexpectedAfterColon?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.switchCaseLabel, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
  }

  public var unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
  }

  public var caseItems: CaseItemListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return CaseItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.caseItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return SwitchCaseLabelSyntax(newData)
  }

  public var unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
  }

  public var unexpectedAfterColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = SwitchCaseLabelSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .catchClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CatchClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? = nil,
    catchKeyword: TokenSyntax = .keyword(.catch),
    _ unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? = nil,
    catchItems: CatchItemListSyntax? = nil,
    _ unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeCatchKeyword, catchKeyword, unexpectedBetweenCatchKeywordAndCatchItems, catchItems, unexpectedBetweenCatchItemsAndBody, body, unexpectedAfterBody))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeCatchKeyword?.raw,
        catchKeyword.raw,
        unexpectedBetweenCatchKeywordAndCatchItems?.raw,
        catchItems?.raw,
        unexpectedBetweenCatchItemsAndBody?.raw,
        body.raw,
        unexpectedAfterBody?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.catchClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
  }

  public var catchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
  }

  public var catchItems: CatchItemListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return CatchItemListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.catchItemList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return CatchClauseSyntax(newData)
  }

  public var unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = CatchClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericWhereClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericWhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericWhereClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil,
    whereKeyword: TokenSyntax = .keyword(.where),
    _ unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? = nil,
    requirementList: GenericRequirementListSyntax,
    _ unexpectedAfterRequirementList: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeWhereKeyword, whereKeyword, unexpectedBetweenWhereKeywordAndRequirementList, requirementList, unexpectedAfterRequirementList))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeWhereKeyword?.raw,
        whereKeyword.raw,
        unexpectedBetweenWhereKeywordAndRequirementList?.raw,
        requirementList.raw,
        unexpectedAfterRequirementList?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericWhereClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericWhereClauseSyntax(newData)
    }
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericWhereClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericWhereClauseSyntax(newData)
    }
  }

  public var requirementList: GenericRequirementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return GenericRequirementListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericWhereClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return GenericWhereClauseSyntax(newData)
  }

  public var unexpectedAfterRequirementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericWhereClauseSyntax(newData)
    }
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
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(SameTypeRequirementSyntax.self) {
        self = .sameTypeRequirement(node)
        return
      }
      if let node = node.as(ConformanceRequirementSyntax.self) {
        self = .conformanceRequirement(node)
        return
      }
      if let node = node.as(LayoutRequirementSyntax.self) {
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericRequirement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericRequirement)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBody: UnexpectedNodesSyntax? = nil,
    body: Body,
    _ unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeBody, body, unexpectedBetweenBodyAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeBody?.raw,
        body.raw,
        unexpectedBetweenBodyAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericRequirement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericRequirementSyntax(newData)
    }
  }

  public var body: Body {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Body(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericRequirementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericRequirementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericRequirementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .sameTypeRequirement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SameTypeRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .sameTypeRequirement)
    self._syntaxNode = Syntax(data)
  }

  public init<L: TypeSyntaxProtocol, R: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: L,
    _ unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? = nil,
    equalityToken: TokenSyntax,
    _ unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: R,
    _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftTypeIdentifier, leftTypeIdentifier, unexpectedBetweenLeftTypeIdentifierAndEqualityToken, equalityToken, unexpectedBetweenEqualityTokenAndRightTypeIdentifier, rightTypeIdentifier, unexpectedAfterRightTypeIdentifier))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftTypeIdentifier?.raw,
        leftTypeIdentifier.raw,
        unexpectedBetweenLeftTypeIdentifierAndEqualityToken?.raw,
        equalityToken.raw,
        unexpectedBetweenEqualityTokenAndRightTypeIdentifier?.raw,
        rightTypeIdentifier.raw,
        unexpectedAfterRightTypeIdentifier?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.sameTypeRequirement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var equalityToken: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
  }

  public var unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = SameTypeRequirementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .layoutRequirement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `LayoutRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .layoutRequirement)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? = nil,
    typeIdentifier: T,
    _ unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? = nil,
    layoutConstraint: TokenSyntax,
    _ unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    _ unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? = nil,
    size: TokenSyntax? = nil,
    _ unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? = nil,
    comma: TokenSyntax? = nil,
    _ unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? = nil,
    alignment: TokenSyntax? = nil,
    _ unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeTypeIdentifier, typeIdentifier, unexpectedBetweenTypeIdentifierAndColon, colon, unexpectedBetweenColonAndLayoutConstraint, layoutConstraint, unexpectedBetweenLayoutConstraintAndLeftParen, leftParen, unexpectedBetweenLeftParenAndSize, size, unexpectedBetweenSizeAndComma, comma, unexpectedBetweenCommaAndAlignment, alignment, unexpectedBetweenAlignmentAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.layoutRequirement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var typeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var layoutConstraint: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var size: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var alignment: TokenSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 13, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 14, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 15, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
  }

  public var unexpectedAfterRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 16, with: raw, arena: arena)
      self = LayoutRequirementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericParameter else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericParameter)
    self._syntaxNode = Syntax(data)
  }

  public init<I: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax? = nil,
    _ unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? = nil,
    inheritedType: I? = nil,
    _ unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeAttributes, attributes, unexpectedBetweenAttributesAndName, name, unexpectedBetweenNameAndEllipsis, ellipsis, unexpectedBetweenEllipsisAndColon, colon, unexpectedBetweenColonAndInheritedType, inheritedType, unexpectedBetweenInheritedTypeAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericParameter, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax? = nil,
    _ unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? = nil,
    inheritedType: MissingTypeSyntax? = nil,
    _ unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAttributes,
      attributes: attributes,
      unexpectedBetweenAttributesAndName,
      name: name,
      unexpectedBetweenNameAndEllipsis,
      ellipsis: ellipsis,
      unexpectedBetweenEllipsisAndColon,
      colon: colon,
      unexpectedBetweenColonAndInheritedType,
      inheritedType: Optional<TypeSyntax>.none,
      unexpectedBetweenInheritedTypeAndTrailingComma,
      trailingComma: trailingComma,
      unexpectedAfterTrailingComma,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return GenericParameterSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var inheritedType: TypeSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = GenericParameterSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .primaryAssociatedType else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrimaryAssociatedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .primaryAssociatedType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeName, name, unexpectedBetweenNameAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeName?.raw,
        name.raw,
        unexpectedBetweenNameAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.primaryAssociatedType, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrimaryAssociatedTypeSyntax(newData)
    }
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrimaryAssociatedTypeSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrimaryAssociatedTypeSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrimaryAssociatedTypeSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrimaryAssociatedTypeSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericParameterClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericParameterClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax = .leftAngleToken(),
    _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? = nil,
    genericParameterList: GenericParameterListSyntax,
    _ unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax = .rightAngleToken(),
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftAngleBracket, leftAngleBracket, unexpectedBetweenLeftAngleBracketAndGenericParameterList, genericParameterList, unexpectedBetweenGenericParameterListAndGenericWhereClause, genericWhereClause, unexpectedBetweenGenericWhereClauseAndRightAngleBracket, rightAngleBracket, unexpectedAfterRightAngleBracket))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericParameterClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var genericParameterList: GenericParameterListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return GenericParameterListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return GenericParameterClauseSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericWhereClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = GenericParameterClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .conformanceRequirement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ConformanceRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conformanceRequirement)
    self._syntaxNode = Syntax(data)
  }

  public init<L: TypeSyntaxProtocol, R: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: L,
    _ unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: R,
    _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftTypeIdentifier, leftTypeIdentifier, unexpectedBetweenLeftTypeIdentifierAndColon, colon, unexpectedBetweenColonAndRightTypeIdentifier, rightTypeIdentifier, unexpectedAfterRightTypeIdentifier))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftTypeIdentifier?.raw,
        leftTypeIdentifier.raw,
        unexpectedBetweenLeftTypeIdentifierAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndRightTypeIdentifier?.raw,
        rightTypeIdentifier.raw,
        unexpectedAfterRightTypeIdentifier?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.conformanceRequirement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
  }

  public var unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = ConformanceRequirementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .primaryAssociatedTypeClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrimaryAssociatedTypeClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .primaryAssociatedTypeClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax = .leftAngleToken(),
    _ unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax,
    _ unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax = .rightAngleToken(),
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftAngleBracket, leftAngleBracket, unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList, primaryAssociatedTypeList, unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket, rightAngleBracket, unexpectedAfterRightAngleBracket))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftAngleBracket?.raw,
        leftAngleBracket.raw,
        unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw,
        primaryAssociatedTypeList.raw,
        unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw,
        rightAngleBracket.raw,
        unexpectedAfterRightAngleBracket?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.primaryAssociatedTypeClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
  }

  public var primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return PrimaryAssociatedTypeListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = PrimaryAssociatedTypeClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .compositionTypeElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `CompositionTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .compositionTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? = nil,
    ampersand: TokenSyntax? = nil,
    _ unexpectedAfterAmpersand: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeType, type, unexpectedBetweenTypeAndAmpersand, ampersand, unexpectedAfterAmpersand))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeType?.raw,
        type.raw,
        unexpectedBetweenTypeAndAmpersand?.raw,
        ampersand?.raw,
        unexpectedAfterAmpersand?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.compositionTypeElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = CompositionTypeElementSyntax(newData)
    }
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = CompositionTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = CompositionTypeElementSyntax(newData)
    }
  }

  public var ampersand: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = CompositionTypeElementSyntax(newData)
    }
  }

  public var unexpectedAfterAmpersand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = CompositionTypeElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tupleTypeElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TupleTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeInOut: UnexpectedNodesSyntax? = nil,
    inOut: TokenSyntax? = nil,
    _ unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax? = nil,
    _ unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? = nil,
    secondName: TokenSyntax? = nil,
    _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax? = nil,
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax? = nil,
    _ unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeInOut, inOut, unexpectedBetweenInOutAndName, name, unexpectedBetweenNameAndSecondName, secondName, unexpectedBetweenSecondNameAndColon, colon, unexpectedBetweenColonAndType, type, unexpectedBetweenTypeAndEllipsis, ellipsis, unexpectedBetweenEllipsisAndInitializer, initializer, unexpectedBetweenInitializerAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.tupleTypeElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeInOut: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var inOut: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 9, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 10, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 11, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 12, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 13, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 14, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 15, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 16, with: raw, arena: arena)
      self = TupleTypeElementSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericArgument else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericArgument)
    self._syntaxNode = Syntax(data)
  }

  public init<A: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeArgumentType: UnexpectedNodesSyntax? = nil,
    argumentType: A,
    _ unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeArgumentType, argumentType, unexpectedBetweenArgumentTypeAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeArgumentType?.raw,
        argumentType.raw,
        unexpectedBetweenArgumentTypeAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericArgument, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeArgumentType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericArgumentSyntax(newData)
    }
  }

  public var argumentType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericArgumentSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericArgumentSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericArgumentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericArgumentClause else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `GenericArgumentClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericArgumentClause)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax = .leftAngleToken(),
    _ unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: GenericArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax = .rightAngleToken(),
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftAngleBracket, leftAngleBracket, unexpectedBetweenLeftAngleBracketAndArguments, arguments, unexpectedBetweenArgumentsAndRightAngleBracket, rightAngleBracket, unexpectedAfterRightAngleBracket))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftAngleBracket?.raw,
        leftAngleBracket.raw,
        unexpectedBetweenLeftAngleBracketAndArguments?.raw,
        arguments.raw,
        unexpectedBetweenArgumentsAndRightAngleBracket?.raw,
        rightAngleBracket.raw,
        unexpectedAfterRightAngleBracket?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.genericArgumentClause, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
  }

  public var unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
  }

  public var arguments: GenericArgumentListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return GenericArgumentListSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return GenericArgumentClauseSyntax(newData)
  }

  public var unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
  }

  public var unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = GenericArgumentClauseSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .typeAnnotation else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TypeAnnotationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeAnnotation)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedAfterType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeColon, colon, unexpectedBetweenColonAndType, type, unexpectedAfterType))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndType?.raw,
        type.raw,
        unexpectedAfterType?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.typeAnnotation, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TypeAnnotationSyntax(newData)
    }
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TypeAnnotationSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TypeAnnotationSyntax(newData)
    }
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TypeAnnotationSyntax(newData)
    }
  }

  public var unexpectedAfterType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TypeAnnotationSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tuplePatternElement else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TuplePatternElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePatternElement)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil,
    labelName: TokenSyntax? = nil,
    _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    _ unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabelName, labelName, unexpectedBetweenLabelNameAndLabelColon, labelColon, unexpectedBetweenLabelColonAndPattern, pattern, unexpectedBetweenPatternAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
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
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.tuplePatternElement, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabelName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 7, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 8, with: raw, arena: arena)
      self = TuplePatternElementSyntax(newData)
    }
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
    case `token`(TokenSyntax)
    case `availabilityVersionRestriction`(AvailabilityVersionRestrictionSyntax)
    case `availabilityLabeledArgument`(AvailabilityLabeledArgumentSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .token(let node): return node._syntaxNode
      case .availabilityVersionRestriction(let node): return node._syntaxNode
      case .availabilityLabeledArgument(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: TokenSyntax) {
      self = .token(node)
    }
    public init(_ node: AvailabilityVersionRestrictionSyntax) {
      self = .availabilityVersionRestriction(node)
    }
    public init(_ node: AvailabilityLabeledArgumentSyntax) {
      self = .availabilityLabeledArgument(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(TokenSyntax.self) {
        self = .token(node)
        return
      }
      if let node = node.as(AvailabilityVersionRestrictionSyntax.self) {
        self = .availabilityVersionRestriction(node)
        return
      }
      if let node = node.as(AvailabilityLabeledArgumentSyntax.self) {
        self = .availabilityLabeledArgument(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(TokenSyntax.self),
        .node(AvailabilityVersionRestrictionSyntax.self),
        .node(AvailabilityLabeledArgumentSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityArgument else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityArgument)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeEntry: UnexpectedNodesSyntax? = nil,
    entry: Entry,
    _ unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeEntry, entry, unexpectedBetweenEntryAndTrailingComma, trailingComma, unexpectedAfterTrailingComma))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeEntry?.raw,
        entry.raw,
        unexpectedBetweenEntryAndTrailingComma?.raw,
        trailingComma?.raw,
        unexpectedAfterTrailingComma?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityArgument, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeEntry: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityArgumentSyntax(newData)
    }
  }

  /// The actual argument
  public var entry: Entry {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return Entry(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityArgumentSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityArgumentSyntax(newData)
    }
  }

  public var unexpectedAfterTrailingComma: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityArgumentSyntax(newData)
    }
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
    case `string`(StringLiteralExprSyntax)
    case `version`(VersionTupleSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .string(let node): return node._syntaxNode
      case .version(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: StringLiteralExprSyntax) {
      self = .string(node)
    }
    public init(_ node: VersionTupleSyntax) {
      self = .version(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(StringLiteralExprSyntax.self) {
        self = .string(node)
        return
      }
      if let node = node.as(VersionTupleSyntax.self) {
        self = .version(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(StringLiteralExprSyntax.self),
        .node(VersionTupleSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityLabeledArgument else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityLabeledArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityLabeledArgument)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax,
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil,
    value: Value,
    _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLabel, label, unexpectedBetweenLabelAndColon, colon, unexpectedBetweenColonAndValue, value, unexpectedAfterValue))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLabel?.raw,
        label.raw,
        unexpectedBetweenLabelAndColon?.raw,
        colon.raw,
        unexpectedBetweenColonAndValue?.raw,
        value.raw,
        unexpectedAfterValue?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityLabeledArgument, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLabel: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  /// The colon separating label and value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  public var unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  /// The value of this labeled argument
  public var value: Value {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return Value(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
  }

  public var unexpectedAfterValue: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = AvailabilityLabeledArgumentSyntax(newData)
    }
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

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilityVersionRestriction else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AvailabilityVersionRestrictionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityVersionRestriction)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePlatform: UnexpectedNodesSyntax? = nil,
    platform: TokenSyntax,
    _ unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? = nil,
    version: VersionTupleSyntax? = nil,
    _ unexpectedAfterVersion: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforePlatform, platform, unexpectedBetweenPlatformAndVersion, version, unexpectedAfterVersion))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforePlatform?.raw,
        platform.raw,
        unexpectedBetweenPlatformAndVersion?.raw,
        version?.raw,
        unexpectedAfterVersion?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.availabilityVersionRestriction, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePlatform: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionSyntax(newData)
    }
  }

  public var unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionSyntax(newData)
    }
  }

  public var version: VersionTupleSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return VersionTupleSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionSyntax(newData)
    }
  }

  public var unexpectedAfterVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = AvailabilityVersionRestrictionSyntax(newData)
    }
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
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .versionTuple else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `VersionTupleSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .versionTuple)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? = nil,
    majorMinor: TokenSyntax,
    _ unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? = nil,
    patchPeriod: TokenSyntax? = nil,
    _ unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? = nil,
    patchVersion: TokenSyntax? = nil,
    _ unexpectedAfterPatchVersion: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeMajorMinor, majorMinor, unexpectedBetweenMajorMinorAndPatchPeriod, patchPeriod, unexpectedBetweenPatchPeriodAndPatchVersion, patchVersion, unexpectedAfterPatchVersion))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeMajorMinor?.raw,
        majorMinor.raw,
        unexpectedBetweenMajorMinorAndPatchPeriod?.raw,
        patchPeriod?.raw,
        unexpectedBetweenPatchPeriodAndPatchVersion?.raw,
        patchVersion?.raw,
        unexpectedAfterPatchVersion?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.versionTuple, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 0, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
  }

  /// 
  /// In case the version consists only of the major version, an
  /// integer literal that specifies the major version. In case
  /// the version consists of major and minor version number, a
  /// floating literal in which the decimal part is interpreted
  /// as the minor version.
  /// 
  public var majorMinor: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value.raw
      let newData = data.replacingChild(at: 1, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
  }

  public var unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 2, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 3, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
  }

  public var unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 4, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
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
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 5, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
  }

  public var unexpectedAfterPatchVersion: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      let arena = SyntaxArena()
      let raw = value?.raw
      let newData = data.replacingChild(at: 6, with: raw, arena: arena)
      self = VersionTupleSyntax(newData)
    }
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

