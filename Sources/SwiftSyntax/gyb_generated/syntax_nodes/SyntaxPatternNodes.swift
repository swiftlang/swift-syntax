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


// MARK: - MissingPatternSyntax

public struct MissingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .missingPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MissingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingPattern)
    self._syntaxNode = Syntax(data)
  }

  public init() {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), ())) { (arena, _) in
      let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena)
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

extension MissingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - IsTypePatternSyntax

public struct IsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .isTypePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .isTypePattern)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? = nil,
    isKeyword: TokenSyntax = .keyword(.is),
    _ unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedAfterType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeIsKeyword, isKeyword, unexpectedBetweenIsKeywordAndType, type, unexpectedAfterType))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeIsKeyword?.raw,
        isKeyword.raw,
        unexpectedBetweenIsKeywordAndType?.raw,
        type.raw,
        unexpectedAfterType?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.isTypePattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIsKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeIsKeyword` to replace the node's
  ///                   current `unexpectedBeforeIsKeyword`, if present.
  public func withUnexpectedBeforeIsKeyword(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var isKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `isKeyword` replaced.
  /// - param newChild: The new `isKeyword` to replace the node's
  ///                   current `isKeyword`, if present.
  public func withIsKeyword(_ newChild: TokenSyntax) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIsKeywordAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIsKeywordAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenIsKeywordAndType` to replace the node's
  ///                   current `unexpectedBetweenIsKeywordAndType`, if present.
  public func withUnexpectedBetweenIsKeywordAndType(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
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
  public func withType(_ newChild: TypeSyntax) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
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
  public func withUnexpectedAfterType(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIsKeyword,
      \Self.isKeyword,
      \Self.unexpectedBetweenIsKeywordAndType,
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

extension IsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIsKeyword": unexpectedBeforeIsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "isKeyword": Syntax(isKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIsKeywordAndType": unexpectedBetweenIsKeywordAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterType": unexpectedAfterType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IdentifierPatternSyntax

public struct IdentifierPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .identifierPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IdentifierPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .identifierPattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeIdentifier, identifier, unexpectedAfterIdentifier))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeIdentifier?.raw,
        identifier.raw,
        unexpectedAfterIdentifier?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.identifierPattern, from: layout, arena: arena,
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
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(_ newChild: UnexpectedNodesSyntax?) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
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
  public func withIdentifier(_ newChild: TokenSyntax) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
  }

  public var unexpectedAfterIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterIdentifier` replaced.
  /// - param newChild: The new `unexpectedAfterIdentifier` to replace the node's
  ///                   current `unexpectedAfterIdentifier`, if present.
  public func withUnexpectedAfterIdentifier(_ newChild: UnexpectedNodesSyntax?) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIdentifier,
      \Self.identifier,
      \Self.unexpectedAfterIdentifier,
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

extension IdentifierPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterIdentifier": unexpectedAfterIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TuplePatternSyntax

public struct TuplePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tuplePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TuplePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil,
    elements: TuplePatternElementListSyntax,
    _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLeftParen, leftParen, unexpectedBetweenLeftParenAndElements, elements, unexpectedBetweenElementsAndRightParen, rightParen, unexpectedAfterRightParen))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLeftParen?.raw,
        leftParen.raw,
        unexpectedBetweenLeftParenAndElements?.raw,
        elements.raw,
        unexpectedBetweenElementsAndRightParen?.raw,
        rightParen.raw,
        unexpectedAfterRightParen?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.tuplePattern, from: layout, arena: arena,
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
      self = withUnexpectedBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftParen` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftParen` to replace the node's
  ///                   current `unexpectedBeforeLeftParen`, if present.
  public func withUnexpectedBeforeLeftParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndElements` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndElements` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndElements`, if present.
  public func withUnexpectedBetweenLeftParenAndElements(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
  }

  public var elements: TuplePatternElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TuplePatternElementListSyntax(childData!)
    }
    set(value) {
      self = withElements(value)
    }
  }

  /// Adds the provided `Element` to the node's `elements`
  /// collection.
  /// - param element: The new `Element` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `Element`
  ///            appended to its `elements` collection.
  public func addElement(_ element: TuplePatternElementSyntax) -> TuplePatternSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return TuplePatternSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(_ newChild: TuplePatternElementListSyntax) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
  }

  public var unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenElementsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenElementsAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenElementsAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenElementsAndRightParen`, if present.
  public func withUnexpectedBetweenElementsAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withRightParen(_ newChild: TokenSyntax) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withUnexpectedAfterRightParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndElements,
      \Self.elements,
      \Self.unexpectedBetweenElementsAndRightParen,
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

extension TuplePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndElements": unexpectedBetweenLeftParenAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenElementsAndRightParen": unexpectedBetweenElementsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WildcardPatternSyntax

public struct WildcardPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .wildcardPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `WildcardPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .wildcardPattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil,
    wildcard: TokenSyntax = .wildcardToken(),
    _ unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeWildcard, wildcard, unexpectedBetweenWildcardAndTypeAnnotation, typeAnnotation, unexpectedAfterTypeAnnotation))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeWildcard?.raw,
        wildcard.raw,
        unexpectedBetweenWildcardAndTypeAnnotation?.raw,
        typeAnnotation?.raw,
        unexpectedAfterTypeAnnotation?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.wildcardPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWildcard: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWildcard` replaced.
  /// - param newChild: The new `unexpectedBeforeWildcard` to replace the node's
  ///                   current `unexpectedBeforeWildcard`, if present.
  public func withUnexpectedBeforeWildcard(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var wildcard: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `wildcard` replaced.
  /// - param newChild: The new `wildcard` to replace the node's
  ///                   current `wildcard`, if present.
  public func withWildcard(_ newChild: TokenSyntax) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWildcardAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWildcardAndTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedBetweenWildcardAndTypeAnnotation` to replace the node's
  ///                   current `unexpectedBetweenWildcardAndTypeAnnotation`, if present.
  public func withUnexpectedBetweenWildcardAndTypeAnnotation(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
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
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedAfterTypeAnnotation` to replace the node's
  ///                   current `unexpectedAfterTypeAnnotation`, if present.
  public func withUnexpectedAfterTypeAnnotation(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWildcard,
      \Self.wildcard,
      \Self.unexpectedBetweenWildcardAndTypeAnnotation,
      \Self.typeAnnotation,
      \Self.unexpectedAfterTypeAnnotation,
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

extension WildcardPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWildcard": unexpectedBeforeWildcard.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWildcardAndTypeAnnotation": unexpectedBetweenWildcardAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTypeAnnotation": unexpectedAfterTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionPatternSyntax

public struct ExpressionPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .expressionPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ExpressionPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionPattern)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeExpression, expression, unexpectedAfterExpression))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeExpression?.raw,
        expression.raw,
        unexpectedAfterExpression?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.expressionPattern, from: layout, arena: arena,
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
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(_ newChild: UnexpectedNodesSyntax?) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
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
  public func withExpression(_ newChild: ExprSyntax) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
  }

  public var unexpectedAfterExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterExpression` replaced.
  /// - param newChild: The new `unexpectedAfterExpression` to replace the node's
  ///                   current `unexpectedAfterExpression`, if present.
  public func withUnexpectedAfterExpression(_ newChild: UnexpectedNodesSyntax?) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeExpression,
      \Self.expression,
      \Self.unexpectedAfterExpression,
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

extension ExpressionPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterExpression": unexpectedAfterExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ValueBindingPatternSyntax

public struct ValueBindingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .valueBindingPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ValueBindingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .valueBindingPattern)
    self._syntaxNode = Syntax(data)
  }

  public init<V: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? = nil,
    valuePattern: V,
    _ unexpectedAfterValuePattern: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    // Extend the lifetime of all parameters so their arenas don't get destroyed 
    // before they can be added as children of the new arena.
    let data: SyntaxData = withExtendedLifetime((SyntaxArena(), (unexpectedBeforeLetOrVarKeyword, letOrVarKeyword, unexpectedBetweenLetOrVarKeywordAndValuePattern, valuePattern, unexpectedAfterValuePattern))) { (arena, _) in
      let layout: [RawSyntax?] = [
        unexpectedBeforeLetOrVarKeyword?.raw,
        letOrVarKeyword.raw,
        unexpectedBetweenLetOrVarKeywordAndValuePattern?.raw,
        valuePattern.raw,
        unexpectedAfterValuePattern?.raw,
      ]
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.valueBindingPattern, from: layout, arena: arena,
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
      self = withUnexpectedBeforeLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLetOrVarKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeLetOrVarKeyword` to replace the node's
  ///                   current `unexpectedBeforeLetOrVarKeyword`, if present.
  public func withUnexpectedBeforeLetOrVarKeyword(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
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
  public func withLetOrVarKeyword(_ newChild: TokenSyntax) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLetOrVarKeywordAndValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLetOrVarKeywordAndValuePattern` replaced.
  /// - param newChild: The new `unexpectedBetweenLetOrVarKeywordAndValuePattern` to replace the node's
  ///                   current `unexpectedBetweenLetOrVarKeywordAndValuePattern`, if present.
  public func withUnexpectedBetweenLetOrVarKeywordAndValuePattern(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var valuePattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `valuePattern` replaced.
  /// - param newChild: The new `valuePattern` to replace the node's
  ///                   current `valuePattern`, if present.
  public func withValuePattern(_ newChild: PatternSyntax) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var unexpectedAfterValuePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValuePattern` replaced.
  /// - param newChild: The new `unexpectedAfterValuePattern` to replace the node's
  ///                   current `unexpectedAfterValuePattern`, if present.
  public func withUnexpectedAfterValuePattern(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLetOrVarKeyword,
      \Self.letOrVarKeyword,
      \Self.unexpectedBetweenLetOrVarKeywordAndValuePattern,
      \Self.valuePattern,
      \Self.unexpectedAfterValuePattern,
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

extension ValueBindingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLetOrVarKeyword": unexpectedBeforeLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLetOrVarKeywordAndValuePattern": unexpectedBetweenLetOrVarKeywordAndValuePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valuePattern": Syntax(valuePattern).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValuePattern": unexpectedAfterValuePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

