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


// MARK: - MissingDeclSyntax

public struct MissingDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .missingDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MissingDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedAfterModifiers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedAfterModifiers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.missingDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> MissingDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return MissingDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> MissingDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return MissingDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> MissingDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return MissingDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> MissingDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return MissingDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> MissingDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return MissingDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> MissingDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return MissingDeclSyntax(newData)
  }

  public var unexpectedAfterModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterModifiers` replaced.
  /// - param newChild: The new `unexpectedAfterModifiers` to replace the node's
  ///                   current `unexpectedAfterModifiers`, if present.
  public func withUnexpectedAfterModifiers(_ newChild: UnexpectedNodesSyntax?) -> MissingDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return MissingDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedAfterModifiers,
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

extension MissingDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterModifiers": unexpectedAfterModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypealiasDeclSyntax

public struct TypealiasDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .typealiasDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TypealiasDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typealiasDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? = nil,
    typealiasKeyword: TokenSyntax = .typealiasKeyword(),
    _ unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax,
    _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndTypealiasKeyword?.raw,
      typealiasKeyword.raw,
      unexpectedBetweenTypealiasKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInitializer?.raw,
      initializer.raw,
      unexpectedBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedAfterGenericWhereClause?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.typealiasDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> TypealiasDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> TypealiasDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndTypealiasKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndTypealiasKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndTypealiasKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndTypealiasKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndTypealiasKeyword(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var typealiasKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTypealiasKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `typealiasKeyword` replaced.
  /// - param newChild: The new `typealiasKeyword` to replace the node's
  ///                   current `typealiasKeyword`, if present.
  public func withTypealiasKeyword(_ newChild: TokenSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.typealiasKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypealiasKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypealiasKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenTypealiasKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenTypealiasKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenTypealiasKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndInitializer`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndInitializer(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var initializer: TypeInitializerClauseSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return TypeInitializerClauseSyntax(childData!)
    }
    set(value) {
      self = withInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(_ newChild: TypeInitializerClauseSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.typeInitializerClause, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInitializerAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInitializerAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInitializerAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInitializerAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInitializerAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedAfterGenericWhereClause` to replace the node's
  ///                   current `unexpectedAfterGenericWhereClause`, if present.
  public func withUnexpectedAfterGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return TypealiasDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndTypealiasKeyword,
      \Self.typealiasKeyword,
      \Self.unexpectedBetweenTypealiasKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndInitializer,
      \Self.initializer,
      \Self.unexpectedBetweenInitializerAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedAfterGenericWhereClause,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return "generic where clause"
    case 14:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension TypealiasDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndTypealiasKeyword": unexpectedBetweenModifiersAndTypealiasKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typealiasKeyword": Syntax(typealiasKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTypealiasKeywordAndIdentifier": unexpectedBetweenTypealiasKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndInitializer": unexpectedBetweenGenericParameterClauseAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": Syntax(initializer).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenInitializerAndGenericWhereClause": unexpectedBetweenInitializerAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericWhereClause": unexpectedAfterGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AssociatedtypeDeclSyntax

public struct AssociatedtypeDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .associatedtypeDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AssociatedtypeDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .associatedtypeDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? = nil,
    associatedtypeKeyword: TokenSyntax = .associatedtypeKeyword(),
    _ unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax? = nil,
    _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndAssociatedtypeKeyword?.raw,
      associatedtypeKeyword.raw,
      unexpectedBetweenAssociatedtypeKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndInitializer?.raw,
      initializer?.raw,
      unexpectedBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedAfterGenericWhereClause?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.associatedtypeDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> AssociatedtypeDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> AssociatedtypeDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndAssociatedtypeKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndAssociatedtypeKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndAssociatedtypeKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndAssociatedtypeKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndAssociatedtypeKeyword(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var associatedtypeKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAssociatedtypeKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `associatedtypeKeyword` replaced.
  /// - param newChild: The new `associatedtypeKeyword` to replace the node's
  ///                   current `associatedtypeKeyword`, if present.
  public func withAssociatedtypeKeyword(_ newChild: TokenSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.associatedtypeKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAssociatedtypeKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAssociatedtypeKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenAssociatedtypeKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenAssociatedtypeKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenAssociatedtypeKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndInheritanceClause`, if present.
  public func withUnexpectedBetweenIdentifierAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndInitializer` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndInitializer` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndInitializer`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndInitializer(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var initializer: TypeInitializerClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
  public func withInitializer(_ newChild: TypeInitializerClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInitializerAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInitializerAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInitializerAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInitializerAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInitializerAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedAfterGenericWhereClause` to replace the node's
  ///                   current `unexpectedAfterGenericWhereClause`, if present.
  public func withUnexpectedAfterGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return AssociatedtypeDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndAssociatedtypeKeyword,
      \Self.associatedtypeKeyword,
      \Self.unexpectedBetweenAssociatedtypeKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndInitializer,
      \Self.initializer,
      \Self.unexpectedBetweenInitializerAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedAfterGenericWhereClause,
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
      return nil
    case 8:
      return nil
    case 9:
      return "inheritance clause"
    case 10:
      return nil
    case 11:
      return nil
    case 12:
      return nil
    case 13:
      return "generic where clause"
    case 14:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension AssociatedtypeDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndAssociatedtypeKeyword": unexpectedBetweenModifiersAndAssociatedtypeKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associatedtypeKeyword": Syntax(associatedtypeKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAssociatedtypeKeywordAndIdentifier": unexpectedBetweenAssociatedtypeKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndInheritanceClause": unexpectedBetweenIdentifierAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndInitializer": unexpectedBetweenInheritanceClauseAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInitializerAndGenericWhereClause": unexpectedBetweenInitializerAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericWhereClause": unexpectedAfterGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfConfigDeclSyntax

public struct IfConfigDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .ifConfigDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IfConfigDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifConfigDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeClauses: UnexpectedNodesSyntax? = nil,
    clauses: IfConfigClauseListSyntax,
    _ unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? = nil,
    poundEndif: TokenSyntax = .poundEndifKeyword(),
    _ unexpectedAfterPoundEndif: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClauses?.raw,
      clauses.raw,
      unexpectedBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
      unexpectedAfterPoundEndif?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.ifConfigDecl, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeClauses: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeClauses(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeClauses` replaced.
  /// - param newChild: The new `unexpectedBeforeClauses` to replace the node's
  ///                   current `unexpectedBeforeClauses`, if present.
  public func withUnexpectedBeforeClauses(_ newChild: UnexpectedNodesSyntax?) -> IfConfigDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  public var clauses: IfConfigClauseListSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return IfConfigClauseListSyntax(childData!)
    }
    set(value) {
      self = withClauses(value)
    }
  }

  /// Adds the provided `Clause` to the node's `clauses`
  /// collection.
  /// - param element: The new `Clause` to add to the node's
  ///                  `clauses` collection.
  /// - returns: A copy of the receiver with the provided `Clause`
  ///            appended to its `clauses` collection.
  public func addClause(_ element: IfConfigClauseSyntax) -> IfConfigDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClauseList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `clauses` replaced.
  /// - param newChild: The new `clauses` to replace the node's
  ///                   current `clauses`, if present.
  public func withClauses(_ newChild: IfConfigClauseListSyntax?) -> IfConfigDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigClauseList, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  public var unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenClausesAndPoundEndif(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenClausesAndPoundEndif` replaced.
  /// - param newChild: The new `unexpectedBetweenClausesAndPoundEndif` to replace the node's
  ///                   current `unexpectedBetweenClausesAndPoundEndif`, if present.
  public func withUnexpectedBetweenClausesAndPoundEndif(_ newChild: UnexpectedNodesSyntax?) -> IfConfigDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  public var poundEndif: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundEndif(value)
    }
  }

  /// Returns a copy of the receiver with its `poundEndif` replaced.
  /// - param newChild: The new `poundEndif` to replace the node's
  ///                   current `poundEndif`, if present.
  public func withPoundEndif(_ newChild: TokenSyntax?) -> IfConfigDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundEndifKeyword, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  public var unexpectedAfterPoundEndif: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterPoundEndif(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterPoundEndif` replaced.
  /// - param newChild: The new `unexpectedAfterPoundEndif` to replace the node's
  ///                   current `unexpectedAfterPoundEndif`, if present.
  public func withUnexpectedAfterPoundEndif(_ newChild: UnexpectedNodesSyntax?) -> IfConfigDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return IfConfigDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeClauses,
      \Self.clauses,
      \Self.unexpectedBetweenClausesAndPoundEndif,
      \Self.poundEndif,
      \Self.unexpectedAfterPoundEndif,
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

extension IfConfigDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeClauses": unexpectedBeforeClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "clauses": Syntax(clauses).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenClausesAndPoundEndif": unexpectedBetweenClausesAndPoundEndif.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundEndif": Syntax(poundEndif).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterPoundEndif": unexpectedAfterPoundEndif.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundErrorDeclSyntax

public struct PoundErrorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .poundErrorDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PoundErrorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundErrorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundError: UnexpectedNodesSyntax? = nil,
    poundError: TokenSyntax = .poundErrorKeyword(),
    _ unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundError?.raw,
      poundError.raw,
      unexpectedBetweenPoundErrorAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.poundErrorDecl, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePoundError: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundError(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundError` replaced.
  /// - param newChild: The new `unexpectedBeforePoundError` to replace the node's
  ///                   current `unexpectedBeforePoundError`, if present.
  public func withUnexpectedBeforePoundError(_ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public var poundError: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundError(value)
    }
  }

  /// Returns a copy of the receiver with its `poundError` replaced.
  /// - param newChild: The new `poundError` to replace the node's
  ///                   current `poundError`, if present.
  public func withPoundError(_ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundErrorKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundErrorAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundErrorAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundErrorAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundErrorAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundErrorAndLeftParen(_ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndMessage` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndMessage` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndMessage`, if present.
  public func withUnexpectedBetweenLeftParenAndMessage(_ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public var message: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      self = withMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(_ newChild: StringLiteralExprSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMessageAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMessageAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenMessageAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenMessageAndRightParen`, if present.
  public func withUnexpectedBetweenMessageAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
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
  public func withRightParen(_ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
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
  public func withUnexpectedAfterRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return PoundErrorDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundError,
      \Self.poundError,
      \Self.unexpectedBetweenPoundErrorAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndMessage,
      \Self.message,
      \Self.unexpectedBetweenMessageAndRightParen,
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
      return "message"
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

extension PoundErrorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundError": unexpectedBeforePoundError.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundError": Syntax(poundError).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundErrorAndLeftParen": unexpectedBetweenPoundErrorAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndMessage": unexpectedBetweenLeftParenAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": Syntax(message).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMessageAndRightParen": unexpectedBetweenMessageAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundWarningDeclSyntax

public struct PoundWarningDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .poundWarningDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PoundWarningDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundWarningDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundWarning: UnexpectedNodesSyntax? = nil,
    poundWarning: TokenSyntax = .poundWarningKeyword(),
    _ unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundWarning?.raw,
      poundWarning.raw,
      unexpectedBetweenPoundWarningAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.poundWarningDecl, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePoundWarning: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundWarning(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundWarning` replaced.
  /// - param newChild: The new `unexpectedBeforePoundWarning` to replace the node's
  ///                   current `unexpectedBeforePoundWarning`, if present.
  public func withUnexpectedBeforePoundWarning(_ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public var poundWarning: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundWarning(value)
    }
  }

  /// Returns a copy of the receiver with its `poundWarning` replaced.
  /// - param newChild: The new `poundWarning` to replace the node's
  ///                   current `poundWarning`, if present.
  public func withPoundWarning(_ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundWarningKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundWarningAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundWarningAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundWarningAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundWarningAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundWarningAndLeftParen(_ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndMessage` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndMessage` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndMessage`, if present.
  public func withUnexpectedBetweenLeftParenAndMessage(_ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public var message: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
    }
    set(value) {
      self = withMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(_ newChild: StringLiteralExprSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMessageAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMessageAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenMessageAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenMessageAndRightParen`, if present.
  public func withUnexpectedBetweenMessageAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
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
  public func withRightParen(_ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
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
  public func withUnexpectedAfterRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return PoundWarningDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundWarning,
      \Self.poundWarning,
      \Self.unexpectedBetweenPoundWarningAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndMessage,
      \Self.message,
      \Self.unexpectedBetweenMessageAndRightParen,
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
      return "message"
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

extension PoundWarningDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundWarning": unexpectedBeforePoundWarning.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundWarning": Syntax(poundWarning).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundWarningAndLeftParen": unexpectedBetweenPoundWarningAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndMessage": unexpectedBetweenLeftParenAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": Syntax(message).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMessageAndRightParen": unexpectedBetweenMessageAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundSourceLocationSyntax

public struct PoundSourceLocationSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .poundSourceLocation else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PoundSourceLocationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundSourceLocation)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? = nil,
    poundSourceLocation: TokenSyntax = .poundSourceLocationKeyword(),
    _ unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? = nil,
    args: PoundSourceLocationArgsSyntax? = nil,
    _ unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundSourceLocation?.raw,
      poundSourceLocation.raw,
      unexpectedBetweenPoundSourceLocationAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArgs?.raw,
      args?.raw,
      unexpectedBetweenArgsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.poundSourceLocation, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundSourceLocation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundSourceLocation` replaced.
  /// - param newChild: The new `unexpectedBeforePoundSourceLocation` to replace the node's
  ///                   current `unexpectedBeforePoundSourceLocation`, if present.
  public func withUnexpectedBeforePoundSourceLocation(_ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public var poundSourceLocation: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundSourceLocation(value)
    }
  }

  /// Returns a copy of the receiver with its `poundSourceLocation` replaced.
  /// - param newChild: The new `poundSourceLocation` to replace the node's
  ///                   current `poundSourceLocation`, if present.
  public func withPoundSourceLocation(_ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundSourceLocationKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundSourceLocationAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundSourceLocationAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundSourceLocationAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundSourceLocationAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundSourceLocationAndLeftParen(_ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndArgs(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndArgs` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndArgs` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndArgs`, if present.
  public func withUnexpectedBetweenLeftParenAndArgs(_ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public var args: PoundSourceLocationArgsSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return PoundSourceLocationArgsSyntax(childData!)
    }
    set(value) {
      self = withArgs(value)
    }
  }

  /// Returns a copy of the receiver with its `args` replaced.
  /// - param newChild: The new `args` to replace the node's
  ///                   current `args`, if present.
  public func withArgs(_ newChild: PoundSourceLocationArgsSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgsAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenArgsAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenArgsAndRightParen`, if present.
  public func withUnexpectedBetweenArgsAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
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
  public func withRightParen(_ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
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
  public func withUnexpectedAfterRightParen(_ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return PoundSourceLocationSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundSourceLocation,
      \Self.poundSourceLocation,
      \Self.unexpectedBetweenPoundSourceLocationAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArgs,
      \Self.args,
      \Self.unexpectedBetweenArgsAndRightParen,
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
      return "arguments"
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

extension PoundSourceLocationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundSourceLocation": unexpectedBeforePoundSourceLocation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundSourceLocation": Syntax(poundSourceLocation).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundSourceLocationAndLeftParen": unexpectedBetweenPoundSourceLocationAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndArgs": unexpectedBetweenLeftParenAndArgs.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "args": args.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenArgsAndRightParen": unexpectedBetweenArgsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightParen": unexpectedAfterRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClassDeclSyntax

public struct ClassDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .classDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ClassDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .classDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? = nil,
    classKeyword: TokenSyntax = .classKeyword(),
    _ unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndClassKeyword?.raw,
      classKeyword.raw,
      unexpectedBetweenClassKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.classDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ClassDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ClassDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> ClassDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ClassDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndClassKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndClassKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndClassKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndClassKeyword(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var classKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `classKeyword` replaced.
  /// - param newChild: The new `classKeyword` to replace the node's
  ///                   current `classKeyword`, if present.
  public func withClassKeyword(_ newChild: TokenSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenClassKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenClassKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenClassKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenClassKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenClassKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return ClassDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndClassKeyword,
      \Self.classKeyword,
      \Self.unexpectedBetweenClassKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "inheritance clause"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension ClassDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndClassKeyword": unexpectedBetweenModifiersAndClassKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "classKeyword": Syntax(classKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenClassKeywordAndIdentifier": unexpectedBetweenClassKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndInheritanceClause": unexpectedBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ActorDeclSyntax

public struct ActorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .actorDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ActorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .actorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? = nil,
    actorKeyword: TokenSyntax = .contextualKeyword("actor"),
    _ unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndActorKeyword?.raw,
      actorKeyword.raw,
      unexpectedBetweenActorKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.actorDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ActorDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ActorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> ActorDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ActorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndActorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndActorKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndActorKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndActorKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndActorKeyword(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var actorKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withActorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `actorKeyword` replaced.
  /// - param newChild: The new `actorKeyword` to replace the node's
  ///                   current `actorKeyword`, if present.
  public func withActorKeyword(_ newChild: TokenSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenActorKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenActorKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenActorKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenActorKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenActorKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return ActorDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndActorKeyword,
      \Self.actorKeyword,
      \Self.unexpectedBetweenActorKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "type inheritance clause"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension ActorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndActorKeyword": unexpectedBetweenModifiersAndActorKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "actorKeyword": Syntax(actorKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenActorKeywordAndIdentifier": unexpectedBetweenActorKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndInheritanceClause": unexpectedBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - StructDeclSyntax

public struct StructDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .structDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `StructDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .structDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? = nil,
    structKeyword: TokenSyntax = .structKeyword(),
    _ unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndStructKeyword?.raw,
      structKeyword.raw,
      unexpectedBetweenStructKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.structDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return StructDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> StructDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return StructDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return StructDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return StructDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> StructDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return StructDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndStructKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndStructKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndStructKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndStructKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndStructKeyword(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var structKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withStructKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `structKeyword` replaced.
  /// - param newChild: The new `structKeyword` to replace the node's
  ///                   current `structKeyword`, if present.
  public func withStructKeyword(_ newChild: TokenSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.structKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenStructKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenStructKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenStructKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenStructKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenStructKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return StructDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndStructKeyword,
      \Self.structKeyword,
      \Self.unexpectedBetweenStructKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "type inheritance clause"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension StructDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndStructKeyword": unexpectedBetweenModifiersAndStructKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "structKeyword": Syntax(structKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenStructKeywordAndIdentifier": unexpectedBetweenStructKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndInheritanceClause": unexpectedBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ProtocolDeclSyntax

public struct ProtocolDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .protocolDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ProtocolDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .protocolDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? = nil,
    protocolKeyword: TokenSyntax = .protocolKeyword(),
    _ unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax? = nil,
    _ unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndProtocolKeyword?.raw,
      protocolKeyword.raw,
      unexpectedBetweenProtocolKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw,
      primaryAssociatedTypeClause?.raw,
      unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.protocolDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ProtocolDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> ProtocolDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndProtocolKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndProtocolKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndProtocolKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndProtocolKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndProtocolKeyword(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var protocolKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withProtocolKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `protocolKeyword` replaced.
  /// - param newChild: The new `protocolKeyword` to replace the node's
  ///                   current `protocolKeyword`, if present.
  public func withProtocolKeyword(_ newChild: TokenSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.protocolKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenProtocolKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenProtocolKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenProtocolKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenProtocolKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenProtocolKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause`, if present.
  public func withUnexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return PrimaryAssociatedTypeClauseSyntax(childData!)
    }
    set(value) {
      self = withPrimaryAssociatedTypeClause(value)
    }
  }

  /// Returns a copy of the receiver with its `primaryAssociatedTypeClause` replaced.
  /// - param newChild: The new `primaryAssociatedTypeClause` to replace the node's
  ///                   current `primaryAssociatedTypeClause`, if present.
  public func withPrimaryAssociatedTypeClause(_ newChild: PrimaryAssociatedTypeClauseSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause`, if present.
  public func withUnexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return ProtocolDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndProtocolKeyword,
      \Self.protocolKeyword,
      \Self.unexpectedBetweenProtocolKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause,
      \Self.primaryAssociatedTypeClause,
      \Self.unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "primary associated type clause"
    case 10:
      return nil
    case 11:
      return "inheritance clause"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension ProtocolDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndProtocolKeyword": unexpectedBetweenModifiersAndProtocolKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "protocolKeyword": Syntax(protocolKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenProtocolKeywordAndIdentifier": unexpectedBetweenProtocolKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause": unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "primaryAssociatedTypeClause": primaryAssociatedTypeClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause": unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExtensionDeclSyntax

public struct ExtensionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .extensionDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ExtensionDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .extensionDecl)
    self._syntaxNode = Syntax(data)
  }

  public init<E: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? = nil,
    extensionKeyword: TokenSyntax = .extensionKeyword(),
    _ unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? = nil,
    extendedType: E,
    _ unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndExtensionKeyword?.raw,
      extensionKeyword.raw,
      unexpectedBetweenExtensionKeywordAndExtendedType?.raw,
      extendedType.raw,
      unexpectedBetweenExtendedTypeAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.extensionDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ExtensionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> ExtensionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndExtensionKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndExtensionKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndExtensionKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndExtensionKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndExtensionKeyword(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var extensionKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withExtensionKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `extensionKeyword` replaced.
  /// - param newChild: The new `extensionKeyword` to replace the node's
  ///                   current `extensionKeyword`, if present.
  public func withExtensionKeyword(_ newChild: TokenSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.extensionKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExtensionKeywordAndExtendedType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExtensionKeywordAndExtendedType` replaced.
  /// - param newChild: The new `unexpectedBetweenExtensionKeywordAndExtendedType` to replace the node's
  ///                   current `unexpectedBetweenExtensionKeywordAndExtendedType`, if present.
  public func withUnexpectedBetweenExtensionKeywordAndExtendedType(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var extendedType: TypeSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withExtendedType(value)
    }
  }

  /// Returns a copy of the receiver with its `extendedType` replaced.
  /// - param newChild: The new `extendedType` to replace the node's
  ///                   current `extendedType`, if present.
  public func withExtendedType(_ newChild: TypeSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExtendedTypeAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExtendedTypeAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenExtendedTypeAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenExtendedTypeAndInheritanceClause`, if present.
  public func withUnexpectedBetweenExtendedTypeAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return ExtensionDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndExtensionKeyword,
      \Self.extensionKeyword,
      \Self.unexpectedBetweenExtensionKeywordAndExtendedType,
      \Self.extendedType,
      \Self.unexpectedBetweenExtendedTypeAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "inheritance clause"
    case 10:
      return nil
    case 11:
      return "generic where clause"
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

extension ExtensionDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndExtensionKeyword": unexpectedBetweenModifiersAndExtensionKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "extensionKeyword": Syntax(extensionKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExtensionKeywordAndExtendedType": unexpectedBetweenExtensionKeywordAndExtendedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "extendedType": Syntax(extendedType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExtendedTypeAndInheritanceClause": unexpectedBetweenExtendedTypeAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionDeclSyntax

public struct FunctionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .functionDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `FunctionDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? = nil,
    funcKeyword: TokenSyntax = .funcKeyword(),
    _ unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax? = nil,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndFuncKeyword?.raw,
      funcKeyword.raw,
      unexpectedBetweenFuncKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
      unexpectedAfterBody?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.functionDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> FunctionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> FunctionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndFuncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndFuncKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndFuncKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndFuncKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndFuncKeyword(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var funcKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withFuncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `funcKeyword` replaced.
  /// - param newChild: The new `funcKeyword` to replace the node's
  ///                   current `funcKeyword`, if present.
  public func withFuncKeyword(_ newChild: TokenSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.funcKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFuncKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFuncKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenFuncKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenFuncKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenFuncKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndSignature` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndSignature` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndSignature`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndSignature(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var signature: FunctionSignatureSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return FunctionSignatureSyntax(childData!)
    }
    set(value) {
      self = withSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(_ newChild: FunctionSignatureSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSignatureAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSignatureAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenSignatureAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenSignatureAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenSignatureAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndBody` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndBody` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndBody`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndBody(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(_ newChild: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
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
  public func withUnexpectedAfterBody(_ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return FunctionDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndFuncKeyword,
      \Self.funcKeyword,
      \Self.unexpectedBetweenFuncKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndSignature,
      \Self.signature,
      \Self.unexpectedBetweenSignatureAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndBody,
      \Self.body,
      \Self.unexpectedAfterBody,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "function signature"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension FunctionDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndFuncKeyword": unexpectedBetweenModifiersAndFuncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "funcKeyword": Syntax(funcKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFuncKeywordAndIdentifier": unexpectedBetweenFuncKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndSignature": unexpectedBetweenGenericParameterClauseAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": Syntax(signature).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSignatureAndGenericWhereClause": unexpectedBetweenSignatureAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndBody": unexpectedBetweenGenericWhereClauseAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterBody": unexpectedAfterBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InitializerDeclSyntax

public struct InitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .initializerDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `InitializerDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .initializerDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? = nil,
    initKeyword: TokenSyntax = .initKeyword(),
    _ unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? = nil,
    optionalMark: TokenSyntax? = nil,
    _ unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax? = nil,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndInitKeyword?.raw,
      initKeyword.raw,
      unexpectedBetweenInitKeywordAndOptionalMark?.raw,
      optionalMark?.raw,
      unexpectedBetweenOptionalMarkAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
      unexpectedAfterBody?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.initializerDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> InitializerDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> InitializerDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndInitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndInitKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndInitKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndInitKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndInitKeyword(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var initKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withInitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `initKeyword` replaced.
  /// - param newChild: The new `initKeyword` to replace the node's
  ///                   current `initKeyword`, if present.
  public func withInitKeyword(_ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.initKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInitKeywordAndOptionalMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInitKeywordAndOptionalMark` replaced.
  /// - param newChild: The new `unexpectedBetweenInitKeywordAndOptionalMark` to replace the node's
  ///                   current `unexpectedBetweenInitKeywordAndOptionalMark`, if present.
  public func withUnexpectedBetweenInitKeywordAndOptionalMark(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var optionalMark: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOptionalMark(value)
    }
  }

  /// Returns a copy of the receiver with its `optionalMark` replaced.
  /// - param newChild: The new `optionalMark` to replace the node's
  ///                   current `optionalMark`, if present.
  public func withOptionalMark(_ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOptionalMarkAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOptionalMarkAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenOptionalMarkAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenOptionalMarkAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenOptionalMarkAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndSignature` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndSignature` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndSignature`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndSignature(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var signature: FunctionSignatureSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return FunctionSignatureSyntax(childData!)
    }
    set(value) {
      self = withSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(_ newChild: FunctionSignatureSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSignatureAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSignatureAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenSignatureAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenSignatureAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenSignatureAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndBody` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndBody` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndBody`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndBody(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(_ newChild: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
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
  public func withUnexpectedAfterBody(_ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return InitializerDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndInitKeyword,
      \Self.initKeyword,
      \Self.unexpectedBetweenInitKeywordAndOptionalMark,
      \Self.optionalMark,
      \Self.unexpectedBetweenOptionalMarkAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndSignature,
      \Self.signature,
      \Self.unexpectedBetweenSignatureAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndBody,
      \Self.body,
      \Self.unexpectedAfterBody,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "function signature"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension InitializerDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndInitKeyword": unexpectedBetweenModifiersAndInitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initKeyword": Syntax(initKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenInitKeywordAndOptionalMark": unexpectedBetweenInitKeywordAndOptionalMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "optionalMark": optionalMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenOptionalMarkAndGenericParameterClause": unexpectedBetweenOptionalMarkAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndSignature": unexpectedBetweenGenericParameterClauseAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": Syntax(signature).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSignatureAndGenericWhereClause": unexpectedBetweenSignatureAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndBody": unexpectedBetweenGenericWhereClauseAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterBody": unexpectedAfterBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeinitializerDeclSyntax

public struct DeinitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .deinitializerDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `DeinitializerDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .deinitializerDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? = nil,
    deinitKeyword: TokenSyntax = .deinitKeyword(),
    _ unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax? = nil,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndDeinitKeyword?.raw,
      deinitKeyword.raw,
      unexpectedBetweenDeinitKeywordAndBody?.raw,
      body?.raw,
      unexpectedAfterBody?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.deinitializerDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> DeinitializerDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> DeinitializerDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndDeinitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndDeinitKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndDeinitKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndDeinitKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndDeinitKeyword(_ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public var deinitKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDeinitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `deinitKeyword` replaced.
  /// - param newChild: The new `deinitKeyword` to replace the node's
  ///                   current `deinitKeyword`, if present.
  public func withDeinitKeyword(_ newChild: TokenSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.deinitKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDeinitKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDeinitKeywordAndBody` replaced.
  /// - param newChild: The new `unexpectedBetweenDeinitKeywordAndBody` to replace the node's
  ///                   current `unexpectedBetweenDeinitKeywordAndBody`, if present.
  public func withUnexpectedBetweenDeinitKeywordAndBody(_ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(_ newChild: CodeBlockSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
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
  public func withUnexpectedAfterBody(_ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return DeinitializerDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndDeinitKeyword,
      \Self.deinitKeyword,
      \Self.unexpectedBetweenDeinitKeywordAndBody,
      \Self.body,
      \Self.unexpectedAfterBody,
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
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension DeinitializerDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndDeinitKeyword": unexpectedBetweenModifiersAndDeinitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "deinitKeyword": Syntax(deinitKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDeinitKeywordAndBody": unexpectedBetweenDeinitKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterBody": unexpectedAfterBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptDeclSyntax

public struct SubscriptDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
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
    guard node.raw.kind == .subscriptDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `SubscriptDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .subscriptDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? = nil,
    subscriptKeyword: TokenSyntax = .subscriptKeyword(),
    _ unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? = nil,
    indices: ParameterClauseSyntax,
    _ unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? = nil,
    result: ReturnClauseSyntax,
    _ unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? = nil,
    accessor: Accessor? = nil,
    _ unexpectedAfterAccessor: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndSubscriptKeyword?.raw,
      subscriptKeyword.raw,
      unexpectedBetweenSubscriptKeywordAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndIndices?.raw,
      indices.raw,
      unexpectedBetweenIndicesAndResult?.raw,
      result.raw,
      unexpectedBetweenResultAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndAccessor?.raw,
      accessor?.raw,
      unexpectedAfterAccessor?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.subscriptDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> SubscriptDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> SubscriptDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndSubscriptKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndSubscriptKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndSubscriptKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndSubscriptKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndSubscriptKeyword(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var subscriptKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSubscriptKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `subscriptKeyword` replaced.
  /// - param newChild: The new `subscriptKeyword` to replace the node's
  ///                   current `subscriptKeyword`, if present.
  public func withSubscriptKeyword(_ newChild: TokenSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.subscriptKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSubscriptKeywordAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSubscriptKeywordAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenSubscriptKeywordAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenSubscriptKeywordAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenSubscriptKeywordAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndIndices(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndIndices` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndIndices` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndIndices`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndIndices(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var indices: ParameterClauseSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return ParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withIndices(value)
    }
  }

  /// Returns a copy of the receiver with its `indices` replaced.
  /// - param newChild: The new `indices` to replace the node's
  ///                   current `indices`, if present.
  public func withIndices(_ newChild: ParameterClauseSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: arena)
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIndicesAndResult(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIndicesAndResult` replaced.
  /// - param newChild: The new `unexpectedBetweenIndicesAndResult` to replace the node's
  ///                   current `unexpectedBetweenIndicesAndResult`, if present.
  public func withUnexpectedBetweenIndicesAndResult(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var result: ReturnClauseSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return ReturnClauseSyntax(childData!)
    }
    set(value) {
      self = withResult(value)
    }
  }

  /// Returns a copy of the receiver with its `result` replaced.
  /// - param newChild: The new `result` to replace the node's
  ///                   current `result`, if present.
  public func withResult(_ newChild: ReturnClauseSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.returnClause, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenResultAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenResultAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenResultAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenResultAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenResultAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndAccessor(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndAccessor` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndAccessor` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndAccessor`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndAccessor(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var accessor: Accessor? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
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
  public func withAccessor(_ newChild: Accessor?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedAfterAccessor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterAccessor(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterAccessor` replaced.
  /// - param newChild: The new `unexpectedAfterAccessor` to replace the node's
  ///                   current `unexpectedAfterAccessor`, if present.
  public func withUnexpectedAfterAccessor(_ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return SubscriptDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndSubscriptKeyword,
      \Self.subscriptKeyword,
      \Self.unexpectedBetweenSubscriptKeywordAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndIndices,
      \Self.indices,
      \Self.unexpectedBetweenIndicesAndResult,
      \Self.result,
      \Self.unexpectedBetweenResultAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndAccessor,
      \Self.accessor,
      \Self.unexpectedAfterAccessor,
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
      return "generic parameter clause"
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
      return "generic where clause"
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

extension SubscriptDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndSubscriptKeyword": unexpectedBetweenModifiersAndSubscriptKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "subscriptKeyword": Syntax(subscriptKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSubscriptKeywordAndGenericParameterClause": unexpectedBetweenSubscriptKeywordAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndIndices": unexpectedBetweenGenericParameterClauseAndIndices.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "indices": Syntax(indices).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIndicesAndResult": unexpectedBetweenIndicesAndResult.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "result": Syntax(result).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenResultAndGenericWhereClause": unexpectedBetweenResultAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndAccessor": unexpectedBetweenGenericWhereClauseAndAccessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessor": accessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterAccessor": unexpectedAfterAccessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImportDeclSyntax

public struct ImportDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .importDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ImportDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .importDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? = nil,
    importTok: TokenSyntax = .importKeyword(),
    _ unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? = nil,
    importKind: TokenSyntax? = nil,
    _ unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? = nil,
    path: AccessPathSyntax,
    _ unexpectedAfterPath: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndImportTok?.raw,
      importTok.raw,
      unexpectedBetweenImportTokAndImportKind?.raw,
      importKind?.raw,
      unexpectedBetweenImportKindAndPath?.raw,
      path.raw,
      unexpectedAfterPath?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.importDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndImportTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndImportTok` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndImportTok` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndImportTok`, if present.
  public func withUnexpectedBetweenModifiersAndImportTok(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var importTok: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withImportTok(value)
    }
  }

  /// Returns a copy of the receiver with its `importTok` replaced.
  /// - param newChild: The new `importTok` to replace the node's
  ///                   current `importTok`, if present.
  public func withImportTok(_ newChild: TokenSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.importKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenImportTokAndImportKind(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenImportTokAndImportKind` replaced.
  /// - param newChild: The new `unexpectedBetweenImportTokAndImportKind` to replace the node's
  ///                   current `unexpectedBetweenImportTokAndImportKind`, if present.
  public func withUnexpectedBetweenImportTokAndImportKind(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var importKind: TokenSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withImportKind(value)
    }
  }

  /// Returns a copy of the receiver with its `importKind` replaced.
  /// - param newChild: The new `importKind` to replace the node's
  ///                   current `importKind`, if present.
  public func withImportKind(_ newChild: TokenSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenImportKindAndPath(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenImportKindAndPath` replaced.
  /// - param newChild: The new `unexpectedBetweenImportKindAndPath` to replace the node's
  ///                   current `unexpectedBetweenImportKindAndPath`, if present.
  public func withUnexpectedBetweenImportKindAndPath(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var path: AccessPathSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return AccessPathSyntax(childData!)
    }
    set(value) {
      self = withPath(value)
    }
  }

  /// Adds the provided `PathComponent` to the node's `path`
  /// collection.
  /// - param element: The new `PathComponent` to add to the node's
  ///                  `path` collection.
  /// - returns: A copy of the receiver with the provided `PathComponent`
  ///            appended to its `path` collection.
  public func addPathComponent(_ element: AccessPathComponentSyntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[9] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.accessPath,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 9, with: collection, arena: arena)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `path` replaced.
  /// - param newChild: The new `path` to replace the node's
  ///                   current `path`, if present.
  public func withPath(_ newChild: AccessPathSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessPath, arena: arena)
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedAfterPath: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterPath(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterPath` replaced.
  /// - param newChild: The new `unexpectedAfterPath` to replace the node's
  ///                   current `unexpectedAfterPath`, if present.
  public func withUnexpectedAfterPath(_ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return ImportDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndImportTok,
      \Self.importTok,
      \Self.unexpectedBetweenImportTokAndImportKind,
      \Self.importKind,
      \Self.unexpectedBetweenImportKindAndPath,
      \Self.path,
      \Self.unexpectedAfterPath,
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

extension ImportDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndImportTok": unexpectedBetweenModifiersAndImportTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "importTok": Syntax(importTok).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenImportTokAndImportKind": unexpectedBetweenImportTokAndImportKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "importKind": importKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenImportKindAndPath": unexpectedBetweenImportKindAndPath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "path": Syntax(path).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterPath": unexpectedAfterPath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorDeclSyntax

public struct AccessorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessorDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AccessorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? = nil,
    modifier: DeclModifierSyntax? = nil,
    _ unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? = nil,
    accessorKind: TokenSyntax,
    _ unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? = nil,
    parameter: AccessorParameterSyntax? = nil,
    _ unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncKeyword: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? = nil,
    throwsKeyword: TokenSyntax? = nil,
    _ unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax? = nil,
    _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifier?.raw,
      modifier?.raw,
      unexpectedBetweenModifierAndAccessorKind?.raw,
      accessorKind.raw,
      unexpectedBetweenAccessorKindAndParameter?.raw,
      parameter?.raw,
      unexpectedBetweenParameterAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsKeyword?.raw,
      throwsKeyword?.raw,
      unexpectedBetweenThrowsKeywordAndBody?.raw,
      body?.raw,
      unexpectedAfterBody?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.accessorDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> AccessorDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributesAndModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributesAndModifier` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributesAndModifier` to replace the node's
  ///                   current `unexpectedBetweenAttributesAndModifier`, if present.
  public func withUnexpectedBetweenAttributesAndModifier(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var modifier: DeclModifierSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      if childData == nil { return nil }
      return DeclModifierSyntax(childData!)
    }
    set(value) {
      self = withModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `modifier` replaced.
  /// - param newChild: The new `modifier` to replace the node's
  ///                   current `modifier`, if present.
  public func withModifier(_ newChild: DeclModifierSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifierAndAccessorKind(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifierAndAccessorKind` replaced.
  /// - param newChild: The new `unexpectedBetweenModifierAndAccessorKind` to replace the node's
  ///                   current `unexpectedBetweenModifierAndAccessorKind`, if present.
  public func withUnexpectedBetweenModifierAndAccessorKind(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var accessorKind: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAccessorKind(value)
    }
  }

  /// Returns a copy of the receiver with its `accessorKind` replaced.
  /// - param newChild: The new `accessorKind` to replace the node's
  ///                   current `accessorKind`, if present.
  public func withAccessorKind(_ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAccessorKindAndParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAccessorKindAndParameter` replaced.
  /// - param newChild: The new `unexpectedBetweenAccessorKindAndParameter` to replace the node's
  ///                   current `unexpectedBetweenAccessorKindAndParameter`, if present.
  public func withUnexpectedBetweenAccessorKindAndParameter(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var parameter: AccessorParameterSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      if childData == nil { return nil }
      return AccessorParameterSyntax(childData!)
    }
    set(value) {
      self = withParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `parameter` replaced.
  /// - param newChild: The new `parameter` to replace the node's
  ///                   current `parameter`, if present.
  public func withParameter(_ newChild: AccessorParameterSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenParameterAndAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenParameterAndAsyncKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenParameterAndAsyncKeyword` to replace the node's
  ///                   current `unexpectedBetweenParameterAndAsyncKeyword`, if present.
  public func withUnexpectedBetweenParameterAndAsyncKeyword(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var asyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
  public func withAsyncKeyword(_ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsyncKeywordAndThrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsyncKeywordAndThrowsKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenAsyncKeywordAndThrowsKeyword` to replace the node's
  ///                   current `unexpectedBetweenAsyncKeywordAndThrowsKeyword`, if present.
  public func withUnexpectedBetweenAsyncKeywordAndThrowsKeyword(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var throwsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withThrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `throwsKeyword` replaced.
  /// - param newChild: The new `throwsKeyword` to replace the node's
  ///                   current `throwsKeyword`, if present.
  public func withThrowsKeyword(_ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenThrowsKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenThrowsKeywordAndBody` replaced.
  /// - param newChild: The new `unexpectedBetweenThrowsKeywordAndBody` to replace the node's
  ///                   current `unexpectedBetweenThrowsKeywordAndBody`, if present.
  public func withUnexpectedBetweenThrowsKeywordAndBody(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(_ newChild: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedAfterBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
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
  public func withUnexpectedAfterBody(_ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return AccessorDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifier,
      \Self.modifier,
      \Self.unexpectedBetweenModifierAndAccessorKind,
      \Self.accessorKind,
      \Self.unexpectedBetweenAccessorKindAndParameter,
      \Self.parameter,
      \Self.unexpectedBetweenParameterAndAsyncKeyword,
      \Self.asyncKeyword,
      \Self.unexpectedBetweenAsyncKeywordAndThrowsKeyword,
      \Self.throwsKeyword,
      \Self.unexpectedBetweenThrowsKeywordAndBody,
      \Self.body,
      \Self.unexpectedAfterBody,
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
      return "parameter"
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

extension AccessorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifier": unexpectedBetweenAttributesAndModifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifier": modifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifierAndAccessorKind": unexpectedBetweenModifierAndAccessorKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessorKind": Syntax(accessorKind).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAccessorKindAndParameter": unexpectedBetweenAccessorKindAndParameter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "parameter": parameter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenParameterAndAsyncKeyword": unexpectedBetweenParameterAndAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncKeywordAndThrowsKeyword": unexpectedBetweenAsyncKeywordAndThrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsKeyword": throwsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenThrowsKeywordAndBody": unexpectedBetweenThrowsKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterBody": unexpectedAfterBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - VariableDeclSyntax

public struct VariableDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .variableDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `VariableDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .variableDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? = nil,
    bindings: PatternBindingListSyntax,
    _ unexpectedAfterBindings: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndBindings?.raw,
      bindings.raw,
      unexpectedAfterBindings?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.variableDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndLetOrVarKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndLetOrVarKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndLetOrVarKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndLetOrVarKeyword(_ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `letOrVarKeyword` replaced.
  /// - param newChild: The new `letOrVarKeyword` to replace the node's
  ///                   current `letOrVarKeyword`, if present.
  public func withLetOrVarKeyword(_ newChild: TokenSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public var unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLetOrVarKeywordAndBindings(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLetOrVarKeywordAndBindings` replaced.
  /// - param newChild: The new `unexpectedBetweenLetOrVarKeywordAndBindings` to replace the node's
  ///                   current `unexpectedBetweenLetOrVarKeywordAndBindings`, if present.
  public func withUnexpectedBetweenLetOrVarKeywordAndBindings(_ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public var bindings: PatternBindingListSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return PatternBindingListSyntax(childData!)
    }
    set(value) {
      self = withBindings(value)
    }
  }

  /// Adds the provided `Binding` to the node's `bindings`
  /// collection.
  /// - param element: The new `Binding` to add to the node's
  ///                  `bindings` collection.
  /// - returns: A copy of the receiver with the provided `Binding`
  ///            appended to its `bindings` collection.
  public func addBinding(_ element: PatternBindingSyntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[7] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.patternBindingList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 7, with: collection, arena: arena)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `bindings` replaced.
  /// - param newChild: The new `bindings` to replace the node's
  ///                   current `bindings`, if present.
  public func withBindings(_ newChild: PatternBindingListSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.patternBindingList, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public var unexpectedAfterBindings: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterBindings(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterBindings` replaced.
  /// - param newChild: The new `unexpectedAfterBindings` to replace the node's
  ///                   current `unexpectedAfterBindings`, if present.
  public func withUnexpectedAfterBindings(_ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return VariableDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndLetOrVarKeyword,
      \Self.letOrVarKeyword,
      \Self.unexpectedBetweenLetOrVarKeywordAndBindings,
      \Self.bindings,
      \Self.unexpectedAfterBindings,
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
      return nil
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension VariableDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndLetOrVarKeyword": unexpectedBetweenModifiersAndLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLetOrVarKeywordAndBindings": unexpectedBetweenLetOrVarKeywordAndBindings.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "bindings": Syntax(bindings).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterBindings": unexpectedAfterBindings.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - EnumCaseDeclSyntax

/// 
/// A `case` declaration of a Swift `enum`. It can have 1 or more
/// `EnumCaseElement`s inside, each declaring a different case of the
/// enum.
/// 
public struct EnumCaseDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .enumCaseDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `EnumCaseDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCaseDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax = .caseKeyword(),
    _ unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? = nil,
    elements: EnumCaseElementListSyntax,
    _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndElements?.raw,
      elements.raw,
      unexpectedAfterElements?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.enumCaseDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the case declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the case declaration.
  /// 
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
  public func addModifier(_ element: DeclModifierSyntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndCaseKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndCaseKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndCaseKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndCaseKeyword(_ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// The `case` keyword for this case.
  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(_ newChild: TokenSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  public var unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaseKeywordAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaseKeywordAndElements` replaced.
  /// - param newChild: The new `unexpectedBetweenCaseKeywordAndElements` to replace the node's
  ///                   current `unexpectedBetweenCaseKeywordAndElements`, if present.
  public func withUnexpectedBetweenCaseKeywordAndElements(_ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// The elements this case declares.
  public var elements: EnumCaseElementListSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return EnumCaseElementListSyntax(childData!)
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
  public func addElement(_ element: EnumCaseElementSyntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[7] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 7, with: collection, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(_ newChild: EnumCaseElementListSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.enumCaseElementList, arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  public var unexpectedAfterElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
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
  public func withUnexpectedAfterElements(_ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return EnumCaseDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndCaseKeyword,
      \Self.caseKeyword,
      \Self.unexpectedBetweenCaseKeywordAndElements,
      \Self.elements,
      \Self.unexpectedAfterElements,
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
      return "elements"
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension EnumCaseDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndCaseKeyword": unexpectedBetweenModifiersAndCaseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCaseKeywordAndElements": unexpectedBetweenCaseKeywordAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterElements": unexpectedAfterElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - EnumDeclSyntax

/// A Swift `enum` declaration.
public struct EnumDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .enumDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `EnumDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? = nil,
    enumKeyword: TokenSyntax = .enumKeyword(),
    _ unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax,
    _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndEnumKeyword?.raw,
      enumKeyword.raw,
      unexpectedBetweenEnumKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameters?.raw,
      genericParameters?.raw,
      unexpectedBetweenGenericParametersAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
      unexpectedAfterMembers?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.enumDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the enum declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> EnumDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the enum declaration.
  /// 
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
  public func addModifier(_ element: DeclModifierSyntax) -> EnumDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndEnumKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndEnumKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndEnumKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndEnumKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndEnumKeyword(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The `enum` keyword for this declaration.
  /// 
  public var enumKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withEnumKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `enumKeyword` replaced.
  /// - param newChild: The new `enumKeyword` to replace the node's
  ///                   current `enumKeyword`, if present.
  public func withEnumKeyword(_ newChild: TokenSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.enumKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenEnumKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenEnumKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenEnumKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenEnumKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenEnumKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The name of this enum.
  /// 
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameters` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameters` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameters`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameters(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The generic parameters, if any, for this enum.
  /// 
  public var genericParameters: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameters` replaced.
  /// - param newChild: The new `genericParameters` to replace the node's
  ///                   current `genericParameters`, if present.
  public func withGenericParameters(_ newChild: GenericParameterClauseSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParametersAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParametersAndInheritanceClause` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParametersAndInheritanceClause` to replace the node's
  ///                   current `unexpectedBetweenGenericParametersAndInheritanceClause`, if present.
  public func withUnexpectedBetweenGenericParametersAndInheritanceClause(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The inheritance clause describing conformances or raw
  /// values for this enum.
  /// 
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInheritanceClauseSyntax(childData!)
    }
    set(value) {
      self = withInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(_ newChild: TypeInheritanceClauseSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The `where` clause that applies to the generic parameters of
  /// this enum.
  /// 
  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `unexpectedBetweenGenericWhereClauseAndMembers`, if present.
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The cases and other members of this enum.
  /// 
  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(_ newChild: MemberDeclBlockSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena)
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedAfterMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterMembers` replaced.
  /// - param newChild: The new `unexpectedAfterMembers` to replace the node's
  ///                   current `unexpectedAfterMembers`, if present.
  public func withUnexpectedAfterMembers(_ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return EnumDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndEnumKeyword,
      \Self.enumKeyword,
      \Self.unexpectedBetweenEnumKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameters,
      \Self.genericParameters,
      \Self.unexpectedBetweenGenericParametersAndInheritanceClause,
      \Self.inheritanceClause,
      \Self.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedBetweenGenericWhereClauseAndMembers,
      \Self.members,
      \Self.unexpectedAfterMembers,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "inheritance clause"
    case 12:
      return nil
    case 13:
      return "generic where clause"
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

extension EnumDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndEnumKeyword": unexpectedBetweenModifiersAndEnumKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "enumKeyword": Syntax(enumKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenEnumKeywordAndIdentifier": unexpectedBetweenEnumKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameters": unexpectedBetweenIdentifierAndGenericParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameters": genericParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParametersAndInheritanceClause": unexpectedBetweenGenericParametersAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenInheritanceClauseAndGenericWhereClause": unexpectedBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericWhereClauseAndMembers": unexpectedBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterMembers": unexpectedAfterMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OperatorDeclSyntax

/// A Swift `operator` declaration.
public struct OperatorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .operatorDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OperatorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .operatorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? = nil,
    operatorKeyword: TokenSyntax = .operatorKeyword(),
    _ unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? = nil,
    _ unexpectedAfterOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndOperatorKeyword?.raw,
      operatorKeyword.raw,
      unexpectedBetweenOperatorKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw,
      operatorPrecedenceAndTypes?.raw,
      unexpectedAfterOperatorPrecedenceAndTypes?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.operatorDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the 'operator' declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> OperatorDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the 'operator'
  /// declaration.
  /// 
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
  public func addModifier(_ element: DeclModifierSyntax) -> OperatorDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndOperatorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndOperatorKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndOperatorKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndOperatorKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndOperatorKeyword(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var operatorKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOperatorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorKeyword` replaced.
  /// - param newChild: The new `operatorKeyword` to replace the node's
  ///                   current `operatorKeyword`, if present.
  public func withOperatorKeyword(_ newChild: TokenSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.operatorKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOperatorKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOperatorKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenOperatorKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenOperatorKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenOperatorKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unspacedBinaryOperator(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes`, if present.
  public func withUnexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// Optionally specify a precedence group and designated types.
  /// 
  public var operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return OperatorPrecedenceAndTypesSyntax(childData!)
    }
    set(value) {
      self = withOperatorPrecedenceAndTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorPrecedenceAndTypes` replaced.
  /// - param newChild: The new `operatorPrecedenceAndTypes` to replace the node's
  ///                   current `operatorPrecedenceAndTypes`, if present.
  public func withOperatorPrecedenceAndTypes(_ newChild: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedAfterOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterOperatorPrecedenceAndTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterOperatorPrecedenceAndTypes` replaced.
  /// - param newChild: The new `unexpectedAfterOperatorPrecedenceAndTypes` to replace the node's
  ///                   current `unexpectedAfterOperatorPrecedenceAndTypes`, if present.
  public func withUnexpectedAfterOperatorPrecedenceAndTypes(_ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return OperatorDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndOperatorKeyword,
      \Self.operatorKeyword,
      \Self.unexpectedBetweenOperatorKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes,
      \Self.operatorPrecedenceAndTypes,
      \Self.unexpectedAfterOperatorPrecedenceAndTypes,
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

extension OperatorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndOperatorKeyword": unexpectedBetweenModifiersAndOperatorKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorKeyword": Syntax(operatorKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenOperatorKeywordAndIdentifier": unexpectedBetweenOperatorKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes": unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorPrecedenceAndTypes": operatorPrecedenceAndTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterOperatorPrecedenceAndTypes": unexpectedAfterOperatorPrecedenceAndTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupDeclSyntax

/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `PrecedenceGroupDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? = nil,
    precedencegroupKeyword: TokenSyntax = .precedencegroupKeyword(),
    _ unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax = .leftBraceToken(),
    _ unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? = nil,
    groupAttributes: PrecedenceGroupAttributeListSyntax,
    _ unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax = .rightBraceToken(),
    _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndPrecedencegroupKeyword?.raw,
      precedencegroupKeyword.raw,
      unexpectedBetweenPrecedencegroupKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndGroupAttributes?.raw,
      groupAttributes.raw,
      unexpectedBetweenGroupAttributesAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.precedenceGroupDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the 'precedencegroup' declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the 'precedencegroup'
  /// declaration.
  /// 
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
  public func addModifier(_ element: DeclModifierSyntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndPrecedencegroupKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndPrecedencegroupKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndPrecedencegroupKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndPrecedencegroupKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndPrecedencegroupKeyword(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var precedencegroupKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPrecedencegroupKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `precedencegroupKeyword` replaced.
  /// - param newChild: The new `precedencegroupKeyword` to replace the node's
  ///                   current `precedencegroupKeyword`, if present.
  public func withPrecedencegroupKeyword(_ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.precedencegroupKeyword, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPrecedencegroupKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPrecedencegroupKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenPrecedencegroupKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenPrecedencegroupKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenPrecedencegroupKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The name of this precedence group.
  /// 
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndLeftBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndLeftBrace` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndLeftBrace`, if present.
  public func withUnexpectedBetweenIdentifierAndLeftBrace(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(_ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena)
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBraceAndGroupAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBraceAndGroupAttributes` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBraceAndGroupAttributes` to replace the node's
  ///                   current `unexpectedBetweenLeftBraceAndGroupAttributes`, if present.
  public func withUnexpectedBetweenLeftBraceAndGroupAttributes(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The characteristics of this precedence group.
  /// 
  public var groupAttributes: PrecedenceGroupAttributeListSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return PrecedenceGroupAttributeListSyntax(childData!)
    }
    set(value) {
      self = withGroupAttributes(value)
    }
  }

  /// Adds the provided `GroupAttribute` to the node's `groupAttributes`
  /// collection.
  /// - param element: The new `GroupAttribute` to add to the node's
  ///                  `groupAttributes` collection.
  /// - returns: A copy of the receiver with the provided `GroupAttribute`
  ///            appended to its `groupAttributes` collection.
  public func addGroupAttribute(_ element: Syntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[11] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAttributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 11, with: collection, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `groupAttributes` replaced.
  /// - param newChild: The new `groupAttributes` to replace the node's
  ///                   current `groupAttributes`, if present.
  public func withGroupAttributes(_ newChild: PrecedenceGroupAttributeListSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupAttributeList, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGroupAttributesAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGroupAttributesAndRightBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenGroupAttributesAndRightBrace` to replace the node's
  ///                   current `unexpectedBetweenGroupAttributesAndRightBrace`, if present.
  public func withUnexpectedBetweenGroupAttributesAndRightBrace(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(_ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena)
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedAfterRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
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
  public func withUnexpectedAfterRightBrace(_ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndPrecedencegroupKeyword,
      \Self.precedencegroupKeyword,
      \Self.unexpectedBetweenPrecedencegroupKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndLeftBrace,
      \Self.leftBrace,
      \Self.unexpectedBetweenLeftBraceAndGroupAttributes,
      \Self.groupAttributes,
      \Self.unexpectedBetweenGroupAttributesAndRightBrace,
      \Self.rightBrace,
      \Self.unexpectedAfterRightBrace,
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

extension PrecedenceGroupDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndPrecedencegroupKeyword": unexpectedBetweenModifiersAndPrecedencegroupKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "precedencegroupKeyword": Syntax(precedencegroupKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPrecedencegroupKeywordAndIdentifier": unexpectedBetweenPrecedencegroupKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndLeftBrace": unexpectedBetweenIdentifierAndLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBraceAndGroupAttributes": unexpectedBetweenLeftBraceAndGroupAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "groupAttributes": Syntax(groupAttributes).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenGroupAttributesAndRightBrace": unexpectedBetweenGroupAttributesAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightBrace": unexpectedAfterRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MacroDeclSyntax

public struct MacroDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public enum Signature: SyntaxChildChoices {
    case `functionLike`(FunctionSignatureSyntax)
    case `valueLike`(TypeAnnotationSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .functionLike(let node): return node._syntaxNode
      case .valueLike(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: FunctionSignatureSyntax) {
      self = .functionLike(node)
    }
    public init(_ node: TypeAnnotationSyntax) {
      self = .valueLike(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(FunctionSignatureSyntax.self) {
        self = .functionLike(node)
        return
      }
      if let node = node.as(TypeAnnotationSyntax.self) {
        self = .valueLike(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(FunctionSignatureSyntax.self),
        .node(TypeAnnotationSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .macroDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MacroDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .macroDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndMacroKeyword: UnexpectedNodesSyntax? = nil,
    macroKeyword: TokenSyntax = .contextualKeyword("macro"),
    _ unexpectedBetweenMacroKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil,
    signature: Signature,
    _ unexpectedBetweenSignatureAndDefinition: UnexpectedNodesSyntax? = nil,
    definition: InitializerClauseSyntax? = nil,
    _ unexpectedBetweenDefinitionAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndMacroKeyword?.raw,
      macroKeyword.raw,
      unexpectedBetweenMacroKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndDefinition?.raw,
      definition?.raw,
      unexpectedBetweenDefinitionAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedAfterGenericWhereClause?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.macroDecl, from: layout, arena: arena,
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
      self = withUnexpectedBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAttributes` replaced.
  /// - param newChild: The new `unexpectedBeforeAttributes` to replace the node's
  ///                   current `unexpectedBeforeAttributes`, if present.
  public func withUnexpectedBeforeAttributes(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> MacroDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 1, with: collection, arena: arena)
    return MacroDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(_ newChild: AttributeListSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
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
  public func withUnexpectedBetweenAttributesAndModifiers(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
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
  public func addModifier(_ element: DeclModifierSyntax) -> MacroDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return MacroDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(_ newChild: ModifierListSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndMacroKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenModifiersAndMacroKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenModifiersAndMacroKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenModifiersAndMacroKeyword` to replace the node's
  ///                   current `unexpectedBetweenModifiersAndMacroKeyword`, if present.
  public func withUnexpectedBetweenModifiersAndMacroKeyword(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var macroKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withMacroKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `macroKeyword` replaced.
  /// - param newChild: The new `macroKeyword` to replace the node's
  ///                   current `macroKeyword`, if present.
  public func withMacroKeyword(_ newChild: TokenSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenMacroKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMacroKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMacroKeywordAndIdentifier` replaced.
  /// - param newChild: The new `unexpectedBetweenMacroKeywordAndIdentifier` to replace the node's
  ///                   current `unexpectedBetweenMacroKeywordAndIdentifier`, if present.
  public func withUnexpectedBetweenMacroKeywordAndIdentifier(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericParameterClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericParameterClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(_ newChild: GenericParameterClauseSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParameterClauseAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParameterClauseAndSignature` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParameterClauseAndSignature` to replace the node's
  ///                   current `unexpectedBetweenGenericParameterClauseAndSignature`, if present.
  public func withUnexpectedBetweenGenericParameterClauseAndSignature(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var signature: Signature {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
      return Signature(childData!)
    }
    set(value) {
      self = withSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(_ newChild: Signature?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena)
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenSignatureAndDefinition: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSignatureAndDefinition(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSignatureAndDefinition` replaced.
  /// - param newChild: The new `unexpectedBetweenSignatureAndDefinition` to replace the node's
  ///                   current `unexpectedBetweenSignatureAndDefinition`, if present.
  public func withUnexpectedBetweenSignatureAndDefinition(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var definition: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
    }
    set(value) {
      self = withDefinition(value)
    }
  }

  /// Returns a copy of the receiver with its `definition` replaced.
  /// - param newChild: The new `definition` to replace the node's
  ///                   current `definition`, if present.
  public func withDefinition(_ newChild: InitializerClauseSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedBetweenDefinitionAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDefinitionAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDefinitionAndGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedBetweenDefinitionAndGenericWhereClause` to replace the node's
  ///                   current `unexpectedBetweenDefinitionAndGenericWhereClause`, if present.
  public func withUnexpectedBetweenDefinitionAndGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
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
  public func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public var unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterGenericWhereClause` replaced.
  /// - param newChild: The new `unexpectedAfterGenericWhereClause` to replace the node's
  ///                   current `unexpectedAfterGenericWhereClause`, if present.
  public func withUnexpectedAfterGenericWhereClause(_ newChild: UnexpectedNodesSyntax?) -> MacroDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return MacroDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndModifiers,
      \Self.modifiers,
      \Self.unexpectedBetweenModifiersAndMacroKeyword,
      \Self.macroKeyword,
      \Self.unexpectedBetweenMacroKeywordAndIdentifier,
      \Self.identifier,
      \Self.unexpectedBetweenIdentifierAndGenericParameterClause,
      \Self.genericParameterClause,
      \Self.unexpectedBetweenGenericParameterClauseAndSignature,
      \Self.signature,
      \Self.unexpectedBetweenSignatureAndDefinition,
      \Self.definition,
      \Self.unexpectedBetweenDefinitionAndGenericWhereClause,
      \Self.genericWhereClause,
      \Self.unexpectedAfterGenericWhereClause,
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
      return nil
    case 8:
      return nil
    case 9:
      return "generic parameter clause"
    case 10:
      return nil
    case 11:
      return "macro signature"
    case 12:
      return nil
    case 13:
      return "macro definition"
    case 14:
      return nil
    case 15:
      return "generic where clause"
    case 16:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MacroDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenModifiersAndMacroKeyword": unexpectedBetweenModifiersAndMacroKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "macroKeyword": Syntax(macroKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMacroKeywordAndIdentifier": unexpectedBetweenMacroKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericParameterClause": unexpectedBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericParameterClauseAndSignature": unexpectedBetweenGenericParameterClauseAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": Syntax(signature).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSignatureAndDefinition": unexpectedBetweenSignatureAndDefinition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "definition": definition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenDefinitionAndGenericWhereClause": unexpectedBetweenDefinitionAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericWhereClause": unexpectedAfterGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MacroExpansionDeclSyntax

public struct MacroExpansionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .macroExpansionDecl else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MacroExpansionDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .macroExpansionDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePoundToken: UnexpectedNodesSyntax? = nil,
    poundToken: TokenSyntax = .poundToken(),
    _ unexpectedBetweenPoundTokenAndMacro: UnexpectedNodesSyntax? = nil,
    macro: TokenSyntax,
    _ unexpectedBetweenMacroAndGenericArguments: UnexpectedNodesSyntax? = nil,
    genericArguments: GenericArgumentClauseSyntax? = nil,
    _ unexpectedBetweenGenericArgumentsAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? = nil,
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundToken?.raw,
      poundToken.raw,
      unexpectedBetweenPoundTokenAndMacro?.raw,
      macro.raw,
      unexpectedBetweenMacroAndGenericArguments?.raw,
      genericArguments?.raw,
      unexpectedBetweenGenericArgumentsAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
      unexpectedAfterAdditionalTrailingClosures?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.macroExpansionDecl, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePoundToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundToken` replaced.
  /// - param newChild: The new `unexpectedBeforePoundToken` to replace the node's
  ///                   current `unexpectedBeforePoundToken`, if present.
  public func withUnexpectedBeforePoundToken(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  /// The `#` sign.
  public var poundToken: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundToken(value)
    }
  }

  /// Returns a copy of the receiver with its `poundToken` replaced.
  /// - param newChild: The new `poundToken` to replace the node's
  ///                   current `poundToken`, if present.
  public func withPoundToken(_ newChild: TokenSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.pound, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenPoundTokenAndMacro: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundTokenAndMacro(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundTokenAndMacro` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundTokenAndMacro` to replace the node's
  ///                   current `unexpectedBetweenPoundTokenAndMacro`, if present.
  public func withUnexpectedBetweenPoundTokenAndMacro(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var macro: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withMacro(value)
    }
  }

  /// Returns a copy of the receiver with its `macro` replaced.
  /// - param newChild: The new `macro` to replace the node's
  ///                   current `macro`, if present.
  public func withMacro(_ newChild: TokenSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenMacroAndGenericArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMacroAndGenericArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMacroAndGenericArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenMacroAndGenericArguments` to replace the node's
  ///                   current `unexpectedBetweenMacroAndGenericArguments`, if present.
  public func withUnexpectedBetweenMacroAndGenericArguments(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var genericArguments: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      if childData == nil { return nil }
      return GenericArgumentClauseSyntax(childData!)
    }
    set(value) {
      self = withGenericArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `genericArguments` replaced.
  /// - param newChild: The new `genericArguments` to replace the node's
  ///                   current `genericArguments`, if present.
  public func withGenericArguments(_ newChild: GenericArgumentClauseSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericArgumentsAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericArgumentsAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericArgumentsAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericArgumentsAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenGenericArgumentsAndLeftParen`, if present.
  public func withUnexpectedBetweenGenericArgumentsAndLeftParen(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftParenAndArgumentList(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
  public func addArgument(_ element: TupleExprElementSyntax) -> MacroExpansionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[9] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 9, with: collection, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(_ newChild: TupleExprElementListSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena)
    let newData = data.replacingChild(at: 9, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
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
  public func withUnexpectedBetweenArgumentListAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 10, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
  public func withRightParen(_ newChild: TokenSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 11, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRightParenAndTrailingClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRightParenAndTrailingClosure` replaced.
  /// - param newChild: The new `unexpectedBetweenRightParenAndTrailingClosure` to replace the node's
  ///                   current `unexpectedBetweenRightParenAndTrailingClosure`, if present.
  public func withUnexpectedBetweenRightParenAndTrailingClosure(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 12, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var trailingClosure: ClosureExprSyntax? {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureExprSyntax(childData!)
    }
    set(value) {
      self = withTrailingClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingClosure` replaced.
  /// - param newChild: The new `trailingClosure` to replace the node's
  ///                   current `trailingClosure`, if present.
  public func withTrailingClosure(_ newChild: ClosureExprSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 13, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTrailingClosureAndAdditionalTrailingClosures(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures` replaced.
  /// - param newChild: The new `unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures` to replace the node's
  ///                   current `unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures`, if present.
  public func withUnexpectedBetweenTrailingClosureAndAdditionalTrailingClosures(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 14, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? {
    get {
      let childData = data.child(at: 15, parent: Syntax(self))
      if childData == nil { return nil }
      return MultipleTrailingClosureElementListSyntax(childData!)
    }
    set(value) {
      self = withAdditionalTrailingClosures(value)
    }
  }

  /// Adds the provided `AdditionalTrailingClosure` to the node's `additionalTrailingClosures`
  /// collection.
  /// - param element: The new `AdditionalTrailingClosure` to add to the node's
  ///                  `additionalTrailingClosures` collection.
  /// - returns: A copy of the receiver with the provided `AdditionalTrailingClosure`
  ///            appended to its `additionalTrailingClosures` collection.
  public func addAdditionalTrailingClosure(_ element: MultipleTrailingClosureElementSyntax) -> MacroExpansionDeclSyntax {
    var collection: RawSyntax
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[15] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 15, with: collection, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `additionalTrailingClosures` replaced.
  /// - param newChild: The new `additionalTrailingClosures` to replace the node's
  ///                   current `additionalTrailingClosures`, if present.
  public func withAdditionalTrailingClosures(_ newChild: MultipleTrailingClosureElementListSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 15, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public var unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 16, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterAdditionalTrailingClosures(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterAdditionalTrailingClosures` replaced.
  /// - param newChild: The new `unexpectedAfterAdditionalTrailingClosures` to replace the node's
  ///                   current `unexpectedAfterAdditionalTrailingClosures`, if present.
  public func withUnexpectedAfterAdditionalTrailingClosures(_ newChild: UnexpectedNodesSyntax?) -> MacroExpansionDeclSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 16, with: raw, arena: arena)
    return MacroExpansionDeclSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePoundToken,
      \Self.poundToken,
      \Self.unexpectedBetweenPoundTokenAndMacro,
      \Self.macro,
      \Self.unexpectedBetweenMacroAndGenericArguments,
      \Self.genericArguments,
      \Self.unexpectedBetweenGenericArgumentsAndLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArgumentList,
      \Self.argumentList,
      \Self.unexpectedBetweenArgumentListAndRightParen,
      \Self.rightParen,
      \Self.unexpectedBetweenRightParenAndTrailingClosure,
      \Self.trailingClosure,
      \Self.unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      \Self.additionalTrailingClosures,
      \Self.unexpectedAfterAdditionalTrailingClosures,
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
    case 15:
      return nil
    case 16:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MacroExpansionDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundToken": unexpectedBeforePoundToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundToken": Syntax(poundToken).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundTokenAndMacro": unexpectedBetweenPoundTokenAndMacro.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "macro": Syntax(macro).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMacroAndGenericArguments": unexpectedBetweenMacroAndGenericArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArguments": genericArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenGenericArgumentsAndLeftParen": unexpectedBetweenGenericArgumentsAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndArgumentList": unexpectedBetweenLeftParenAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentListAndRightParen": unexpectedBetweenArgumentListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenRightParenAndTrailingClosure": unexpectedBetweenRightParenAndTrailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures": unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterAdditionalTrailingClosures": unexpectedAfterAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

