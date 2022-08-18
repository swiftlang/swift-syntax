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


// MARK: - UnknownDeclSyntax

public struct UnknownDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnknownDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknownDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnknownDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknownDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unknownDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }
}

extension UnknownDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - MissingDeclSyntax

public struct MissingDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missingDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.missingDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return MissingDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> MissingDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return MissingDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return MissingDeclSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return MissingDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return MissingDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return MissingDeclSyntax(newData)
  }
}

extension MissingDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAttributes": unexpectedBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndModifiers": unexpectedBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypealiasDeclSyntax

public struct TypealiasDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndTypealiasKeyword
    case typealiasKeyword
    case unexpectedBetweenTypealiasKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndInitializer
    case initializer
    case unexpectedBetweenInitializerAndGenericWhereClause
    case genericWhereClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TypealiasDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .typealiasDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TypealiasDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typealiasDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? = nil,
    typealiasKeyword: TokenSyntax,
    _ unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax,
    _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typealiasDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return TypealiasDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> TypealiasDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return TypealiasDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndTypealiasKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndTypealiasKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndTypealiasKeyword)
    return TypealiasDeclSyntax(newData)
  }

  public var typealiasKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.typealiasKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.typealiasKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.typealiasKeyword)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenTypealiasKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenTypealiasKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenTypealiasKeywordAndIdentifier)
    return TypealiasDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause)
    return TypealiasDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndInitializer,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndInitializer)
    return TypealiasDeclSyntax(newData)
  }

  public var initializer: TypeInitializerClauseSyntax {
    get {
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
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
    _ newChild: TypeInitializerClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.typeInitializerClause, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return TypealiasDeclSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInitializerAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInitializerAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInitializerAndGenericWhereClause)
    return TypealiasDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return TypealiasDeclSyntax(newData)
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
    ])
  }
}

// MARK: - AssociatedtypeDeclSyntax

public struct AssociatedtypeDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndAssociatedtypeKeyword
    case associatedtypeKeyword
    case unexpectedBetweenAssociatedtypeKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndInitializer
    case initializer
    case unexpectedBetweenInitializerAndGenericWhereClause
    case genericWhereClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AssociatedtypeDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .associatedtypeDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AssociatedtypeDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .associatedtypeDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? = nil,
    associatedtypeKeyword: TokenSyntax,
    _ unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.associatedtypeDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return AssociatedtypeDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> AssociatedtypeDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndAssociatedtypeKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndAssociatedtypeKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndAssociatedtypeKeyword)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var associatedtypeKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.associatedtypeKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.associatedtypeKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.associatedtypeKeyword)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAssociatedtypeKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenAssociatedtypeKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAssociatedtypeKeywordAndIdentifier)
    return AssociatedtypeDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndInheritanceClause)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndInitializer,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndInitializer(
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndInitializer)
    return AssociatedtypeDeclSyntax(newData)
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
    _ newChild: TypeInitializerClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInitializerAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInitializerAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInitializerAndGenericWhereClause)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return AssociatedtypeDeclSyntax(newData)
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
    ])
  }
}

// MARK: - IfConfigDeclSyntax

public struct IfConfigDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeClauses
    case clauses
    case unexpectedBetweenClausesAndPoundEndif
    case poundEndif
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IfConfigDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .ifConfigDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IfConfigDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifConfigDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeClauses: UnexpectedNodesSyntax? = nil,
    clauses: IfConfigClauseListSyntax,
    _ unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? = nil,
    poundEndif: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClauses?.raw,
      clauses.raw,
      unexpectedBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeClauses: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeClauses,
                                 parent: Syntax(self))
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
  public func withUnexpectedBeforeClauses(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeClauses)
    return IfConfigDeclSyntax(newData)
  }

  public var clauses: IfConfigClauseListSyntax {
    get {
      let childData = data.child(at: Cursor.clauses,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.clauses] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClauseList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigClauseList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.clauses)
    return IfConfigDeclSyntax(newData)
  }

  public var unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenClausesAndPoundEndif,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenClausesAndPoundEndif(
    _ newChild: UnexpectedNodesSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenClausesAndPoundEndif)
    return IfConfigDeclSyntax(newData)
  }

  public var poundEndif: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundEndif,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundEndifKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundEndif)
    return IfConfigDeclSyntax(newData)
  }
}

extension IfConfigDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeClauses": unexpectedBeforeClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "clauses": Syntax(clauses).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenClausesAndPoundEndif": unexpectedBetweenClausesAndPoundEndif.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundEndif": Syntax(poundEndif).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundErrorDeclSyntax

public struct PoundErrorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundError
    case poundError
    case unexpectedBetweenPoundErrorAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndMessage
    case message
    case unexpectedBetweenMessageAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundErrorDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundErrorDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundErrorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundErrorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforePoundError: UnexpectedNodesSyntax? = nil,
    poundError: TokenSyntax,
    _ unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundErrorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundError: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundError,
                                 parent: Syntax(self))
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
  public func withUnexpectedBeforePoundError(
    _ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundError)
    return PoundErrorDeclSyntax(newData)
  }

  public var poundError: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundError,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundErrorKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundError)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPoundErrorAndLeftParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenPoundErrorAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPoundErrorAndLeftParen)
    return PoundErrorDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndMessage,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftParenAndMessage(
    _ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndMessage)
    return PoundErrorDeclSyntax(newData)
  }

  public var message: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: Cursor.message,
                                 parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundErrorDeclSyntax(newData)
  }

  public var unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenMessageAndRightParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenMessageAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenMessageAndRightParen)
    return PoundErrorDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundErrorDeclSyntax(newData)
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
    ])
  }
}

// MARK: - PoundWarningDeclSyntax

public struct PoundWarningDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundWarning
    case poundWarning
    case unexpectedBetweenPoundWarningAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndMessage
    case message
    case unexpectedBetweenMessageAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundWarningDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundWarningDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundWarningDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundWarningDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforePoundWarning: UnexpectedNodesSyntax? = nil,
    poundWarning: TokenSyntax,
    _ unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundWarningDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundWarning: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundWarning,
                                 parent: Syntax(self))
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
  public func withUnexpectedBeforePoundWarning(
    _ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundWarning)
    return PoundWarningDeclSyntax(newData)
  }

  public var poundWarning: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundWarning,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundWarningKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundWarning)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPoundWarningAndLeftParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenPoundWarningAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPoundWarningAndLeftParen)
    return PoundWarningDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndMessage,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftParenAndMessage(
    _ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndMessage)
    return PoundWarningDeclSyntax(newData)
  }

  public var message: StringLiteralExprSyntax {
    get {
      let childData = data.child(at: Cursor.message,
                                 parent: Syntax(self))
      return StringLiteralExprSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundWarningDeclSyntax(newData)
  }

  public var unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenMessageAndRightParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenMessageAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenMessageAndRightParen)
    return PoundWarningDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundWarningDeclSyntax(newData)
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
    ])
  }
}

// MARK: - PoundSourceLocationSyntax

public struct PoundSourceLocationSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundSourceLocation
    case poundSourceLocation
    case unexpectedBetweenPoundSourceLocationAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndArgs
    case args
    case unexpectedBetweenArgsAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundSourceLocationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundSourceLocation else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundSourceLocationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundSourceLocation)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? = nil,
    poundSourceLocation: TokenSyntax,
    _ unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? = nil,
    args: PoundSourceLocationArgsSyntax?,
    _ unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundSourceLocation,
                                 parent: Syntax(self))
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
  public func withUnexpectedBeforePoundSourceLocation(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundSourceLocation)
    return PoundSourceLocationSyntax(newData)
  }

  public var poundSourceLocation: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundSourceLocation,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundSourceLocationKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundSourceLocation)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPoundSourceLocationAndLeftParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenPoundSourceLocationAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPoundSourceLocationAndLeftParen)
    return PoundSourceLocationSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndArgs,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftParenAndArgs(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndArgs)
    return PoundSourceLocationSyntax(newData)
  }

  public var args: PoundSourceLocationArgsSyntax? {
    get {
      let childData = data.child(at: Cursor.args,
                                 parent: Syntax(self))
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
  public func withArgs(
    _ newChild: PoundSourceLocationArgsSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.args)
    return PoundSourceLocationSyntax(newData)
  }

  public var unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenArgsAndRightParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenArgsAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenArgsAndRightParen)
    return PoundSourceLocationSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundSourceLocationSyntax(newData)
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
    ])
  }
}

// MARK: - ClassDeclSyntax

public struct ClassDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndClassKeyword
    case classKeyword
    case unexpectedBetweenClassKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClassDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .classDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClassDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .classDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? = nil,
    classKeyword: TokenSyntax,
    _ unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.classDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return ClassDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ClassDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return ClassDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndClassKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndClassKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndClassKeyword)
    return ClassDeclSyntax(newData)
  }

  public var classKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.classKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.classKeyword)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenClassKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenClassKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenClassKeywordAndIdentifier)
    return ClassDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause)
    return ClassDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause)
    return ClassDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return ClassDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ClassDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return ClassDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ClassDeclSyntax(newData)
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
    ])
  }
}

// MARK: - ActorDeclSyntax

public struct ActorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndActorKeyword
    case actorKeyword
    case unexpectedBetweenActorKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ActorDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .actorDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ActorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .actorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? = nil,
    actorKeyword: TokenSyntax,
    _ unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.actorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return ActorDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ActorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ActorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return ActorDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return ActorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndActorKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndActorKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndActorKeyword)
    return ActorDeclSyntax(newData)
  }

  public var actorKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.actorKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withActorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `actorKeyword` replaced.
  /// - param newChild: The new `actorKeyword` to replace the node's
  ///                   current `actorKeyword`, if present.
  public func withActorKeyword(
    _ newChild: TokenSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.actorKeyword)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenActorKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenActorKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenActorKeywordAndIdentifier)
    return ActorDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause)
    return ActorDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause)
    return ActorDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return ActorDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ActorDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return ActorDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ActorDeclSyntax(newData)
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
    ])
  }
}

// MARK: - StructDeclSyntax

public struct StructDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndStructKeyword
    case structKeyword
    case unexpectedBetweenStructKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `StructDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .structDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `StructDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .structDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? = nil,
    structKeyword: TokenSyntax,
    _ unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.structDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return StructDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> StructDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return StructDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndStructKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndStructKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndStructKeyword)
    return StructDeclSyntax(newData)
  }

  public var structKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.structKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.structKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.structKeyword)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenStructKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenStructKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenStructKeywordAndIdentifier)
    return StructDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause)
    return StructDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndInheritanceClause)
    return StructDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return StructDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return StructDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return StructDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return StructDeclSyntax(newData)
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
    ])
  }
}

// MARK: - ProtocolDeclSyntax

public struct ProtocolDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndProtocolKeyword
    case protocolKeyword
    case unexpectedBetweenProtocolKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause
    case primaryAssociatedTypeClause
    case unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ProtocolDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .protocolDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ProtocolDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .protocolDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? = nil,
    protocolKeyword: TokenSyntax,
    _ unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?,
    _ unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.protocolDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return ProtocolDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ProtocolDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return ProtocolDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndProtocolKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndProtocolKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndProtocolKeyword)
    return ProtocolDeclSyntax(newData)
  }

  public var protocolKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.protocolKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.protocolKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.protocolKeyword)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenProtocolKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenProtocolKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenProtocolKeywordAndIdentifier)
    return ProtocolDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause)
    return ProtocolDeclSyntax(newData)
  }

  public var primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.primaryAssociatedTypeClause,
                                 parent: Syntax(self))
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
  public func withPrimaryAssociatedTypeClause(
    _ newChild: PrimaryAssociatedTypeClauseSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.primaryAssociatedTypeClause)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause)
    return ProtocolDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return ProtocolDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ProtocolDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return ProtocolDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ProtocolDeclSyntax(newData)
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
    ])
  }
}

// MARK: - ExtensionDeclSyntax

public struct ExtensionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndExtensionKeyword
    case extensionKeyword
    case unexpectedBetweenExtensionKeywordAndExtendedType
    case extendedType
    case unexpectedBetweenExtendedTypeAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ExtensionDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .extensionDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ExtensionDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .extensionDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? = nil,
    extensionKeyword: TokenSyntax,
    _ unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? = nil,
    extendedType: TypeSyntax,
    _ unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.extensionDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return ExtensionDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ExtensionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return ExtensionDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndExtensionKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndExtensionKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndExtensionKeyword)
    return ExtensionDeclSyntax(newData)
  }

  public var extensionKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.extensionKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.extensionKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.extensionKeyword)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExtensionKeywordAndExtendedType,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenExtensionKeywordAndExtendedType(
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExtensionKeywordAndExtendedType)
    return ExtensionDeclSyntax(newData)
  }

  public var extendedType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.extendedType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.extendedType)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExtendedTypeAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenExtendedTypeAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExtendedTypeAndInheritanceClause)
    return ExtensionDeclSyntax(newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return ExtensionDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ExtensionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return ExtensionDeclSyntax(newData)
  }

  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ExtensionDeclSyntax(newData)
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
    ])
  }
}

// MARK: - FunctionDeclSyntax

public struct FunctionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndFuncKeyword
    case funcKeyword
    case unexpectedBetweenFuncKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndSignature
    case signature
    case unexpectedBetweenSignatureAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? = nil,
    funcKeyword: TokenSyntax,
    _ unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return FunctionDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> FunctionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return FunctionDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndFuncKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndFuncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndFuncKeyword)
    return FunctionDeclSyntax(newData)
  }

  public var funcKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.funcKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.funcKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.funcKeyword)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenFuncKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenFuncKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenFuncKeywordAndIdentifier)
    return FunctionDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameterClause)
    return FunctionDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndSignature,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndSignature(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndSignature)
    return FunctionDeclSyntax(newData)
  }

  public var signature: FunctionSignatureSyntax {
    get {
      let childData = data.child(at: Cursor.signature,
                                 parent: Syntax(self))
      return FunctionSignatureSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenSignatureAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenSignatureAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenSignatureAndGenericWhereClause)
    return FunctionDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return FunctionDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndBody,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndBody(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndBody)
    return FunctionDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
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
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return FunctionDeclSyntax(newData)
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
    ])
  }
}

// MARK: - InitializerDeclSyntax

public struct InitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndInitKeyword
    case initKeyword
    case unexpectedBetweenInitKeywordAndOptionalMark
    case optionalMark
    case unexpectedBetweenOptionalMarkAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndSignature
    case signature
    case unexpectedBetweenSignatureAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `InitializerDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .initializerDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `InitializerDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .initializerDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? = nil,
    initKeyword: TokenSyntax,
    _ unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? = nil,
    optionalMark: TokenSyntax?,
    _ unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return InitializerDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> InitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return InitializerDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndInitKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndInitKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndInitKeyword)
    return InitializerDeclSyntax(newData)
  }

  public var initKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.initKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.initKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.initKeyword)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInitKeywordAndOptionalMark,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInitKeywordAndOptionalMark(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInitKeywordAndOptionalMark)
    return InitializerDeclSyntax(newData)
  }

  public var optionalMark: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.optionalMark,
                                 parent: Syntax(self))
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
  public func withOptionalMark(
    _ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.optionalMark)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOptionalMarkAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenOptionalMarkAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOptionalMarkAndGenericParameterClause)
    return InitializerDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndSignature,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndSignature(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndSignature)
    return InitializerDeclSyntax(newData)
  }

  public var signature: FunctionSignatureSyntax {
    get {
      let childData = data.child(at: Cursor.signature,
                                 parent: Syntax(self))
      return FunctionSignatureSyntax(childData!)
    }
    set(value) {
      self = withSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(
    _ newChild: FunctionSignatureSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenSignatureAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenSignatureAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenSignatureAndGenericWhereClause)
    return InitializerDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return InitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndBody,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndBody(
    _ newChild: UnexpectedNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndBody)
    return InitializerDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
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
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return InitializerDeclSyntax(newData)
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
    ])
  }
}

// MARK: - DeinitializerDeclSyntax

public struct DeinitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndDeinitKeyword
    case deinitKeyword
    case unexpectedBetweenDeinitKeywordAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeinitializerDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .deinitializerDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeinitializerDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .deinitializerDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? = nil,
    deinitKeyword: TokenSyntax,
    _ unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.deinitializerDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return DeinitializerDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> DeinitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return DeinitializerDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndDeinitKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndDeinitKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndDeinitKeyword)
    return DeinitializerDeclSyntax(newData)
  }

  public var deinitKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.deinitKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.deinitKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.deinitKeyword)
    return DeinitializerDeclSyntax(newData)
  }

  public var unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenDeinitKeywordAndBody,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenDeinitKeywordAndBody(
    _ newChild: UnexpectedNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenDeinitKeywordAndBody)
    return DeinitializerDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
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
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DeinitializerDeclSyntax(newData)
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
    ])
  }
}

// MARK: - SubscriptDeclSyntax

public struct SubscriptDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndSubscriptKeyword
    case subscriptKeyword
    case unexpectedBetweenSubscriptKeywordAndGenericParameterClause
    case genericParameterClause
    case unexpectedBetweenGenericParameterClauseAndIndices
    case indices
    case unexpectedBetweenIndicesAndResult
    case result
    case unexpectedBetweenResultAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndAccessor
    case accessor
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SubscriptDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .subscriptDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SubscriptDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .subscriptDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? = nil,
    subscriptKeyword: TokenSyntax,
    _ unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? = nil,
    indices: ParameterClauseSyntax,
    _ unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? = nil,
    result: ReturnClauseSyntax,
    _ unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? = nil,
    accessor: Syntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return SubscriptDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> SubscriptDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return SubscriptDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndSubscriptKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndSubscriptKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndSubscriptKeyword)
    return SubscriptDeclSyntax(newData)
  }

  public var subscriptKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.subscriptKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.subscriptKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.subscriptKeyword)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenSubscriptKeywordAndGenericParameterClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenSubscriptKeywordAndGenericParameterClause(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenSubscriptKeywordAndGenericParameterClause)
    return SubscriptDeclSyntax(newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameterClause,
                                 parent: Syntax(self))
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
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParameterClauseAndIndices,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParameterClauseAndIndices(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParameterClauseAndIndices)
    return SubscriptDeclSyntax(newData)
  }

  public var indices: ParameterClauseSyntax {
    get {
      let childData = data.child(at: Cursor.indices,
                                 parent: Syntax(self))
      return ParameterClauseSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.indices)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIndicesAndResult,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIndicesAndResult(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIndicesAndResult)
    return SubscriptDeclSyntax(newData)
  }

  public var result: ReturnClauseSyntax {
    get {
      let childData = data.child(at: Cursor.result,
                                 parent: Syntax(self))
      return ReturnClauseSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.returnClause, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.result)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenResultAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenResultAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenResultAndGenericWhereClause)
    return SubscriptDeclSyntax(newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return SubscriptDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndAccessor,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndAccessor(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndAccessor)
    return SubscriptDeclSyntax(newData)
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
    _ newChild: Syntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.accessor)
    return SubscriptDeclSyntax(newData)
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
    ])
  }
}

// MARK: - ImportDeclSyntax

public struct ImportDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndImportTok
    case importTok
    case unexpectedBetweenImportTokAndImportKind
    case importKind
    case unexpectedBetweenImportKindAndPath
    case path
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ImportDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .importDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ImportDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .importDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? = nil,
    importTok: TokenSyntax,
    _ unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? = nil,
    importKind: TokenSyntax?,
    _ unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? = nil,
    path: AccessPathSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.importDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return ImportDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return ImportDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndImportTok,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndImportTok(
    _ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndImportTok)
    return ImportDeclSyntax(newData)
  }

  public var importTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.importTok,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.importKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.importTok)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenImportTokAndImportKind,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenImportTokAndImportKind(
    _ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenImportTokAndImportKind)
    return ImportDeclSyntax(newData)
  }

  public var importKind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.importKind,
                                 parent: Syntax(self))
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
  public func withImportKind(
    _ newChild: TokenSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.importKind)
    return ImportDeclSyntax(newData)
  }

  public var unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenImportKindAndPath,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenImportKindAndPath(
    _ newChild: UnexpectedNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenImportKindAndPath)
    return ImportDeclSyntax(newData)
  }

  public var path: AccessPathSyntax {
    get {
      let childData = data.child(at: Cursor.path,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.path] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.accessPath,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessPath, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.path)
    return ImportDeclSyntax(newData)
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
    ])
  }
}

// MARK: - AccessorDeclSyntax

public struct AccessorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifier
    case modifier
    case unexpectedBetweenModifierAndAccessorKind
    case accessorKind
    case unexpectedBetweenAccessorKindAndParameter
    case parameter
    case unexpectedBetweenParameterAndAsyncKeyword
    case asyncKeyword
    case unexpectedBetweenAsyncKeywordAndThrowsKeyword
    case throwsKeyword
    case unexpectedBetweenThrowsKeywordAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AccessorDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .accessorDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AccessorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? = nil,
    modifier: DeclModifierSyntax?,
    _ unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? = nil,
    accessorKind: TokenSyntax,
    _ unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? = nil,
    parameter: AccessorParameterSyntax?,
    _ unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? = nil,
    throwsKeyword: TokenSyntax?,
    _ unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? = nil,
    body: CodeBlockSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return AccessorDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> AccessorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenAttributesAndModifier(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifier)
    return AccessorDeclSyntax(newData)
  }

  public var modifier: DeclModifierSyntax? {
    get {
      let childData = data.child(at: Cursor.modifier,
                                 parent: Syntax(self))
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
  public func withModifier(
    _ newChild: DeclModifierSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifier)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifierAndAccessorKind,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifierAndAccessorKind(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifierAndAccessorKind)
    return AccessorDeclSyntax(newData)
  }

  public var accessorKind: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.accessorKind,
                                 parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.accessorKind)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAccessorKindAndParameter,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenAccessorKindAndParameter(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAccessorKindAndParameter)
    return AccessorDeclSyntax(newData)
  }

  public var parameter: AccessorParameterSyntax? {
    get {
      let childData = data.child(at: Cursor.parameter,
                                 parent: Syntax(self))
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
  public func withParameter(
    _ newChild: AccessorParameterSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.parameter)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenParameterAndAsyncKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenParameterAndAsyncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenParameterAndAsyncKeyword)
    return AccessorDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.asyncKeyword)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAsyncKeywordAndThrowsKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenAsyncKeywordAndThrowsKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAsyncKeywordAndThrowsKeyword)
    return AccessorDeclSyntax(newData)
  }

  public var throwsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsKeyword,
                                 parent: Syntax(self))
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
  public func withThrowsKeyword(
    _ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsKeyword)
    return AccessorDeclSyntax(newData)
  }

  public var unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenThrowsKeywordAndBody,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenThrowsKeywordAndBody(
    _ newChild: UnexpectedNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenThrowsKeywordAndBody)
    return AccessorDeclSyntax(newData)
  }

  public var body: CodeBlockSyntax? {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
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
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return AccessorDeclSyntax(newData)
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
    ])
  }
}

// MARK: - VariableDeclSyntax

public struct VariableDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndLetOrVarKeyword
    case letOrVarKeyword
    case unexpectedBetweenLetOrVarKeywordAndBindings
    case bindings
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `VariableDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .variableDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `VariableDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .variableDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? = nil,
    bindings: PatternBindingListSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.variableDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return VariableDeclSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return VariableDeclSyntax(newData)
  }

  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndLetOrVarKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndLetOrVarKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndLetOrVarKeyword)
    return VariableDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return VariableDeclSyntax(newData)
  }

  public var unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLetOrVarKeywordAndBindings,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLetOrVarKeywordAndBindings(
    _ newChild: UnexpectedNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLetOrVarKeywordAndBindings)
    return VariableDeclSyntax(newData)
  }

  public var bindings: PatternBindingListSyntax {
    get {
      let childData = data.child(at: Cursor.bindings,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.bindings] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.patternBindingList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.patternBindingList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.bindings)
    return VariableDeclSyntax(newData)
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
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndCaseKeyword
    case caseKeyword
    case unexpectedBetweenCaseKeywordAndElements
    case elements
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `EnumCaseDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .enumCaseDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `EnumCaseDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCaseDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? = nil,
    caseKeyword: TokenSyntax,
    _ unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? = nil,
    elements: EnumCaseElementListSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return EnumCaseDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the case declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return EnumCaseDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the case declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndCaseKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndCaseKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndCaseKeyword)
    return EnumCaseDeclSyntax(newData)
  }

  /// The `case` keyword for this case.
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
    _ newChild: TokenSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return EnumCaseDeclSyntax(newData)
  }

  public var unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenCaseKeywordAndElements,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenCaseKeywordAndElements(
    _ newChild: UnexpectedNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenCaseKeywordAndElements)
    return EnumCaseDeclSyntax(newData)
  }

  /// The elements this case declares.
  public var elements: EnumCaseElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.elements] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.enumCaseElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return EnumCaseDeclSyntax(newData)
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
    ])
  }
}

// MARK: - EnumDeclSyntax

/// A Swift `enum` declaration.
public struct EnumDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndEnumKeyword
    case enumKeyword
    case unexpectedBetweenEnumKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericParameters
    case genericParameters
    case unexpectedBetweenGenericParametersAndInheritanceClause
    case inheritanceClause
    case unexpectedBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case unexpectedBetweenGenericWhereClauseAndMembers
    case members
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `EnumDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .enumDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `EnumDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? = nil,
    enumKeyword: TokenSyntax,
    _ unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the enum declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> EnumDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the enum declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndEnumKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndEnumKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndEnumKeyword)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The `enum` keyword for this declaration.
  /// 
  public var enumKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.enumKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.enumKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.enumKeyword)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenEnumKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenEnumKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenEnumKeywordAndIdentifier)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The name of this enum.
  /// 
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
    _ newChild: TokenSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericParameters,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndGenericParameters(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericParameters)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The generic parameters, if any, for this enum.
  /// 
  public var genericParameters: GenericParameterClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericParameters,
                                 parent: Syntax(self))
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
  public func withGenericParameters(
    _ newChild: GenericParameterClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameters)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericParametersAndInheritanceClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericParametersAndInheritanceClause(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericParametersAndInheritanceClause)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The inheritance clause describing conformances or raw
  /// values for this enum.
  /// 
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritanceClause,
                                 parent: Syntax(self))
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
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenInheritanceClauseAndGenericWhereClause)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The `where` clause that applies to the generic parameters of
  /// this enum.
  /// 
  public var genericWhereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericWhereClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericWhereClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return EnumDeclSyntax(newData)
  }

  public var unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGenericWhereClauseAndMembers(
    _ newChild: UnexpectedNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGenericWhereClauseAndMembers)
    return EnumDeclSyntax(newData)
  }

  /// 
  /// The cases and other members of this enum.
  /// 
  public var members: MemberDeclBlockSyntax {
    get {
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclBlockSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return EnumDeclSyntax(newData)
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
    ])
  }
}

// MARK: - OperatorDeclSyntax

/// A Swift `operator` declaration.
public struct OperatorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndOperatorKeyword
    case operatorKeyword
    case unexpectedBetweenOperatorKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes
    case operatorPrecedenceAndTypes
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OperatorDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .operatorDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OperatorDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .operatorDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? = nil,
    operatorKeyword: TokenSyntax,
    _ unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the 'operator' declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> OperatorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the 'operator'
  /// declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndOperatorKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndOperatorKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndOperatorKeyword)
    return OperatorDeclSyntax(newData)
  }

  public var operatorKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.operatorKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.operatorKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.operatorKeyword)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOperatorKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenOperatorKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOperatorKeywordAndIdentifier)
    return OperatorDeclSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unspacedBinaryOperator(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return OperatorDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes(
    _ newChild: UnexpectedNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes)
    return OperatorDeclSyntax(newData)
  }

  /// 
  /// Optionally specify a precedence group and designated types.
  /// 
  public var operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? {
    get {
      let childData = data.child(at: Cursor.operatorPrecedenceAndTypes,
                                 parent: Syntax(self))
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
  public func withOperatorPrecedenceAndTypes(
    _ newChild: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.operatorPrecedenceAndTypes)
    return OperatorDeclSyntax(newData)
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
    ])
  }
}

// MARK: - PrecedenceGroupDeclSyntax

/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAttributes
    case attributes
    case unexpectedBetweenAttributesAndModifiers
    case modifiers
    case unexpectedBetweenModifiersAndPrecedencegroupKeyword
    case precedencegroupKeyword
    case unexpectedBetweenPrecedencegroupKeywordAndIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndLeftBrace
    case leftBrace
    case unexpectedBetweenLeftBraceAndGroupAttributes
    case groupAttributes
    case unexpectedBetweenGroupAttributesAndRightBrace
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupDeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .precedenceGroupDecl else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrecedenceGroupDeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupDecl)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? = nil,
    precedencegroupKeyword: TokenSyntax,
    _ unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? = nil,
    groupAttributes: PrecedenceGroupAttributeListSyntax,
    _ unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax
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
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAttributes,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAttributes)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The attributes applied to the 'precedencegroup' declaration.
  /// 
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
  public func addAttribute(_ element: Syntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAttributesAndModifiers)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The declaration modifiers applied to the 'precedencegroup'
  /// declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
    get {
      let childData = data.child(at: Cursor.modifiers,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.modifiers] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: [element.raw], arena: .default)
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

  public var unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenModifiersAndPrecedencegroupKeyword,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenModifiersAndPrecedencegroupKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenModifiersAndPrecedencegroupKeyword)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var precedencegroupKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.precedencegroupKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.precedencegroupKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.precedencegroupKeyword)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPrecedencegroupKeywordAndIdentifier,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenPrecedencegroupKeywordAndIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPrecedencegroupKeywordAndIdentifier)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The name of this precedence group.
  /// 
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
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndLeftBrace,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenIdentifierAndLeftBrace(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndLeftBrace)
    return PrecedenceGroupDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftBraceAndGroupAttributes,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftBraceAndGroupAttributes(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftBraceAndGroupAttributes)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// 
  /// The characteristics of this precedence group.
  /// 
  public var groupAttributes: PrecedenceGroupAttributeListSyntax {
    get {
      let childData = data.child(at: Cursor.groupAttributes,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.groupAttributes] {
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAttributeList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupAttributeList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.groupAttributes)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenGroupAttributesAndRightBrace,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenGroupAttributesAndRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenGroupAttributesAndRightBrace)
    return PrecedenceGroupDeclSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return PrecedenceGroupDeclSyntax(newData)
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
    ])
  }
}

