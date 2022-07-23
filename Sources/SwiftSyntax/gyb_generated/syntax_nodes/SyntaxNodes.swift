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
public struct CodeBlockItemSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case item
    case semicolon
    case errorTokens
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCodeBlockItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CodeBlockItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CodeBlockItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CodeBlockItemSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The underlying node inside the code block.
  public var item: Syntax {
    get {
      let childData = data.child(at: Cursor.item.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withItem(value)
    }
  }
  public func withItem(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.item.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// If present, the trailing semicolon at the end of the item.
  /// 
  public var semicolon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.semicolon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withSemicolon(value)
    }
  }
  public func withSemicolon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.semicolon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var errorTokens: Syntax? {
    get {
      let childData = data.child(at: Cursor.errorTokens.rawValue)
      return childData.map { Syntax(data: $0) }
    }
    set(value) {
      self = withErrorTokens(value)
    }
  }
  public func withErrorTokens(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.errorTokens.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CodeBlockItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "item": Syntax(item).asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "errorTokens": errorTokens.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CodeBlockSyntax

public struct CodeBlockSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftBrace
    case statements
    case rightBrace
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCodeBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CodeBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CodeBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CodeBlockSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftBrace(value)
    }
  }
  public func withLeftBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements.rawValue)
      return CodeBlockItemListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.statements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .codeBlockItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.statements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.statements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightBrace(value)
    }
  }
  public func withRightBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CodeBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameArgumentSyntax

public struct DeclNameArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case colon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclNameArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclNameArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclNameArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclNameArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclNameArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameArgumentsSyntax

public struct DeclNameArgumentsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case arguments
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclNameArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclNameArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclNameArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclNameArgumentsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var arguments: DeclNameArgumentListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return DeclNameArgumentListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.arguments.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .declNameArgumentList)
    }
    let newRaw = raw.replacingChild(at: Cursor.arguments.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArguments(_ newChild: DeclNameArgumentListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawDeclNameArgumentListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.arguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclNameArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleExprElementSyntax

public struct TupleExprElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleExprElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleExprElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TupleExprElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TupleExprElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TupleExprElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayElementSyntax

public struct ArrayElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawArrayElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ArrayElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ArrayElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ArrayElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ArrayElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryElementSyntax

public struct DictionaryElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case keyExpression
    case colon
    case valueExpression
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDictionaryElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DictionaryElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DictionaryElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DictionaryElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var keyExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.keyExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withKeyExpression(value)
    }
  }
  public func withKeyExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.keyExpression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var valueExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.valueExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withValueExpression(value)
    }
  }
  public func withValueExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.valueExpression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DictionaryElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "keyExpression": Syntax(keyExpression).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "valueExpression": Syntax(valueExpression).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureItemSyntax

public struct ClosureCaptureItemSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case specifier
    case name
    case assignToken
    case expression
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureCaptureItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureCaptureItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClosureCaptureItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClosureCaptureItemSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var specifier: TokenListSyntax? {
    get {
      let childData = data.child(at: Cursor.specifier.rawValue)
      return childData.map { TokenListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.specifier.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tokenList)
    }
    let newRaw = raw.replacingChild(at: Cursor.specifier.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withSpecifier(_ newChild: TokenListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.specifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var assignToken: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.assignToken.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAssignToken(value)
    }
  }
  public func withAssignToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.assignToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ClosureCaptureItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignToken": assignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureSignatureSyntax

public struct ClosureCaptureSignatureSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftSquare
    case items
    case rightSquare
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureCaptureSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureCaptureSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClosureCaptureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClosureCaptureSignatureSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftSquare(value)
    }
  }
  public func withLeftSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var items: ClosureCaptureItemListSyntax? {
    get {
      let childData = data.child(at: Cursor.items.rawValue)
      return childData.map { ClosureCaptureItemListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.items.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .closureCaptureItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.items.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withItems(_ newChild: ClosureCaptureItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.items.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightSquare(value)
    }
  }
  public func withRightSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ClosureCaptureSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self) as Any,
      "items": items.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureParamSyntax

public struct ClosureParamSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureParamSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureParamSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClosureParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClosureParamSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ClosureParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureSignatureSyntax

public struct ClosureSignatureSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case attributes
    case capture
    case input
    case asyncKeyword
    case throwsTok
    case output
    case inTok
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClosureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClosureSignatureSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes.rawValue)
      return childData.map { AttributeListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.attributes.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .attributeList)
    }
    let newRaw = raw.replacingChild(at: Cursor.attributes.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAttributes(_ newChild: AttributeListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.attributes.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var capture: ClosureCaptureSignatureSyntax? {
    get {
      let childData = data.child(at: Cursor.capture.rawValue)
      return childData.map { ClosureCaptureSignatureSyntax(data: $0) }
    }
    set(value) {
      self = withCapture(value)
    }
  }
  public func withCapture(_ newChild: ClosureCaptureSignatureSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.capture.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var input: Syntax? {
    get {
      let childData = data.child(at: Cursor.input.rawValue)
      return childData.map { Syntax(data: $0) }
    }
    set(value) {
      self = withInput(value)
    }
  }
  public func withInput(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.input.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var asyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.asyncKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAsyncKeyword(value)
    }
  }
  public func withAsyncKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.asyncKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var throwsTok: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsTok.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withThrowsTok(value)
    }
  }
  public func withThrowsTok(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.throwsTok.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.output.rawValue)
      return childData.map { ReturnClauseSyntax(data: $0) }
    }
    set(value) {
      self = withOutput(value)
    }
  }
  public func withOutput(_ newChild: ReturnClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.output.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var inTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.inTok.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withInTok(value)
    }
  }
  public func withInTok(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .inKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.inTok.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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
      "inTok": Syntax(inTok).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MultipleTrailingClosureElementSyntax

public struct MultipleTrailingClosureElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case closure
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMultipleTrailingClosureElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MultipleTrailingClosureElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MultipleTrailingClosureElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MultipleTrailingClosureElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var closure: ClosureExprSyntax {
    get {
      let childData = data.child(at: Cursor.closure.rawValue)
      return ClosureExprSyntax(data: childData!)
    }
    set(value) {
      self = withClosure(value)
    }
  }
  public func withClosure(_ newChild: ClosureExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawClosureExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.closure.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MultipleTrailingClosureElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "closure": Syntax(closure).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - StringSegmentSyntax

public struct StringSegmentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case content
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawStringSegmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `StringSegmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `StringSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `StringSegmentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var content: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.content.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withContent(value)
    }
  }
  public func withContent(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringSegment).raw

    let newRaw = raw.replacingChild(
      at: Cursor.content.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension StringSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "content": Syntax(content).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionSegmentSyntax

public struct ExpressionSegmentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case backslash
    case delimiter
    case leftParen
    case expressions
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawExpressionSegmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ExpressionSegmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ExpressionSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ExpressionSegmentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.backslash.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withBackslash(value)
    }
  }
  public func withBackslash(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .backslash).raw

    let newRaw = raw.replacingChild(
      at: Cursor.backslash.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var delimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.delimiter.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDelimiter(value)
    }
  }
  public func withDelimiter(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.delimiter.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expressions: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.expressions.rawValue)
      return TupleExprElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.expressions.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.expressions.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withExpressions(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleExprElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expressions.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringInterpolationAnchor).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ExpressionSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self) as Any,
      "delimiter": delimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "expressions": Syntax(expressions).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjcNamePieceSyntax

public struct ObjcNamePieceSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case dot
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjcNamePieceSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjcNamePieceSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ObjcNamePieceSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ObjcNamePieceSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.dot.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDot(value)
    }
  }
  public func withDot(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.dot.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ObjcNamePieceSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInitializerClauseSyntax

public struct TypeInitializerClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case equal
    case value
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTypeInitializerClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TypeInitializerClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TypeInitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TypeInitializerClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.equal.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withEqual(value)
    }
  }
  public func withEqual(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw

    let newRaw = raw.replacingChild(
      at: Cursor.equal.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var value: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.value.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }
  public func withValue(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.value.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TypeInitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ParameterClauseSyntax

public struct ParameterClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case parameterList
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawParameterClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ParameterClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ParameterClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var parameterList: FunctionParameterListSyntax {
    get {
      let childData = data.child(at: Cursor.parameterList.rawValue)
      return FunctionParameterListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.parameterList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .functionParameterList)
    }
    let newRaw = raw.replacingChild(at: Cursor.parameterList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withParameterList(_ newChild: FunctionParameterListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawFunctionParameterListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.parameterList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "parameterList": Syntax(parameterList).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ReturnClauseSyntax

public struct ReturnClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case arrow
    case returnType
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawReturnClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ReturnClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ReturnClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ReturnClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var arrow: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.arrow.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withArrow(value)
    }
  }
  public func withArrow(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .arrow).raw

    let newRaw = raw.replacingChild(
      at: Cursor.arrow.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var returnType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.returnType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withReturnType(value)
    }
  }
  public func withReturnType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.returnType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ReturnClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self) as Any,
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionSignatureSyntax

public struct FunctionSignatureSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case input
    case asyncOrReasyncKeyword
    case throwsOrRethrowsKeyword
    case output
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FunctionSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FunctionSignatureSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var input: ParameterClauseSyntax {
    get {
      let childData = data.child(at: Cursor.input.rawValue)
      return ParameterClauseSyntax(data: childData!)
    }
    set(value) {
      self = withInput(value)
    }
  }
  public func withInput(_ newChild: ParameterClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawParameterClauseSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.input.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var asyncOrReasyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.asyncOrReasyncKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAsyncOrReasyncKeyword(value)
    }
  }
  public func withAsyncOrReasyncKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.asyncOrReasyncKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsOrRethrowsKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withThrowsOrRethrowsKeyword(value)
    }
  }
  public func withThrowsOrRethrowsKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.throwsOrRethrowsKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var output: ReturnClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.output.rawValue)
      return childData.map { ReturnClauseSyntax(data: $0) }
    }
    set(value) {
      self = withOutput(value)
    }
  }
  public func withOutput(_ newChild: ReturnClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.output.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension FunctionSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "input": Syntax(input).asProtocol(SyntaxProtocol.self) as Any,
      "asyncOrReasyncKeyword": asyncOrReasyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "output": output.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfConfigClauseSyntax

public struct IfConfigClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundKeyword
    case condition
    case elements
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIfConfigClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IfConfigClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IfConfigClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IfConfigClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundKeyword(value)
    }
  }
  public func withPoundKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundIfKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var condition: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.condition.rawValue)
      return childData.map { ExprSyntax(data: $0) }
    }
    set(value) {
      self = withCondition(value)
    }
  }
  public func withCondition(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.condition.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elements: Syntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withElements(value)
    }
  }
  public func withElements(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IfConfigClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundKeyword": Syntax(poundKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "condition": condition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundSourceLocationArgsSyntax

public struct PoundSourceLocationArgsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case fileArgLabel
    case fileArgColon
    case fileName
    case comma
    case lineArgLabel
    case lineArgColon
    case lineNumber
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundSourceLocationArgsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundSourceLocationArgsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundSourceLocationArgsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundSourceLocationArgsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var fileArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fileArgLabel.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFileArgLabel(value)
    }
  }
  public func withFileArgLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.fileArgLabel.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var fileArgColon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fileArgColon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFileArgColon(value)
    }
  }
  public func withFileArgColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.fileArgColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var fileName: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fileName.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFileName(value)
    }
  }
  public func withFileName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringLiteral).raw

    let newRaw = raw.replacingChild(
      at: Cursor.fileName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.comma.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withComma(value)
    }
  }
  public func withComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .comma).raw

    let newRaw = raw.replacingChild(
      at: Cursor.comma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var lineArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.lineArgLabel.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLineArgLabel(value)
    }
  }
  public func withLineArgLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.lineArgLabel.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var lineArgColon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.lineArgColon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLineArgColon(value)
    }
  }
  public func withLineArgColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.lineArgColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var lineNumber: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.lineNumber.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLineNumber(value)
    }
  }
  public func withLineNumber(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .integerLiteral).raw

    let newRaw = raw.replacingChild(
      at: Cursor.lineNumber.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundSourceLocationArgsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "fileArgLabel": Syntax(fileArgLabel).asProtocol(SyntaxProtocol.self) as Any,
      "fileArgColon": Syntax(fileArgColon).asProtocol(SyntaxProtocol.self) as Any,
      "fileName": Syntax(fileName).asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self) as Any,
      "lineArgLabel": Syntax(lineArgLabel).asProtocol(SyntaxProtocol.self) as Any,
      "lineArgColon": Syntax(lineArgColon).asProtocol(SyntaxProtocol.self) as Any,
      "lineNumber": Syntax(lineNumber).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclModifierDetailSyntax

public struct DeclModifierDetailSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case detail
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclModifierDetailSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclModifierDetailSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclModifierDetailSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclModifierDetailSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var detail: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.detail.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDetail(value)
    }
  }
  public func withDetail(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.detail.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclModifierDetailSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "detail": Syntax(detail).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclModifierSyntax

public struct DeclModifierSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case detail
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclModifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclModifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclModifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclModifierSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var detail: DeclModifierDetailSyntax? {
    get {
      let childData = data.child(at: Cursor.detail.rawValue)
      return childData.map { DeclModifierDetailSyntax(data: $0) }
    }
    set(value) {
      self = withDetail(value)
    }
  }
  public func withDetail(_ newChild: DeclModifierDetailSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.detail.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "detail": detail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InheritedTypeSyntax

public struct InheritedTypeSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case typeName
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawInheritedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `InheritedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `InheritedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `InheritedTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withTypeName(value)
    }
  }
  public func withTypeName(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension InheritedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInheritanceClauseSyntax

public struct TypeInheritanceClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case colon
    case inheritedTypeCollection
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTypeInheritanceClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TypeInheritanceClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TypeInheritanceClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TypeInheritanceClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var inheritedTypeCollection: InheritedTypeListSyntax {
    get {
      let childData = data.child(at: Cursor.inheritedTypeCollection.rawValue)
      return InheritedTypeListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.inheritedTypeCollection.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .inheritedTypeList)
    }
    let newRaw = raw.replacingChild(at: Cursor.inheritedTypeCollection.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withInheritedTypeCollection(_ newChild: InheritedTypeListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawInheritedTypeListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.inheritedTypeCollection.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TypeInheritanceClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "inheritedTypeCollection": Syntax(inheritedTypeCollection).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberDeclBlockSyntax

public struct MemberDeclBlockSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftBrace
    case members
    case rightBrace
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMemberDeclBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MemberDeclBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MemberDeclBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MemberDeclBlockSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftBrace(value)
    }
  }
  public func withLeftBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var members: MemberDeclListSyntax {
    get {
      let childData = data.child(at: Cursor.members.rawValue)
      return MemberDeclListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.members.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .memberDeclList)
    }
    let newRaw = raw.replacingChild(at: Cursor.members.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withMembers(_ newChild: MemberDeclListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawMemberDeclListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.members.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightBrace(value)
    }
  }
  public func withRightBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MemberDeclBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberDeclListItemSyntax

/// 
/// A member declaration of a type consisting of a declaration and an
/// optional semicolon;
/// 
public struct MemberDeclListItemSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case decl
    case semicolon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMemberDeclListItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MemberDeclListItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MemberDeclListItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MemberDeclListItemSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The declaration of the type member.
  public var decl: DeclSyntax {
    get {
      let childData = data.child(at: Cursor.decl.rawValue)
      return DeclSyntax(data: childData!)
    }
    set(value) {
      self = withDecl(value)
    }
  }
  public func withDecl(_ newChild: DeclSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawDeclSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.decl.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// An optional trailing semicolon.
  public var semicolon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.semicolon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withSemicolon(value)
    }
  }
  public func withSemicolon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.semicolon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MemberDeclListItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "decl": Syntax(decl).asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SourceFileSyntax

public struct SourceFileSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case statements
    case eofToken
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSourceFileSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SourceFileSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SourceFileSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SourceFileSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements.rawValue)
      return CodeBlockItemListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.statements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .codeBlockItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.statements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.statements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var eofToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.eofToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withEOFToken(value)
    }
  }
  public func withEOFToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.eofToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SourceFileSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self) as Any,
      "eofToken": Syntax(eofToken).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InitializerClauseSyntax

public struct InitializerClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case equal
    case value
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawInitializerClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `InitializerClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `InitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `InitializerClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.equal.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withEqual(value)
    }
  }
  public func withEqual(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw

    let newRaw = raw.replacingChild(
      at: Cursor.equal.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var value: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.value.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }
  public func withValue(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.value.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension InitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionParameterSyntax

public struct FunctionParameterSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
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

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FunctionParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FunctionParameterSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes.rawValue)
      return childData.map { AttributeListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.attributes.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .attributeList)
    }
    let newRaw = raw.replacingChild(at: Cursor.attributes.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAttributes(_ newChild: AttributeListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.attributes.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var firstName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.firstName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withFirstName(value)
    }
  }
  public func withFirstName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.firstName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.secondName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withSecondName(value)
    }
  }
  public func withSecondName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.secondName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return childData.map { TypeSyntax(data: $0) }
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.ellipsis.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withEllipsis(value)
    }
  }
  public func withEllipsis(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.ellipsis.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var defaultArgument: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.defaultArgument.rawValue)
      return childData.map { InitializerClauseSyntax(data: $0) }
    }
    set(value) {
      self = withDefaultArgument(value)
    }
  }
  public func withDefaultArgument(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.defaultArgument.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

public struct AccessLevelModifierSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case modifier
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessLevelModifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessLevelModifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AccessLevelModifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AccessLevelModifierSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var modifier: DeclModifierDetailSyntax? {
    get {
      let childData = data.child(at: Cursor.modifier.rawValue)
      return childData.map { DeclModifierDetailSyntax(data: $0) }
    }
    set(value) {
      self = withModifier(value)
    }
  }
  public func withModifier(_ newChild: DeclModifierDetailSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.modifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AccessLevelModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "modifier": modifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessPathComponentSyntax

public struct AccessPathComponentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case trailingDot
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessPathComponentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessPathComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AccessPathComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AccessPathComponentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingDot: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingDot.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingDot(value)
    }
  }
  public func withTrailingDot(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingDot.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AccessPathComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "trailingDot": trailingDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorParameterSyntax

public struct AccessorParameterSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case name
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessorParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessorParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AccessorParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AccessorParameterSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AccessorParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorBlockSyntax

public struct AccessorBlockSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftBrace
    case accessors
    case rightBrace
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessorBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessorBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AccessorBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AccessorBlockSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftBrace(value)
    }
  }
  public func withLeftBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var accessors: AccessorListSyntax {
    get {
      let childData = data.child(at: Cursor.accessors.rawValue)
      return AccessorListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.accessors.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .accessorList)
    }
    let newRaw = raw.replacingChild(at: Cursor.accessors.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAccessors(_ newChild: AccessorListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawAccessorListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.accessors.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightBrace(value)
    }
  }
  public func withRightBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AccessorBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self) as Any,
      "accessors": Syntax(accessors).asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PatternBindingSyntax

public struct PatternBindingSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case pattern
    case typeAnnotation
    case initializer
    case accessor
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPatternBindingSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PatternBindingSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PatternBindingSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PatternBindingSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: Cursor.typeAnnotation.rawValue)
      return childData.map { TypeAnnotationSyntax(data: $0) }
    }
    set(value) {
      self = withTypeAnnotation(value)
    }
  }
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeAnnotation.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.initializer.rawValue)
      return childData.map { InitializerClauseSyntax(data: $0) }
    }
    set(value) {
      self = withInitializer(value)
    }
  }
  public func withInitializer(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.initializer.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var accessor: Syntax? {
    get {
      let childData = data.child(at: Cursor.accessor.rawValue)
      return childData.map { Syntax(data: $0) }
    }
    set(value) {
      self = withAccessor(value)
    }
  }
  public func withAccessor(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.accessor.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PatternBindingSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
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
public struct EnumCaseElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
    case associatedValue
    case rawValue
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawEnumCaseElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `EnumCaseElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `EnumCaseElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `EnumCaseElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The name of this case.
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }
  public func withIdentifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The set of associated values of the case.
  public var associatedValue: ParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.associatedValue.rawValue)
      return childData.map { ParameterClauseSyntax(data: $0) }
    }
    set(value) {
      self = withAssociatedValue(value)
    }
  }
  public func withAssociatedValue(_ newChild: ParameterClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.associatedValue.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The raw value of this enum element, if present.
  /// 
  public var rawValue: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.rawValue.rawValue)
      return childData.map { InitializerClauseSyntax(data: $0) }
    }
    set(value) {
      self = withRawValue(value)
    }
  }
  public func withRawValue(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.rawValue.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The trailing comma of this element, if the case has
  /// multiple elements.
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension EnumCaseElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
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
public struct OperatorPrecedenceAndTypesSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case colon
    case precedenceGroupAndDesignatedTypes
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawOperatorPrecedenceAndTypesSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `OperatorPrecedenceAndTypesSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `OperatorPrecedenceAndTypesSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `OperatorPrecedenceAndTypesSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The precedence group and designated types for this operator
  /// 
  public var precedenceGroupAndDesignatedTypes: IdentifierListSyntax {
    get {
      let childData = data.child(at: Cursor.precedenceGroupAndDesignatedTypes.rawValue)
      return IdentifierListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.precedenceGroupAndDesignatedTypes.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .identifierList)
    }
    let newRaw = raw.replacingChild(at: Cursor.precedenceGroupAndDesignatedTypes.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withPrecedenceGroupAndDesignatedTypes(_ newChild: IdentifierListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawIdentifierListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.precedenceGroupAndDesignatedTypes.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension OperatorPrecedenceAndTypesSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "precedenceGroupAndDesignatedTypes": Syntax(precedenceGroupAndDesignatedTypes).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupRelationSyntax

/// 
/// Specify the new precedence group's relation to existing precedence
/// groups.
/// 
public struct PrecedenceGroupRelationSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case higherThanOrLowerThan
    case colon
    case otherNames
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupRelationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupRelationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrecedenceGroupRelationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrecedenceGroupRelationSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The relation to specified other precedence groups.
  /// 
  public var higherThanOrLowerThan: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.higherThanOrLowerThan.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withHigherThanOrLowerThan(value)
    }
  }
  public func withHigherThanOrLowerThan(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.higherThanOrLowerThan.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The name of other precedence group to which this precedence
  /// group relates.
  /// 
  public var otherNames: PrecedenceGroupNameListSyntax {
    get {
      let childData = data.child(at: Cursor.otherNames.rawValue)
      return PrecedenceGroupNameListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.otherNames.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .precedenceGroupNameList)
    }
    let newRaw = raw.replacingChild(at: Cursor.otherNames.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withOtherNames(_ newChild: PrecedenceGroupNameListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPrecedenceGroupNameListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.otherNames.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrecedenceGroupRelationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "higherThanOrLowerThan": Syntax(higherThanOrLowerThan).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "otherNames": Syntax(otherNames).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupNameElementSyntax

public struct PrecedenceGroupNameElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupNameElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupNameElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrecedenceGroupNameElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrecedenceGroupNameElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrecedenceGroupNameElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupAssignmentSyntax

/// 
/// Specifies the precedence of an operator when used in an operation
/// that includes optional chaining.
/// 
public struct PrecedenceGroupAssignmentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case assignmentKeyword
    case colon
    case flag
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupAssignmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupAssignmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrecedenceGroupAssignmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrecedenceGroupAssignmentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var assignmentKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.assignmentKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAssignmentKeyword(value)
    }
  }
  public func withAssignmentKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.assignmentKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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
      let childData = data.child(at: Cursor.flag.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFlag(value)
    }
  }
  public func withFlag(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .trueKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.flag.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrecedenceGroupAssignmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "assignmentKeyword": Syntax(assignmentKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "flag": Syntax(flag).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupAssociativitySyntax

/// 
/// Specifies how a sequence of operators with the same precedence level
/// are grouped together in the absence of grouping parentheses.
/// 
public struct PrecedenceGroupAssociativitySyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case associativityKeyword
    case colon
    case value
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupAssociativitySyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupAssociativitySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrecedenceGroupAssociativitySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrecedenceGroupAssociativitySyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var associativityKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.associativityKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAssociativityKeyword(value)
    }
  }
  public func withAssociativityKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.associativityKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// Operators that are `left`-associative group left-to-right.
  /// Operators that are `right`-associative group right-to-left.
  /// Operators that are specified with an associativity of `none`
  /// don't associate at all
  /// 
  public var value: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.value.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }
  public func withValue(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.value.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrecedenceGroupAssociativitySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "associativityKeyword": Syntax(associativityKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CustomAttributeSyntax

/// 
/// A custom `@` attribute.
/// 
public struct CustomAttributeSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case leftParen
    case argumentList
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCustomAttributeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CustomAttributeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CustomAttributeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CustomAttributeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.atSignToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAtSignToken(value)
    }
  }
  public func withAtSignToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .atSign).raw

    let newRaw = raw.replacingChild(
      at: Cursor.atSignToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The name of the attribute.
  public var attributeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.attributeName.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withAttributeName(value)
    }
  }
  public func withAttributeName(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.attributeName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var argumentList: TupleExprElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.argumentList.rawValue)
      return childData.map { TupleExprElementListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.argumentList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.argumentList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArgumentList(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.argumentList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CustomAttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self) as Any,
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self) as Any,
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
public struct AttributeSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case leftParen
    case argument
    case rightParen
    case tokenList
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAttributeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AttributeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AttributeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AttributeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.atSignToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAtSignToken(value)
    }
  }
  public func withAtSignToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .atSign).raw

    let newRaw = raw.replacingChild(
      at: Cursor.atSignToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The name of the attribute.
  public var attributeName: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.attributeName.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAttributeName(value)
    }
  }
  public func withAttributeName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.attributeName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// If the attribute takes arguments, the opening parenthesis.
  /// 
  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The arguments of the attribute. In case the attribute
  /// takes multiple arguments, they are gather in the
  /// appropriate takes first.
  /// 
  public var argument: Syntax? {
    get {
      let childData = data.child(at: Cursor.argument.rawValue)
      return childData.map { Syntax(data: $0) }
    }
    set(value) {
      self = withArgument(value)
    }
  }
  public func withArgument(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.argument.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// If the attribute takes arguments, the closing parenthesis.
  /// 
  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var tokenList: TokenListSyntax? {
    get {
      let childData = data.child(at: Cursor.tokenList.rawValue)
      return childData.map { TokenListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.tokenList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tokenList)
    }
    let newRaw = raw.replacingChild(at: Cursor.tokenList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withTokenList(_ newChild: TokenListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.tokenList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self) as Any,
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self) as Any,
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
public struct AvailabilityEntrySyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case availabilityList
    case semicolon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilityEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AvailabilityEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AvailabilityEntrySyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var availabilityList: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: Cursor.availabilityList.rawValue)
      return AvailabilitySpecListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.availabilityList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .availabilitySpecList)
    }
    let newRaw = raw.replacingChild(at: Cursor.availabilityList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAvailabilityList(_ newChild: AvailabilitySpecListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.availabilityList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var semicolon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.semicolon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withSemicolon(value)
    }
  }
  public func withSemicolon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .semicolon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.semicolon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AvailabilityEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "availabilityList": Syntax(availabilityList).asProtocol(SyntaxProtocol.self) as Any,
      "semicolon": Syntax(semicolon).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - LabeledSpecializeEntrySyntax

/// 
/// A labeled argument for the `@_specialize` attribute like
/// `exported: true`
/// 
public struct LabeledSpecializeEntrySyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case value
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawLabeledSpecializeEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `LabeledSpecializeEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `LabeledSpecializeEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `LabeledSpecializeEntrySyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The value for this argument
  public var value: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.value.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }
  public func withValue(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.value.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension LabeledSpecializeEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self) as Any,
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
public struct TargetFunctionEntrySyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case declname
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTargetFunctionEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TargetFunctionEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TargetFunctionEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TargetFunctionEntrySyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The value for this argument
  public var declname: DeclNameSyntax {
    get {
      let childData = data.child(at: Cursor.declname.rawValue)
      return DeclNameSyntax(data: childData!)
    }
    set(value) {
      self = withDeclname(value)
    }
  }
  public func withDeclname(_ newChild: DeclNameSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawDeclNameSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.declname.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TargetFunctionEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "declname": Syntax(declname).asProtocol(SyntaxProtocol.self) as Any,
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
public struct NamedAttributeStringArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case nameTok
    case colon
    case stringOrDeclname
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawNamedAttributeStringArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `NamedAttributeStringArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `NamedAttributeStringArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `NamedAttributeStringArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The label of the argument
  public var nameTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.nameTok.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withNameTok(value)
    }
  }
  public func withNameTok(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.nameTok.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var stringOrDeclname: Syntax {
    get {
      let childData = data.child(at: Cursor.stringOrDeclname.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withStringOrDeclname(value)
    }
  }
  public func withStringOrDeclname(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.stringOrDeclname.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension NamedAttributeStringArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "nameTok": Syntax(nameTok).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "stringOrDeclname": Syntax(stringOrDeclname).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclNameSyntax

public struct DeclNameSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case declBaseName
    case declNameArguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclNameSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: Syntax {
    get {
      let childData = data.child(at: Cursor.declBaseName.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withDeclBaseName(value)
    }
  }
  public func withDeclBaseName(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.declBaseName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }
  public func withDeclNameArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.declNameArguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImplementsAttributeArgumentsSyntax

/// 
/// The arguments for the `@_implements` attribute of the form
/// `Type, methodName(arg1Label:arg2Label:)`
/// 
public struct ImplementsAttributeArgumentsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case type
    case comma
    case declBaseName
    case declNameArguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawImplementsAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ImplementsAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ImplementsAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ImplementsAttributeArgumentsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The type for which the method with this attribute
  /// implements a requirement.
  /// 
  public var type: SimpleTypeIdentifierSyntax {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return SimpleTypeIdentifierSyntax(data: childData!)
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: SimpleTypeIdentifierSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSimpleTypeIdentifierSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The comma separating the type and method name
  /// 
  public var comma: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.comma.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withComma(value)
    }
  }
  public func withComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .comma).raw

    let newRaw = raw.replacingChild(
      at: Cursor.comma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: Syntax {
    get {
      let childData = data.child(at: Cursor.declBaseName.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withDeclBaseName(value)
    }
  }
  public func withDeclBaseName(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.declBaseName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }
  public func withDeclNameArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.declNameArguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ImplementsAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self) as Any,
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjCSelectorPieceSyntax

/// 
/// A piece of an Objective-C selector. Either consisting of just an
/// identifier for a nullary selector, an identifier and a colon for a
/// labeled argument or just a colon for an unlabeled argument
/// 
public struct ObjCSelectorPieceSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case colon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjCSelectorPieceSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjCSelectorPieceSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ObjCSelectorPieceSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ObjCSelectorPieceSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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
public struct DifferentiableAttributeArgumentsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case diffKind
    case diffKindComma
    case diffParams
    case diffParamsComma
    case whereClause
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDifferentiableAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DifferentiableAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DifferentiableAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DifferentiableAttributeArgumentsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var diffKind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffKind.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDiffKind(value)
    }
  }
  public func withDiffKind(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffKind.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The comma following the differentiability kind, if it exists.
  /// 
  public var diffKindComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffKindComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDiffKindComma(value)
    }
  }
  public func withDiffKindComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffKindComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParams.rawValue)
      return childData.map { DifferentiabilityParamsClauseSyntax(data: $0) }
    }
    set(value) {
      self = withDiffParams(value)
    }
  }
  public func withDiffParams(_ newChild: DifferentiabilityParamsClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffParams.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The comma following the differentiability parameters clause,
  /// if it exists.
  /// 
  public var diffParamsComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParamsComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDiffParamsComma(value)
    }
  }
  public func withDiffParamsComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffParamsComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause.rawValue)
      return childData.map { GenericWhereClauseSyntax(data: $0) }
    }
    set(value) {
      self = withWhereClause(value)
    }
  }
  public func withWhereClause(_ newChild: GenericWhereClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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
public struct DifferentiabilityParamsClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case wrtLabel
    case colon
    case parameters
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDifferentiabilityParamsClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamsClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DifferentiabilityParamsClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DifferentiabilityParamsClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The "wrt" label.
  public var wrtLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.wrtLabel.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWrtLabel(value)
    }
  }
  public func withWrtLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.wrtLabel.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The colon separating "wrt" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var parameters: Syntax {
    get {
      let childData = data.child(at: Cursor.parameters.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withParameters(value)
    }
  }
  public func withParameters(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.parameters.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DifferentiabilityParamsClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wrtLabel": Syntax(wrtLabel).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "parameters": Syntax(parameters).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamsSyntax

/// The differentiability parameters.
public struct DifferentiabilityParamsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case diffParams
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDifferentiabilityParamsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DifferentiabilityParamsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DifferentiabilityParamsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The parameters for differentiation.
  public var diffParams: DifferentiabilityParamListSyntax {
    get {
      let childData = data.child(at: Cursor.diffParams.rawValue)
      return DifferentiabilityParamListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.diffParams.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .differentiabilityParamList)
    }
    let newRaw = raw.replacingChild(at: Cursor.diffParams.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withDiffParams(_ newChild: DifferentiabilityParamListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawDifferentiabilityParamListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffParams.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DifferentiabilityParamsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": Syntax(diffParams).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamSyntax

/// 
/// A differentiability parameter: either the "self" identifier, a function
/// parameter name, or a function parameter index.
/// 
public struct DifferentiabilityParamSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case parameter
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDifferentiabilityParamSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DifferentiabilityParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DifferentiabilityParamSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var parameter: Syntax {
    get {
      let childData = data.child(at: Cursor.parameter.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withParameter(value)
    }
  }
  public func withParameter(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.parameter.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DifferentiabilityParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "parameter": Syntax(parameter).asProtocol(SyntaxProtocol.self) as Any,
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
public struct DerivativeRegistrationAttributeArgumentsSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case ofLabel
    case colon
    case originalDeclName
    case period
    case accessorKind
    case comma
    case diffParams
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDerivativeRegistrationAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DerivativeRegistrationAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DerivativeRegistrationAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DerivativeRegistrationAttributeArgumentsSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The "of" label.
  public var ofLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ofLabel.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withOfLabel(value)
    }
  }
  public func withOfLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.ofLabel.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The colon separating the "of" label and the original
  /// declaration name.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The referenced original declaration name.
  public var originalDeclName: QualifiedDeclNameSyntax {
    get {
      let childData = data.child(at: Cursor.originalDeclName.rawValue)
      return QualifiedDeclNameSyntax(data: childData!)
    }
    set(value) {
      self = withOriginalDeclName(value)
    }
  }
  public func withOriginalDeclName(_ newChild: QualifiedDeclNameSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawQualifiedDeclNameSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.originalDeclName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The period separating the original declaration name and the
  /// accessor name.
  /// 
  public var period: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.period.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withPeriod(value)
    }
  }
  public func withPeriod(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.period.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The accessor name.
  public var accessorKind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.accessorKind.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAccessorKind(value)
    }
  }
  public func withAccessorKind(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.accessorKind.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.comma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withComma(value)
    }
  }
  public func withComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.comma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParams.rawValue)
      return childData.map { DifferentiabilityParamsClauseSyntax(data: $0) }
    }
    set(value) {
      self = withDiffParams(value)
    }
  }
  public func withDiffParams(_ newChild: DifferentiabilityParamsClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.diffParams.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DerivativeRegistrationAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ofLabel": Syntax(ofLabel).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "originalDeclName": Syntax(originalDeclName).asProtocol(SyntaxProtocol.self) as Any,
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
public struct QualifiedDeclNameSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case baseType
    case dot
    case name
    case arguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawQualifiedDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `QualifiedDeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `QualifiedDeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `QualifiedDeclNameSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The base type of the qualified name, optionally specified.
  /// 
  public var baseType: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.baseType.rawValue)
      return childData.map { TypeSyntax(data: $0) }
    }
    set(value) {
      self = withBaseType(value)
    }
  }
  public func withBaseType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.baseType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.dot.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withDot(value)
    }
  }
  public func withDot(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.dot.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withArguments(value)
    }
  }
  public func withArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.arguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension QualifiedDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "baseType": baseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionDeclNameSyntax

/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclNameSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case arguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionDeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FunctionDeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FunctionDeclNameSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: Syntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withArguments(value)
    }
  }
  public func withArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.arguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension FunctionDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BackDeployAttributeSpecListSyntax

/// 
/// A collection of arguments for the `@_backDeploy` attribute
/// 
public struct BackDeployAttributeSpecListSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case beforeLabel
    case colon
    case versionList
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBackDeployAttributeSpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BackDeployAttributeSpecListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `BackDeployAttributeSpecListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `BackDeployAttributeSpecListSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The "before" label.
  public var beforeLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.beforeLabel.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withBeforeLabel(value)
    }
  }
  public func withBeforeLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.beforeLabel.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The colon separating "before" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The list of OS versions in which the declaration became ABI
  /// stable.
  /// 
  public var versionList: BackDeployVersionListSyntax {
    get {
      let childData = data.child(at: Cursor.versionList.rawValue)
      return BackDeployVersionListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.versionList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .backDeployVersionList)
    }
    let newRaw = raw.replacingChild(at: Cursor.versionList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withVersionList(_ newChild: BackDeployVersionListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawBackDeployVersionListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.versionList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension BackDeployAttributeSpecListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "beforeLabel": Syntax(beforeLabel).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "versionList": Syntax(versionList).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BackDeployVersionArgumentSyntax

/// 
/// A single platform/version pair in a `@_backDeploy` attribute,
/// e.g. `iOS 10.1`.
/// 
public struct BackDeployVersionArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case availabilityVersionRestriction
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBackDeployVersionArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BackDeployVersionArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `BackDeployVersionArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `BackDeployVersionArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax {
    get {
      let childData = data.child(at: Cursor.availabilityVersionRestriction.rawValue)
      return AvailabilityVersionRestrictionSyntax(data: childData!)
    }
    set(value) {
      self = withAvailabilityVersionRestriction(value)
    }
  }
  public func withAvailabilityVersionRestriction(_ newChild: AvailabilityVersionRestrictionSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawAvailabilityVersionRestrictionSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.availabilityVersionRestriction.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension BackDeployVersionArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "availabilityVersionRestriction": Syntax(availabilityVersionRestriction).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WhereClauseSyntax

public struct WhereClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case whereKeyword
    case guardResult
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawWhereClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `WhereClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `WhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `WhereClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whereKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWhereKeyword(value)
    }
  }
  public func withWhereKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whereKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var guardResult: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.guardResult.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withGuardResult(value)
    }
  }
  public func withGuardResult(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.guardResult.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension WhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "guardResult": Syntax(guardResult).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - YieldListSyntax

public struct YieldListSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case elementList
    case trailingComma
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawYieldListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `YieldListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `YieldListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `YieldListSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elementList: ExprListSyntax {
    get {
      let childData = data.child(at: Cursor.elementList.rawValue)
      return ExprListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elementList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .exprList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elementList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElementList(_ newChild: ExprListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elementList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension YieldListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConditionElementSyntax

public struct ConditionElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case condition
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawConditionElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ConditionElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ConditionElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ConditionElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var condition: Syntax {
    get {
      let childData = data.child(at: Cursor.condition.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }
  public func withCondition(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.condition.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ConditionElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityConditionSyntax

public struct AvailabilityConditionSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundAvailableKeyword
    case leftParen
    case availabilitySpec
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilityConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AvailabilityConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AvailabilityConditionSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundAvailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundAvailableKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundAvailableKeyword(value)
    }
  }
  public func withPoundAvailableKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundAvailableKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundAvailableKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: Cursor.availabilitySpec.rawValue)
      return AvailabilitySpecListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.availabilitySpec.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .availabilitySpecList)
    }
    let newRaw = raw.replacingChild(at: Cursor.availabilitySpec.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAvailabilitySpec(_ newChild: AvailabilitySpecListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.availabilitySpec.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AvailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundAvailableKeyword": Syntax(poundAvailableKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MatchingPatternConditionSyntax

public struct MatchingPatternConditionSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case caseKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMatchingPatternConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MatchingPatternConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MatchingPatternConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MatchingPatternConditionSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withCaseKeyword(value)
    }
  }
  public func withCaseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .caseKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.caseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: Cursor.typeAnnotation.rawValue)
      return childData.map { TypeAnnotationSyntax(data: $0) }
    }
    set(value) {
      self = withTypeAnnotation(value)
    }
  }
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeAnnotation.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var initializer: InitializerClauseSyntax {
    get {
      let childData = data.child(at: Cursor.initializer.rawValue)
      return InitializerClauseSyntax(data: childData!)
    }
    set(value) {
      self = withInitializer(value)
    }
  }
  public func withInitializer(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawInitializerClauseSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.initializer.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MatchingPatternConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": Syntax(initializer).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalBindingConditionSyntax

public struct OptionalBindingConditionSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case letOrVarKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawOptionalBindingConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `OptionalBindingConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `OptionalBindingConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `OptionalBindingConditionSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.letOrVarKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLetOrVarKeyword(value)
    }
  }
  public func withLetOrVarKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .letKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.letOrVarKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: Cursor.typeAnnotation.rawValue)
      return childData.map { TypeAnnotationSyntax(data: $0) }
    }
    set(value) {
      self = withTypeAnnotation(value)
    }
  }
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeAnnotation.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.initializer.rawValue)
      return childData.map { InitializerClauseSyntax(data: $0) }
    }
    set(value) {
      self = withInitializer(value)
    }
  }
  public func withInitializer(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.initializer.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension OptionalBindingConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnavailabilityConditionSyntax

public struct UnavailabilityConditionSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundUnavailableKeyword
    case leftParen
    case availabilitySpec
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnavailabilityConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnavailabilityConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnavailabilityConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnavailabilityConditionSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundUnavailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundUnavailableKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundUnavailableKeyword(value)
    }
  }
  public func withPoundUnavailableKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundUnavailableKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundUnavailableKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: Cursor.availabilitySpec.rawValue)
      return AvailabilitySpecListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.availabilitySpec.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .availabilitySpecList)
    }
    let newRaw = raw.replacingChild(at: Cursor.availabilitySpec.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAvailabilitySpec(_ newChild: AvailabilitySpecListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.availabilitySpec.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension UnavailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundUnavailableKeyword": Syntax(poundUnavailableKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ElseIfContinuationSyntax

public struct ElseIfContinuationSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case ifStatement
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawElseIfContinuationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ElseIfContinuationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ElseIfContinuationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ElseIfContinuationSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var ifStatement: IfStmtSyntax {
    get {
      let childData = data.child(at: Cursor.ifStatement.rawValue)
      return IfStmtSyntax(data: childData!)
    }
    set(value) {
      self = withIfStatement(value)
    }
  }
  public func withIfStatement(_ newChild: IfStmtSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawIfStmtSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.ifStatement.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ElseIfContinuationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ifStatement": Syntax(ifStatement).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ElseBlockSyntax

public struct ElseBlockSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case elseKeyword
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawElseBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ElseBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ElseBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ElseBlockSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var elseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.elseKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withElseKeyword(value)
    }
  }
  public func withElseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .elseKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ElseBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "elseKeyword": Syntax(elseKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchCaseSyntax

public struct SwitchCaseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case unknownAttr
    case label
    case statements
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSwitchCaseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SwitchCaseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SwitchCaseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SwitchCaseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var unknownAttr: AttributeSyntax? {
    get {
      let childData = data.child(at: Cursor.unknownAttr.rawValue)
      return childData.map { AttributeSyntax(data: $0) }
    }
    set(value) {
      self = withUnknownAttr(value)
    }
  }
  public func withUnknownAttr(_ newChild: AttributeSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.unknownAttr.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var label: Syntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements.rawValue)
      return CodeBlockItemListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.statements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .codeBlockItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.statements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.statements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SwitchCaseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unknownAttr": unknownAttr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchDefaultLabelSyntax

public struct SwitchDefaultLabelSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case defaultKeyword
    case colon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSwitchDefaultLabelSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SwitchDefaultLabelSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SwitchDefaultLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SwitchDefaultLabelSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var defaultKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.defaultKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDefaultKeyword(value)
    }
  }
  public func withDefaultKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .defaultKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.defaultKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SwitchDefaultLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "defaultKeyword": Syntax(defaultKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CaseItemSyntax

public struct CaseItemSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case pattern
    case whereClause
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCaseItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CaseItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CaseItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CaseItemSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause.rawValue)
      return childData.map { WhereClauseSyntax(data: $0) }
    }
    set(value) {
      self = withWhereClause(value)
    }
  }
  public func withWhereClause(_ newChild: WhereClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CaseItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CatchItemSyntax

public struct CatchItemSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case pattern
    case whereClause
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCatchItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CatchItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CatchItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CatchItemSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var pattern: PatternSyntax? {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return childData.map { PatternSyntax(data: $0) }
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause.rawValue)
      return childData.map { WhereClauseSyntax(data: $0) }
    }
    set(value) {
      self = withWhereClause(value)
    }
  }
  public func withWhereClause(_ newChild: WhereClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

public struct SwitchCaseLabelSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case caseKeyword
    case caseItems
    case colon
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSwitchCaseLabelSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SwitchCaseLabelSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SwitchCaseLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SwitchCaseLabelSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withCaseKeyword(value)
    }
  }
  public func withCaseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .caseKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.caseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var caseItems: CaseItemListSyntax {
    get {
      let childData = data.child(at: Cursor.caseItems.rawValue)
      return CaseItemListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.caseItems.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .caseItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.caseItems.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withCaseItems(_ newChild: CaseItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCaseItemListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.caseItems.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SwitchCaseLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "caseItems": Syntax(caseItems).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CatchClauseSyntax

public struct CatchClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case catchKeyword
    case catchItems
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCatchClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CatchClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CatchClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CatchClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var catchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.catchKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withCatchKeyword(value)
    }
  }
  public func withCatchKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .catchKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.catchKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var catchItems: CatchItemListSyntax? {
    get {
      let childData = data.child(at: Cursor.catchItems.rawValue)
      return childData.map { CatchItemListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.catchItems.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .catchItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.catchItems.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withCatchItems(_ newChild: CatchItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.catchItems.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CatchClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "catchKeyword": Syntax(catchKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "catchItems": catchItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericWhereClauseSyntax

public struct GenericWhereClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case whereKeyword
    case requirementList
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericWhereClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericWhereClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericWhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericWhereClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whereKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWhereKeyword(value)
    }
  }
  public func withWhereKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whereKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var requirementList: GenericRequirementListSyntax {
    get {
      let childData = data.child(at: Cursor.requirementList.rawValue)
      return GenericRequirementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.requirementList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .genericRequirementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.requirementList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withRequirementList(_ newChild: GenericRequirementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawGenericRequirementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.requirementList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericWhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "requirementList": Syntax(requirementList).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericRequirementSyntax

public struct GenericRequirementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case body
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericRequirementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var body: Syntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SameTypeRequirementSyntax

public struct SameTypeRequirementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftTypeIdentifier
    case equalityToken
    case rightTypeIdentifier
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSameTypeRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SameTypeRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SameTypeRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SameTypeRequirementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.leftTypeIdentifier.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withLeftTypeIdentifier(value)
    }
  }
  public func withLeftTypeIdentifier(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftTypeIdentifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var equalityToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.equalityToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withEqualityToken(value)
    }
  }
  public func withEqualityToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .spacedBinaryOperator).raw

    let newRaw = raw.replacingChild(
      at: Cursor.equalityToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.rightTypeIdentifier.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withRightTypeIdentifier(value)
    }
  }
  public func withRightTypeIdentifier(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightTypeIdentifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SameTypeRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self) as Any,
      "equalityToken": Syntax(equalityToken).asProtocol(SyntaxProtocol.self) as Any,
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericParameterSyntax

public struct GenericParameterSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case attributes
    case name
    case colon
    case inheritedType
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericParameterSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes.rawValue)
      return childData.map { AttributeListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.attributes.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .attributeList)
    }
    let newRaw = raw.replacingChild(at: Cursor.attributes.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAttributes(_ newChild: AttributeListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.attributes.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var inheritedType: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritedType.rawValue)
      return childData.map { TypeSyntax(data: $0) }
    }
    set(value) {
      self = withInheritedType(value)
    }
  }
  public func withInheritedType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.inheritedType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritedType": inheritedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrimaryAssociatedTypeSyntax

public struct PrimaryAssociatedTypeSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrimaryAssociatedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrimaryAssociatedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrimaryAssociatedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrimaryAssociatedTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrimaryAssociatedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericParameterClauseSyntax

public struct GenericParameterClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftAngleBracket
    case genericParameterList
    case rightAngleBracket
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericParameterClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericParameterClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericParameterClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftAngleBracket(value)
    }
  }
  public func withLeftAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var genericParameterList: GenericParameterListSyntax {
    get {
      let childData = data.child(at: Cursor.genericParameterList.rawValue)
      return GenericParameterListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.genericParameterList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .genericParameterList)
    }
    let newRaw = raw.replacingChild(at: Cursor.genericParameterList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withGenericParameterList(_ newChild: GenericParameterListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawGenericParameterListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.genericParameterList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightAngleBracket(value)
    }
  }
  public func withRightAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterList": Syntax(genericParameterList).asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConformanceRequirementSyntax

public struct ConformanceRequirementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftTypeIdentifier
    case colon
    case rightTypeIdentifier
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawConformanceRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ConformanceRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ConformanceRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ConformanceRequirementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.leftTypeIdentifier.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withLeftTypeIdentifier(value)
    }
  }
  public func withLeftTypeIdentifier(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftTypeIdentifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.rightTypeIdentifier.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withRightTypeIdentifier(value)
    }
  }
  public func withRightTypeIdentifier(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightTypeIdentifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ConformanceRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrimaryAssociatedTypeClauseSyntax

public struct PrimaryAssociatedTypeClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftAngleBracket
    case primaryAssociatedTypeList
    case rightAngleBracket
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrimaryAssociatedTypeClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrimaryAssociatedTypeClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrimaryAssociatedTypeClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrimaryAssociatedTypeClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftAngleBracket(value)
    }
  }
  public func withLeftAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax {
    get {
      let childData = data.child(at: Cursor.primaryAssociatedTypeList.rawValue)
      return PrimaryAssociatedTypeListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.primaryAssociatedTypeList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .primaryAssociatedTypeList)
    }
    let newRaw = raw.replacingChild(at: Cursor.primaryAssociatedTypeList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withPrimaryAssociatedTypeList(_ newChild: PrimaryAssociatedTypeListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPrimaryAssociatedTypeListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.primaryAssociatedTypeList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightAngleBracket(value)
    }
  }
  public func withRightAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrimaryAssociatedTypeClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
      "primaryAssociatedTypeList": Syntax(primaryAssociatedTypeList).asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CompositionTypeElementSyntax

public struct CompositionTypeElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case type
    case ampersand
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCompositionTypeElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CompositionTypeElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CompositionTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CompositionTypeElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var ampersand: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.ampersand.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAmpersand(value)
    }
  }
  public func withAmpersand(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.ampersand.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CompositionTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
      "ampersand": ampersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleTypeElementSyntax

public struct TupleTypeElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
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

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleTypeElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleTypeElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TupleTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TupleTypeElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var inOut: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.inOut.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withInOut(value)
    }
  }
  public func withInOut(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.inOut.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var secondName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.secondName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withSecondName(value)
    }
  }
  public func withSecondName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.secondName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var ellipsis: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.ellipsis.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withEllipsis(value)
    }
  }
  public func withEllipsis(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.ellipsis.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.initializer.rawValue)
      return childData.map { InitializerClauseSyntax(data: $0) }
    }
    set(value) {
      self = withInitializer(value)
    }
  }
  public func withInitializer(_ newChild: InitializerClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.initializer.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TupleTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "inOut": inOut.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondName": secondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentSyntax

public struct GenericArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case argumentType
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var argumentType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.argumentType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withArgumentType(value)
    }
  }
  public func withArgumentType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.argumentType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "argumentType": Syntax(argumentType).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentClauseSyntax

public struct GenericArgumentClauseSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftAngleBracket
    case arguments
    case rightAngleBracket
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericArgumentClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericArgumentClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GenericArgumentClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GenericArgumentClauseSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftAngleBracket(value)
    }
  }
  public func withLeftAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var arguments: GenericArgumentListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return GenericArgumentListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.arguments.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .genericArgumentList)
    }
    let newRaw = raw.replacingChild(at: Cursor.arguments.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArguments(_ newChild: GenericArgumentListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawGenericArgumentListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.arguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightAngleBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightAngleBracket(value)
    }
  }
  public func withRightAngleBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightAngleBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GenericArgumentClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self) as Any,
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeAnnotationSyntax

public struct TypeAnnotationSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case colon
    case type
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTypeAnnotationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TypeAnnotationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TypeAnnotationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TypeAnnotationSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TypeAnnotationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TuplePatternElementSyntax

public struct TuplePatternElementSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case pattern
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTuplePatternElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TuplePatternElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TuplePatternElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TuplePatternElementSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TuplePatternElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityArgumentSyntax

/// 
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,
/// or `message: "This has been deprecated"`.
/// 
public struct AvailabilityArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case entry
    case trailingComma
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilityArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AvailabilityArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AvailabilityArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The actual argument
  public var entry: Syntax {
    get {
      let childData = data.child(at: Cursor.entry.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withEntry(value)
    }
  }
  public func withEntry(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.entry.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }
  public func withTrailingComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingComma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AvailabilityArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "entry": Syntax(entry).asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityLabeledArgumentSyntax

/// 
/// A argument to an `@available` attribute that consists of a label and
/// a value, e.g. `message: "This has been deprecated"`.
/// 
public struct AvailabilityLabeledArgumentSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case label
    case colon
    case value
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilityLabeledArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityLabeledArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AvailabilityLabeledArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AvailabilityLabeledArgumentSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The colon separating label and value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The value of this labeled argument
  public var value: Syntax {
    get {
      let childData = data.child(at: Cursor.value.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withValue(value)
    }
  }
  public func withValue(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.value.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AvailabilityLabeledArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "value": Syntax(value).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityVersionRestrictionSyntax

/// 
/// An argument to `@available` that restricts the availability on a
/// certain platform to a version, e.g. `iOS 10` or `swift 3.4`.
/// 
public struct AvailabilityVersionRestrictionSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case platform
    case version
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilityVersionRestrictionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityVersionRestrictionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AvailabilityVersionRestrictionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AvailabilityVersionRestrictionSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// 
  /// The name of the OS on which the availability should be
  /// restricted or 'swift' if the availability should be
  /// restricted based on a Swift version.
  /// 
  public var platform: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.platform.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPlatform(value)
    }
  }
  public func withPlatform(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.platform.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var version: VersionTupleSyntax? {
    get {
      let childData = data.child(at: Cursor.version.rawValue)
      return childData.map { VersionTupleSyntax(data: $0) }
    }
    set(value) {
      self = withVersion(value)
    }
  }
  public func withVersion(_ newChild: VersionTupleSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.version.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AvailabilityVersionRestrictionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "platform": Syntax(platform).asProtocol(SyntaxProtocol.self) as Any,
      "version": version.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - VersionTupleSyntax

/// 
/// A version number of the form major.minor.patch in which the minor
/// and patch part may be omitted.
/// 
public struct VersionTupleSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case majorMinor
    case patchPeriod
    case patchVersion
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawVersionTupleSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `VersionTupleSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `VersionTupleSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `VersionTupleSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
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
      let childData = data.child(at: Cursor.majorMinor.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withMajorMinor(value)
    }
  }
  public func withMajorMinor(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.majorMinor.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// If the version contains a patch number, the period
  /// separating the minor from the patch number.
  /// 
  public var patchPeriod: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.patchPeriod.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withPatchPeriod(value)
    }
  }
  public func withPatchPeriod(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.patchPeriod.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// 
  /// The patch version if specified.
  /// 
  public var patchVersion: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.patchVersion.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withPatchVersion(value)
    }
  }
  public func withPatchVersion(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.patchVersion.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension VersionTupleSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "majorMinor": Syntax(majorMinor).asProtocol(SyntaxProtocol.self) as Any,
      "patchPeriod": patchPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "patchVersion": patchVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}
