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
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unknownDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }


  public func _validateLayout() {
    // We are verifying an unknown node. Since we don’t know anything about it
    // we need to assume it’s valid.
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
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.missingDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> MissingDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
  }
}

extension MissingDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypealiasDeclSyntax

public struct TypealiasDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndTypealiasKeyword
    case typealiasKeyword
    case garbageBetweenTypealiasKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndInitializer
    case initializer
    case garbageBetweenInitializerAndGenericWhereClause
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndTypealiasKeyword: GarbageNodesSyntax? = nil,
    typealiasKeyword: TokenSyntax,
    _ garbageBetweenTypealiasKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInitializer: GarbageNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax,
    _ garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndTypealiasKeyword?.raw,
      typealiasKeyword.raw,
      garbageBetweenTypealiasKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInitializer?.raw,
      initializer.raw,
      garbageBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typealiasDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndTypealiasKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndTypealiasKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndTypealiasKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndTypealiasKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndTypealiasKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndTypealiasKeyword`, if present.
  public func withGarbageBetweenModifiersAndTypealiasKeyword(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndTypealiasKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.typealiasKeyword)
    let newData = data.replacingChild(raw, at: Cursor.typealiasKeyword)
    return TypealiasDeclSyntax(newData)
  }

  public var garbageBetweenTypealiasKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTypealiasKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTypealiasKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTypealiasKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenTypealiasKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenTypealiasKeywordAndIdentifier`, if present.
  public func withGarbageBetweenTypealiasKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTypealiasKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return TypealiasDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameterClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndInitializer: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndInitializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndInitializer` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndInitializer` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndInitializer`, if present.
  public func withGarbageBetweenGenericParameterClauseAndInitializer(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndInitializer)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.typeInitializerClause)
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return TypealiasDeclSyntax(newData)
  }

  public var garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInitializerAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInitializerAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInitializerAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInitializerAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInitializerAndGenericWhereClause`, if present.
  public func withGarbageBetweenInitializerAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInitializerAndGenericWhereClause)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 14)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInitializerClauseSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInitializerClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
  }
}

extension TypealiasDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndTypealiasKeyword": garbageBetweenModifiersAndTypealiasKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typealiasKeyword": Syntax(typealiasKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenTypealiasKeywordAndIdentifier": garbageBetweenTypealiasKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameterClause": garbageBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndInitializer": garbageBetweenGenericParameterClauseAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": Syntax(initializer).asProtocol(SyntaxProtocol.self),
      "garbageBetweenInitializerAndGenericWhereClause": garbageBetweenInitializerAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AssociatedtypeDeclSyntax

public struct AssociatedtypeDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndAssociatedtypeKeyword
    case associatedtypeKeyword
    case garbageBetweenAssociatedtypeKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndInitializer
    case initializer
    case garbageBetweenInitializerAndGenericWhereClause
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndAssociatedtypeKeyword: GarbageNodesSyntax? = nil,
    associatedtypeKeyword: TokenSyntax,
    _ garbageBetweenAssociatedtypeKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndInitializer: GarbageNodesSyntax? = nil,
    initializer: TypeInitializerClauseSyntax?,
    _ garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndAssociatedtypeKeyword?.raw,
      associatedtypeKeyword.raw,
      garbageBetweenAssociatedtypeKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndInitializer?.raw,
      initializer?.raw,
      garbageBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.associatedtypeDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndAssociatedtypeKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndAssociatedtypeKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndAssociatedtypeKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndAssociatedtypeKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndAssociatedtypeKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndAssociatedtypeKeyword`, if present.
  public func withGarbageBetweenModifiersAndAssociatedtypeKeyword(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndAssociatedtypeKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.associatedtypeKeyword)
    let newData = data.replacingChild(raw, at: Cursor.associatedtypeKeyword)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var garbageBetweenAssociatedtypeKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAssociatedtypeKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAssociatedtypeKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAssociatedtypeKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenAssociatedtypeKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenAssociatedtypeKeywordAndIdentifier`, if present.
  public func withGarbageBetweenAssociatedtypeKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAssociatedtypeKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return AssociatedtypeDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndInheritanceClause`, if present.
  public func withGarbageBetweenIdentifierAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndInitializer: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndInitializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndInitializer` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndInitializer` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndInitializer`, if present.
  public func withGarbageBetweenInheritanceClauseAndInitializer(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndInitializer)
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

  public var garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInitializerAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInitializerAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInitializerAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInitializerAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInitializerAndGenericWhereClause`, if present.
  public func withGarbageBetweenInitializerAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInitializerAndGenericWhereClause)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 14)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInitializerClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInitializerClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
  }
}

extension AssociatedtypeDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndAssociatedtypeKeyword": garbageBetweenModifiersAndAssociatedtypeKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associatedtypeKeyword": Syntax(associatedtypeKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAssociatedtypeKeywordAndIdentifier": garbageBetweenAssociatedtypeKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndInheritanceClause": garbageBetweenIdentifierAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndInitializer": garbageBetweenInheritanceClauseAndInitializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInitializerAndGenericWhereClause": garbageBetweenInitializerAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfConfigDeclSyntax

public struct IfConfigDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeClauses
    case clauses
    case garbageBetweenClausesAndPoundEndif
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
    _ garbageBeforeClauses: GarbageNodesSyntax? = nil,
    clauses: IfConfigClauseListSyntax,
    _ garbageBetweenClausesAndPoundEndif: GarbageNodesSyntax? = nil,
    poundEndif: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeClauses?.raw,
      clauses.raw,
      garbageBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeClauses: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeClauses,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeClauses(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeClauses` replaced.
  /// - param newChild: The new `garbageBeforeClauses` to replace the node's
  ///                   current `garbageBeforeClauses`, if present.
  public func withGarbageBeforeClauses(
    _ newChild: GarbageNodesSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeClauses)
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

  public var garbageBetweenClausesAndPoundEndif: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenClausesAndPoundEndif,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenClausesAndPoundEndif(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenClausesAndPoundEndif` replaced.
  /// - param newChild: The new `garbageBetweenClausesAndPoundEndif` to replace the node's
  ///                   current `garbageBetweenClausesAndPoundEndif`, if present.
  public func withGarbageBetweenClausesAndPoundEndif(
    _ newChild: GarbageNodesSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenClausesAndPoundEndif)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundEndifKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundEndif)
    return IfConfigDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is IfConfigClauseListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(IfConfigClauseListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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

extension IfConfigDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeClauses": garbageBeforeClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "clauses": Syntax(clauses).asProtocol(SyntaxProtocol.self),
      "garbageBetweenClausesAndPoundEndif": garbageBetweenClausesAndPoundEndif.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundEndif": Syntax(poundEndif).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundErrorDeclSyntax

public struct PoundErrorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundError
    case poundError
    case garbageBetweenPoundErrorAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndMessage
    case message
    case garbageBetweenMessageAndRightParen
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
    _ garbageBeforePoundError: GarbageNodesSyntax? = nil,
    poundError: TokenSyntax,
    _ garbageBetweenPoundErrorAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundError?.raw,
      poundError.raw,
      garbageBetweenPoundErrorAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndMessage?.raw,
      message.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundErrorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundError: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundError,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundError(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundError` replaced.
  /// - param newChild: The new `garbageBeforePoundError` to replace the node's
  ///                   current `garbageBeforePoundError`, if present.
  public func withGarbageBeforePoundError(
    _ newChild: GarbageNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundError)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundErrorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundError)
    return PoundErrorDeclSyntax(newData)
  }

  public var garbageBetweenPoundErrorAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPoundErrorAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPoundErrorAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPoundErrorAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenPoundErrorAndLeftParen` to replace the node's
  ///                   current `garbageBetweenPoundErrorAndLeftParen`, if present.
  public func withGarbageBetweenPoundErrorAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPoundErrorAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundErrorDeclSyntax(newData)
  }

  public var garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndMessage,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndMessage` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndMessage` to replace the node's
  ///                   current `garbageBetweenLeftParenAndMessage`, if present.
  public func withGarbageBetweenLeftParenAndMessage(
    _ newChild: GarbageNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndMessage)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundErrorDeclSyntax(newData)
  }

  public var garbageBetweenMessageAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenMessageAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenMessageAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenMessageAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenMessageAndRightParen` to replace the node's
  ///                   current `garbageBetweenMessageAndRightParen`, if present.
  public func withGarbageBetweenMessageAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenMessageAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundErrorDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is StringLiteralExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(StringLiteralExprSyntax.self))
    }
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PoundErrorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundError": garbageBeforePoundError.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundError": Syntax(poundError).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPoundErrorAndLeftParen": garbageBetweenPoundErrorAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndMessage": garbageBetweenLeftParenAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": Syntax(message).asProtocol(SyntaxProtocol.self),
      "garbageBetweenMessageAndRightParen": garbageBetweenMessageAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundWarningDeclSyntax

public struct PoundWarningDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundWarning
    case poundWarning
    case garbageBetweenPoundWarningAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndMessage
    case message
    case garbageBetweenMessageAndRightParen
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
    _ garbageBeforePoundWarning: GarbageNodesSyntax? = nil,
    poundWarning: TokenSyntax,
    _ garbageBetweenPoundWarningAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? = nil,
    message: StringLiteralExprSyntax,
    _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundWarning?.raw,
      poundWarning.raw,
      garbageBetweenPoundWarningAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndMessage?.raw,
      message.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundWarningDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundWarning: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundWarning,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundWarning(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundWarning` replaced.
  /// - param newChild: The new `garbageBeforePoundWarning` to replace the node's
  ///                   current `garbageBeforePoundWarning`, if present.
  public func withGarbageBeforePoundWarning(
    _ newChild: GarbageNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundWarning)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundWarningKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundWarning)
    return PoundWarningDeclSyntax(newData)
  }

  public var garbageBetweenPoundWarningAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPoundWarningAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPoundWarningAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPoundWarningAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenPoundWarningAndLeftParen` to replace the node's
  ///                   current `garbageBetweenPoundWarningAndLeftParen`, if present.
  public func withGarbageBetweenPoundWarningAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPoundWarningAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundWarningDeclSyntax(newData)
  }

  public var garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndMessage,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndMessage` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndMessage` to replace the node's
  ///                   current `garbageBetweenLeftParenAndMessage`, if present.
  public func withGarbageBetweenLeftParenAndMessage(
    _ newChild: GarbageNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndMessage)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundWarningDeclSyntax(newData)
  }

  public var garbageBetweenMessageAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenMessageAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenMessageAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenMessageAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenMessageAndRightParen` to replace the node's
  ///                   current `garbageBetweenMessageAndRightParen`, if present.
  public func withGarbageBetweenMessageAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenMessageAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundWarningDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is StringLiteralExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(StringLiteralExprSyntax.self))
    }
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PoundWarningDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundWarning": garbageBeforePoundWarning.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundWarning": Syntax(poundWarning).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPoundWarningAndLeftParen": garbageBetweenPoundWarningAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndMessage": garbageBetweenLeftParenAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": Syntax(message).asProtocol(SyntaxProtocol.self),
      "garbageBetweenMessageAndRightParen": garbageBetweenMessageAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundSourceLocationSyntax

public struct PoundSourceLocationSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundSourceLocation
    case poundSourceLocation
    case garbageBetweenPoundSourceLocationAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndArgs
    case args
    case garbageBetweenArgsAndRightParen
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
    _ garbageBeforePoundSourceLocation: GarbageNodesSyntax? = nil,
    poundSourceLocation: TokenSyntax,
    _ garbageBetweenPoundSourceLocationAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndArgs: GarbageNodesSyntax? = nil,
    args: PoundSourceLocationArgsSyntax?,
    _ garbageBetweenArgsAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundSourceLocation?.raw,
      poundSourceLocation.raw,
      garbageBetweenPoundSourceLocationAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArgs?.raw,
      args?.raw,
      garbageBetweenArgsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundSourceLocation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundSourceLocation: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundSourceLocation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundSourceLocation(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundSourceLocation` replaced.
  /// - param newChild: The new `garbageBeforePoundSourceLocation` to replace the node's
  ///                   current `garbageBeforePoundSourceLocation`, if present.
  public func withGarbageBeforePoundSourceLocation(
    _ newChild: GarbageNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundSourceLocation)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundSourceLocation)
    return PoundSourceLocationSyntax(newData)
  }

  public var garbageBetweenPoundSourceLocationAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPoundSourceLocationAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPoundSourceLocationAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPoundSourceLocationAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenPoundSourceLocationAndLeftParen` to replace the node's
  ///                   current `garbageBetweenPoundSourceLocationAndLeftParen`, if present.
  public func withGarbageBetweenPoundSourceLocationAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPoundSourceLocationAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundSourceLocationSyntax(newData)
  }

  public var garbageBetweenLeftParenAndArgs: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndArgs,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndArgs(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndArgs` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndArgs` to replace the node's
  ///                   current `garbageBetweenLeftParenAndArgs`, if present.
  public func withGarbageBetweenLeftParenAndArgs(
    _ newChild: GarbageNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndArgs)
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

  public var garbageBetweenArgsAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenArgsAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenArgsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenArgsAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenArgsAndRightParen` to replace the node's
  ///                   current `garbageBetweenArgsAndRightParen`, if present.
  public func withGarbageBetweenArgsAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArgsAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundSourceLocationSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is PoundSourceLocationArgsSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PoundSourceLocationArgsSyntax.self))
    }
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PoundSourceLocationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundSourceLocation": garbageBeforePoundSourceLocation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundSourceLocation": Syntax(poundSourceLocation).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPoundSourceLocationAndLeftParen": garbageBetweenPoundSourceLocationAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndArgs": garbageBetweenLeftParenAndArgs.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "args": args.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenArgsAndRightParen": garbageBetweenArgsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ClassDeclSyntax

public struct ClassDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndClassKeyword
    case classKeyword
    case garbageBetweenClassKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndClassKeyword: GarbageNodesSyntax? = nil,
    classKeyword: TokenSyntax,
    _ garbageBetweenClassKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndClassKeyword?.raw,
      classKeyword.raw,
      garbageBetweenClassKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndClassKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndClassKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndClassKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndClassKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndClassKeyword`, if present.
  public func withGarbageBetweenModifiersAndClassKeyword(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndClassKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.classKeyword)
    let newData = data.replacingChild(raw, at: Cursor.classKeyword)
    return ClassDeclSyntax(newData)
  }

  public var garbageBetweenClassKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenClassKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenClassKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenClassKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenClassKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenClassKeywordAndIdentifier`, if present.
  public func withGarbageBetweenClassKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenClassKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ClassDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameterClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withGarbageBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ClassDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is MemberDeclBlockSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension ClassDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndClassKeyword": garbageBetweenModifiersAndClassKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "classKeyword": Syntax(classKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenClassKeywordAndIdentifier": garbageBetweenClassKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameterClause": garbageBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndInheritanceClause": garbageBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ActorDeclSyntax

public struct ActorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndActorKeyword
    case actorKeyword
    case garbageBetweenActorKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndActorKeyword: GarbageNodesSyntax? = nil,
    actorKeyword: TokenSyntax,
    _ garbageBetweenActorKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndActorKeyword?.raw,
      actorKeyword.raw,
      garbageBetweenActorKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.actorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
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

  public var garbageBetweenModifiersAndActorKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndActorKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndActorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndActorKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndActorKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndActorKeyword`, if present.
  public func withGarbageBetweenModifiersAndActorKeyword(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndActorKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.contextualKeyword(""))
    let newData = data.replacingChild(raw, at: Cursor.actorKeyword)
    return ActorDeclSyntax(newData)
  }

  public var garbageBetweenActorKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenActorKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenActorKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenActorKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenActorKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenActorKeywordAndIdentifier`, if present.
  public func withGarbageBetweenActorKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenActorKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ActorDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameterClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withGarbageBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> ActorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ActorDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is MemberDeclBlockSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension ActorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndActorKeyword": garbageBetweenModifiersAndActorKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "actorKeyword": Syntax(actorKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenActorKeywordAndIdentifier": garbageBetweenActorKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameterClause": garbageBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndInheritanceClause": garbageBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - StructDeclSyntax

public struct StructDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndStructKeyword
    case structKeyword
    case garbageBetweenStructKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndStructKeyword: GarbageNodesSyntax? = nil,
    structKeyword: TokenSyntax,
    _ garbageBetweenStructKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndStructKeyword?.raw,
      structKeyword.raw,
      garbageBetweenStructKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.structDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndStructKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndStructKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndStructKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndStructKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndStructKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndStructKeyword`, if present.
  public func withGarbageBetweenModifiersAndStructKeyword(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndStructKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.structKeyword)
    let newData = data.replacingChild(raw, at: Cursor.structKeyword)
    return StructDeclSyntax(newData)
  }

  public var garbageBetweenStructKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenStructKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenStructKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenStructKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenStructKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenStructKeywordAndIdentifier`, if present.
  public func withGarbageBetweenStructKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenStructKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return StructDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameterClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndInheritanceClause`, if present.
  public func withGarbageBetweenGenericParameterClauseAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return StructDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is MemberDeclBlockSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension StructDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndStructKeyword": garbageBetweenModifiersAndStructKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "structKeyword": Syntax(structKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenStructKeywordAndIdentifier": garbageBetweenStructKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameterClause": garbageBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndInheritanceClause": garbageBetweenGenericParameterClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ProtocolDeclSyntax

public struct ProtocolDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndProtocolKeyword
    case protocolKeyword
    case garbageBetweenProtocolKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndPrimaryAssociatedTypeClause
    case primaryAssociatedTypeClause
    case garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndProtocolKeyword: GarbageNodesSyntax? = nil,
    protocolKeyword: TokenSyntax,
    _ garbageBetweenProtocolKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: GarbageNodesSyntax? = nil,
    primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?,
    _ garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndProtocolKeyword?.raw,
      protocolKeyword.raw,
      garbageBetweenProtocolKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw,
      primaryAssociatedTypeClause?.raw,
      garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.protocolDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndProtocolKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndProtocolKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndProtocolKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndProtocolKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndProtocolKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndProtocolKeyword`, if present.
  public func withGarbageBetweenModifiersAndProtocolKeyword(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndProtocolKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.protocolKeyword)
    let newData = data.replacingChild(raw, at: Cursor.protocolKeyword)
    return ProtocolDeclSyntax(newData)
  }

  public var garbageBetweenProtocolKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenProtocolKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenProtocolKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenProtocolKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenProtocolKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenProtocolKeywordAndIdentifier`, if present.
  public func withGarbageBetweenProtocolKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenProtocolKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ProtocolDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndPrimaryAssociatedTypeClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndPrimaryAssociatedTypeClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndPrimaryAssociatedTypeClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndPrimaryAssociatedTypeClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndPrimaryAssociatedTypeClause`, if present.
  public func withGarbageBetweenIdentifierAndPrimaryAssociatedTypeClause(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndPrimaryAssociatedTypeClause)
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

  public var garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause`, if present.
  public func withGarbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ProtocolDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is PrimaryAssociatedTypeClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PrimaryAssociatedTypeClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is MemberDeclBlockSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension ProtocolDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndProtocolKeyword": garbageBetweenModifiersAndProtocolKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "protocolKeyword": Syntax(protocolKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenProtocolKeywordAndIdentifier": garbageBetweenProtocolKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndPrimaryAssociatedTypeClause": garbageBetweenIdentifierAndPrimaryAssociatedTypeClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "primaryAssociatedTypeClause": primaryAssociatedTypeClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause": garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ExtensionDeclSyntax

public struct ExtensionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndExtensionKeyword
    case extensionKeyword
    case garbageBetweenExtensionKeywordAndExtendedType
    case extendedType
    case garbageBetweenExtendedTypeAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndExtensionKeyword: GarbageNodesSyntax? = nil,
    extensionKeyword: TokenSyntax,
    _ garbageBetweenExtensionKeywordAndExtendedType: GarbageNodesSyntax? = nil,
    extendedType: TypeSyntax,
    _ garbageBetweenExtendedTypeAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndExtensionKeyword?.raw,
      extensionKeyword.raw,
      garbageBetweenExtensionKeywordAndExtendedType?.raw,
      extendedType.raw,
      garbageBetweenExtendedTypeAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.extensionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndExtensionKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndExtensionKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndExtensionKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndExtensionKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndExtensionKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndExtensionKeyword`, if present.
  public func withGarbageBetweenModifiersAndExtensionKeyword(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndExtensionKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.extensionKeyword)
    let newData = data.replacingChild(raw, at: Cursor.extensionKeyword)
    return ExtensionDeclSyntax(newData)
  }

  public var garbageBetweenExtensionKeywordAndExtendedType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExtensionKeywordAndExtendedType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExtensionKeywordAndExtendedType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExtensionKeywordAndExtendedType` replaced.
  /// - param newChild: The new `garbageBetweenExtensionKeywordAndExtendedType` to replace the node's
  ///                   current `garbageBetweenExtensionKeywordAndExtendedType`, if present.
  public func withGarbageBetweenExtensionKeywordAndExtendedType(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExtensionKeywordAndExtendedType)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.extendedType)
    return ExtensionDeclSyntax(newData)
  }

  public var garbageBetweenExtendedTypeAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExtendedTypeAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExtendedTypeAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExtendedTypeAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenExtendedTypeAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenExtendedTypeAndInheritanceClause`, if present.
  public func withGarbageBetweenExtendedTypeAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExtendedTypeAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ExtensionDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 14)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TypeSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is MemberDeclBlockSyntax 
    assert(rawChildren[13].raw != nil)
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension ExtensionDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndExtensionKeyword": garbageBetweenModifiersAndExtensionKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "extensionKeyword": Syntax(extensionKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExtensionKeywordAndExtendedType": garbageBetweenExtensionKeywordAndExtendedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "extendedType": Syntax(extendedType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExtendedTypeAndInheritanceClause": garbageBetweenExtendedTypeAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionDeclSyntax

public struct FunctionDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndFuncKeyword
    case funcKeyword
    case garbageBetweenFuncKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndSignature
    case signature
    case garbageBetweenSignatureAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndBody
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndFuncKeyword: GarbageNodesSyntax? = nil,
    funcKeyword: TokenSyntax,
    _ garbageBetweenFuncKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndFuncKeyword?.raw,
      funcKeyword.raw,
      garbageBetweenFuncKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      garbageBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndFuncKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndFuncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndFuncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndFuncKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndFuncKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndFuncKeyword`, if present.
  public func withGarbageBetweenModifiersAndFuncKeyword(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndFuncKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.funcKeyword)
    let newData = data.replacingChild(raw, at: Cursor.funcKeyword)
    return FunctionDeclSyntax(newData)
  }

  public var garbageBetweenFuncKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenFuncKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenFuncKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenFuncKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenFuncKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenFuncKeywordAndIdentifier`, if present.
  public func withGarbageBetweenFuncKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenFuncKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return FunctionDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameterClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndSignature,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndSignature` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndSignature` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndSignature`, if present.
  public func withGarbageBetweenGenericParameterClauseAndSignature(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndSignature)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionSignature)
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return FunctionDeclSyntax(newData)
  }

  public var garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSignatureAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSignatureAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSignatureAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenSignatureAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenSignatureAndGenericWhereClause`, if present.
  public func withGarbageBetweenSignatureAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSignatureAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndBody` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndBody` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndBody`, if present.
  public func withGarbageBetweenGenericWhereClauseAndBody(
    _ newChild: GarbageNodesSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndBody)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is FunctionSignatureSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(FunctionSignatureSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is CodeBlockSyntax or missing
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension FunctionDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndFuncKeyword": garbageBetweenModifiersAndFuncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "funcKeyword": Syntax(funcKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenFuncKeywordAndIdentifier": garbageBetweenFuncKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameterClause": garbageBetweenIdentifierAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndSignature": garbageBetweenGenericParameterClauseAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": Syntax(signature).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSignatureAndGenericWhereClause": garbageBetweenSignatureAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndBody": garbageBetweenGenericWhereClauseAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InitializerDeclSyntax

public struct InitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndInitKeyword
    case initKeyword
    case garbageBetweenInitKeywordAndOptionalMark
    case optionalMark
    case garbageBetweenOptionalMarkAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndSignature
    case signature
    case garbageBetweenSignatureAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndBody
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndInitKeyword: GarbageNodesSyntax? = nil,
    initKeyword: TokenSyntax,
    _ garbageBetweenInitKeywordAndOptionalMark: GarbageNodesSyntax? = nil,
    optionalMark: TokenSyntax?,
    _ garbageBetweenOptionalMarkAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? = nil,
    signature: FunctionSignatureSyntax,
    _ garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndInitKeyword?.raw,
      initKeyword.raw,
      garbageBetweenInitKeywordAndOptionalMark?.raw,
      optionalMark?.raw,
      garbageBetweenOptionalMarkAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      garbageBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.initializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndInitKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndInitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndInitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndInitKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndInitKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndInitKeyword`, if present.
  public func withGarbageBetweenModifiersAndInitKeyword(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndInitKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.initKeyword)
    let newData = data.replacingChild(raw, at: Cursor.initKeyword)
    return InitializerDeclSyntax(newData)
  }

  public var garbageBetweenInitKeywordAndOptionalMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInitKeywordAndOptionalMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInitKeywordAndOptionalMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInitKeywordAndOptionalMark` replaced.
  /// - param newChild: The new `garbageBetweenInitKeywordAndOptionalMark` to replace the node's
  ///                   current `garbageBetweenInitKeywordAndOptionalMark`, if present.
  public func withGarbageBetweenInitKeywordAndOptionalMark(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInitKeywordAndOptionalMark)
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

  public var garbageBetweenOptionalMarkAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOptionalMarkAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOptionalMarkAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOptionalMarkAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenOptionalMarkAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenOptionalMarkAndGenericParameterClause`, if present.
  public func withGarbageBetweenOptionalMarkAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOptionalMarkAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndSignature,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndSignature` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndSignature` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndSignature`, if present.
  public func withGarbageBetweenGenericParameterClauseAndSignature(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndSignature)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionSignature)
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return InitializerDeclSyntax(newData)
  }

  public var garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSignatureAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSignatureAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSignatureAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenSignatureAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenSignatureAndGenericWhereClause`, if present.
  public func withGarbageBetweenSignatureAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSignatureAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndBody` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndBody` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndBody`, if present.
  public func withGarbageBetweenGenericWhereClauseAndBody(
    _ newChild: GarbageNodesSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndBody)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is FunctionSignatureSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(FunctionSignatureSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is CodeBlockSyntax or missing
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension InitializerDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndInitKeyword": garbageBetweenModifiersAndInitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initKeyword": Syntax(initKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenInitKeywordAndOptionalMark": garbageBetweenInitKeywordAndOptionalMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "optionalMark": optionalMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenOptionalMarkAndGenericParameterClause": garbageBetweenOptionalMarkAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndSignature": garbageBetweenGenericParameterClauseAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": Syntax(signature).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSignatureAndGenericWhereClause": garbageBetweenSignatureAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndBody": garbageBetweenGenericWhereClauseAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeinitializerDeclSyntax

public struct DeinitializerDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndDeinitKeyword
    case deinitKeyword
    case garbageBetweenDeinitKeywordAndBody
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndDeinitKeyword: GarbageNodesSyntax? = nil,
    deinitKeyword: TokenSyntax,
    _ garbageBetweenDeinitKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndDeinitKeyword?.raw,
      deinitKeyword.raw,
      garbageBetweenDeinitKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deinitializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndDeinitKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndDeinitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndDeinitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndDeinitKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndDeinitKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndDeinitKeyword`, if present.
  public func withGarbageBetweenModifiersAndDeinitKeyword(
    _ newChild: GarbageNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndDeinitKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.deinitKeyword)
    let newData = data.replacingChild(raw, at: Cursor.deinitKeyword)
    return DeinitializerDeclSyntax(newData)
  }

  public var garbageBetweenDeinitKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenDeinitKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenDeinitKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenDeinitKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenDeinitKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenDeinitKeywordAndBody`, if present.
  public func withGarbageBetweenDeinitKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenDeinitKeywordAndBody)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is CodeBlockSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension DeinitializerDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndDeinitKeyword": garbageBetweenModifiersAndDeinitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "deinitKeyword": Syntax(deinitKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenDeinitKeywordAndBody": garbageBetweenDeinitKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptDeclSyntax

public struct SubscriptDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndSubscriptKeyword
    case subscriptKeyword
    case garbageBetweenSubscriptKeywordAndGenericParameterClause
    case genericParameterClause
    case garbageBetweenGenericParameterClauseAndIndices
    case indices
    case garbageBetweenIndicesAndResult
    case result
    case garbageBetweenResultAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndAccessor
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndSubscriptKeyword: GarbageNodesSyntax? = nil,
    subscriptKeyword: TokenSyntax,
    _ garbageBetweenSubscriptKeywordAndGenericParameterClause: GarbageNodesSyntax? = nil,
    genericParameterClause: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndIndices: GarbageNodesSyntax? = nil,
    indices: ParameterClauseSyntax,
    _ garbageBetweenIndicesAndResult: GarbageNodesSyntax? = nil,
    result: ReturnClauseSyntax,
    _ garbageBetweenResultAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndAccessor: GarbageNodesSyntax? = nil,
    accessor: Syntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndSubscriptKeyword?.raw,
      subscriptKeyword.raw,
      garbageBetweenSubscriptKeywordAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndIndices?.raw,
      indices.raw,
      garbageBetweenIndicesAndResult?.raw,
      result.raw,
      garbageBetweenResultAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndAccessor?.raw,
      accessor?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndSubscriptKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndSubscriptKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndSubscriptKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndSubscriptKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndSubscriptKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndSubscriptKeyword`, if present.
  public func withGarbageBetweenModifiersAndSubscriptKeyword(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndSubscriptKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.subscriptKeyword)
    let newData = data.replacingChild(raw, at: Cursor.subscriptKeyword)
    return SubscriptDeclSyntax(newData)
  }

  public var garbageBetweenSubscriptKeywordAndGenericParameterClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSubscriptKeywordAndGenericParameterClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSubscriptKeywordAndGenericParameterClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSubscriptKeywordAndGenericParameterClause` replaced.
  /// - param newChild: The new `garbageBetweenSubscriptKeywordAndGenericParameterClause` to replace the node's
  ///                   current `garbageBetweenSubscriptKeywordAndGenericParameterClause`, if present.
  public func withGarbageBetweenSubscriptKeywordAndGenericParameterClause(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSubscriptKeywordAndGenericParameterClause)
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

  public var garbageBetweenGenericParameterClauseAndIndices: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParameterClauseAndIndices,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParameterClauseAndIndices(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParameterClauseAndIndices` replaced.
  /// - param newChild: The new `garbageBetweenGenericParameterClauseAndIndices` to replace the node's
  ///                   current `garbageBetweenGenericParameterClauseAndIndices`, if present.
  public func withGarbageBetweenGenericParameterClauseAndIndices(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParameterClauseAndIndices)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.parameterClause)
    let newData = data.replacingChild(raw, at: Cursor.indices)
    return SubscriptDeclSyntax(newData)
  }

  public var garbageBetweenIndicesAndResult: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIndicesAndResult,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIndicesAndResult(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIndicesAndResult` replaced.
  /// - param newChild: The new `garbageBetweenIndicesAndResult` to replace the node's
  ///                   current `garbageBetweenIndicesAndResult`, if present.
  public func withGarbageBetweenIndicesAndResult(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIndicesAndResult)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.returnClause)
    let newData = data.replacingChild(raw, at: Cursor.result)
    return SubscriptDeclSyntax(newData)
  }

  public var garbageBetweenResultAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenResultAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenResultAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenResultAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenResultAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenResultAndGenericWhereClause`, if present.
  public func withGarbageBetweenResultAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenResultAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndAccessor: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndAccessor,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndAccessor(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndAccessor` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndAccessor` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndAccessor`, if present.
  public func withGarbageBetweenGenericWhereClauseAndAccessor(
    _ newChild: GarbageNodesSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndAccessor)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is ParameterClauseSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is ReturnClauseSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ReturnClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is Syntax or missing
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension SubscriptDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndSubscriptKeyword": garbageBetweenModifiersAndSubscriptKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "subscriptKeyword": Syntax(subscriptKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSubscriptKeywordAndGenericParameterClause": garbageBetweenSubscriptKeywordAndGenericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameterClause": genericParameterClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParameterClauseAndIndices": garbageBetweenGenericParameterClauseAndIndices.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "indices": Syntax(indices).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIndicesAndResult": garbageBetweenIndicesAndResult.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "result": Syntax(result).asProtocol(SyntaxProtocol.self),
      "garbageBetweenResultAndGenericWhereClause": garbageBetweenResultAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndAccessor": garbageBetweenGenericWhereClauseAndAccessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessor": accessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImportDeclSyntax

public struct ImportDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndImportTok
    case importTok
    case garbageBetweenImportTokAndImportKind
    case importKind
    case garbageBetweenImportKindAndPath
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndImportTok: GarbageNodesSyntax? = nil,
    importTok: TokenSyntax,
    _ garbageBetweenImportTokAndImportKind: GarbageNodesSyntax? = nil,
    importKind: TokenSyntax?,
    _ garbageBetweenImportKindAndPath: GarbageNodesSyntax? = nil,
    path: AccessPathSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndImportTok?.raw,
      importTok.raw,
      garbageBetweenImportTokAndImportKind?.raw,
      importKind?.raw,
      garbageBetweenImportKindAndPath?.raw,
      path.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.importDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndImportTok: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndImportTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndImportTok(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndImportTok` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndImportTok` to replace the node's
  ///                   current `garbageBetweenModifiersAndImportTok`, if present.
  public func withGarbageBetweenModifiersAndImportTok(
    _ newChild: GarbageNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndImportTok)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.importKeyword)
    let newData = data.replacingChild(raw, at: Cursor.importTok)
    return ImportDeclSyntax(newData)
  }

  public var garbageBetweenImportTokAndImportKind: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenImportTokAndImportKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenImportTokAndImportKind(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenImportTokAndImportKind` replaced.
  /// - param newChild: The new `garbageBetweenImportTokAndImportKind` to replace the node's
  ///                   current `garbageBetweenImportTokAndImportKind`, if present.
  public func withGarbageBetweenImportTokAndImportKind(
    _ newChild: GarbageNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenImportTokAndImportKind)
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

  public var garbageBetweenImportKindAndPath: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenImportKindAndPath,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenImportKindAndPath(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenImportKindAndPath` replaced.
  /// - param newChild: The new `garbageBetweenImportKindAndPath` to replace the node's
  ///                   current `garbageBetweenImportKindAndPath`, if present.
  public func withGarbageBetweenImportKindAndPath(
    _ newChild: GarbageNodesSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenImportKindAndPath)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 10)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is AccessPathSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AccessPathSyntax.self))
    }
  }
}

extension ImportDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndImportTok": garbageBetweenModifiersAndImportTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "importTok": Syntax(importTok).asProtocol(SyntaxProtocol.self),
      "garbageBetweenImportTokAndImportKind": garbageBetweenImportTokAndImportKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "importKind": importKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenImportKindAndPath": garbageBetweenImportKindAndPath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "path": Syntax(path).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AccessorDeclSyntax

public struct AccessorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifier
    case modifier
    case garbageBetweenModifierAndAccessorKind
    case accessorKind
    case garbageBetweenAccessorKindAndParameter
    case parameter
    case garbageBetweenParameterAndAsyncKeyword
    case asyncKeyword
    case garbageBetweenAsyncKeywordAndThrowsKeyword
    case throwsKeyword
    case garbageBetweenThrowsKeywordAndBody
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifier: GarbageNodesSyntax? = nil,
    modifier: DeclModifierSyntax?,
    _ garbageBetweenModifierAndAccessorKind: GarbageNodesSyntax? = nil,
    accessorKind: TokenSyntax,
    _ garbageBetweenAccessorKindAndParameter: GarbageNodesSyntax? = nil,
    parameter: AccessorParameterSyntax?,
    _ garbageBetweenParameterAndAsyncKeyword: GarbageNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsKeyword: GarbageNodesSyntax? = nil,
    throwsKeyword: TokenSyntax?,
    _ garbageBetweenThrowsKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifier?.raw,
      modifier?.raw,
      garbageBetweenModifierAndAccessorKind?.raw,
      accessorKind.raw,
      garbageBetweenAccessorKindAndParameter?.raw,
      parameter?.raw,
      garbageBetweenParameterAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsKeyword?.raw,
      throwsKeyword?.raw,
      garbageBetweenThrowsKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifier` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifier` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifier`, if present.
  public func withGarbageBetweenAttributesAndModifier(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifier)
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

  public var garbageBetweenModifierAndAccessorKind: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifierAndAccessorKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifierAndAccessorKind(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifierAndAccessorKind` replaced.
  /// - param newChild: The new `garbageBetweenModifierAndAccessorKind` to replace the node's
  ///                   current `garbageBetweenModifierAndAccessorKind`, if present.
  public func withGarbageBetweenModifierAndAccessorKind(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifierAndAccessorKind)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.accessorKind)
    return AccessorDeclSyntax(newData)
  }

  public var garbageBetweenAccessorKindAndParameter: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAccessorKindAndParameter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAccessorKindAndParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAccessorKindAndParameter` replaced.
  /// - param newChild: The new `garbageBetweenAccessorKindAndParameter` to replace the node's
  ///                   current `garbageBetweenAccessorKindAndParameter`, if present.
  public func withGarbageBetweenAccessorKindAndParameter(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAccessorKindAndParameter)
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

  public var garbageBetweenParameterAndAsyncKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenParameterAndAsyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenParameterAndAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenParameterAndAsyncKeyword` replaced.
  /// - param newChild: The new `garbageBetweenParameterAndAsyncKeyword` to replace the node's
  ///                   current `garbageBetweenParameterAndAsyncKeyword`, if present.
  public func withGarbageBetweenParameterAndAsyncKeyword(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenParameterAndAsyncKeyword)
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

  public var garbageBetweenAsyncKeywordAndThrowsKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAsyncKeywordAndThrowsKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAsyncKeywordAndThrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAsyncKeywordAndThrowsKeyword` replaced.
  /// - param newChild: The new `garbageBetweenAsyncKeywordAndThrowsKeyword` to replace the node's
  ///                   current `garbageBetweenAsyncKeywordAndThrowsKeyword`, if present.
  public func withGarbageBetweenAsyncKeywordAndThrowsKeyword(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAsyncKeywordAndThrowsKeyword)
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

  public var garbageBetweenThrowsKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenThrowsKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenThrowsKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenThrowsKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenThrowsKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenThrowsKeywordAndBody`, if present.
  public func withGarbageBetweenThrowsKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenThrowsKeywordAndBody)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 14)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is DeclModifierSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclModifierSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is AccessorParameterSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AccessorParameterSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is TokenSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TokenSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is CodeBlockSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension AccessorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifier": garbageBetweenAttributesAndModifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifier": modifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifierAndAccessorKind": garbageBetweenModifierAndAccessorKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessorKind": Syntax(accessorKind).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAccessorKindAndParameter": garbageBetweenAccessorKindAndParameter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "parameter": parameter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenParameterAndAsyncKeyword": garbageBetweenParameterAndAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAsyncKeywordAndThrowsKeyword": garbageBetweenAsyncKeywordAndThrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsKeyword": throwsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenThrowsKeywordAndBody": garbageBetweenThrowsKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": body.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - VariableDeclSyntax

public struct VariableDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndLetOrVarKeyword
    case letOrVarKeyword
    case garbageBetweenLetOrVarKeywordAndBindings
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndLetOrVarKeyword: GarbageNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ garbageBetweenLetOrVarKeywordAndBindings: GarbageNodesSyntax? = nil,
    bindings: PatternBindingListSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      garbageBetweenLetOrVarKeywordAndBindings?.raw,
      bindings.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.variableDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndLetOrVarKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndLetOrVarKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndLetOrVarKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndLetOrVarKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndLetOrVarKeyword`, if present.
  public func withGarbageBetweenModifiersAndLetOrVarKeyword(
    _ newChild: GarbageNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndLetOrVarKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.letKeyword)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return VariableDeclSyntax(newData)
  }

  public var garbageBetweenLetOrVarKeywordAndBindings: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLetOrVarKeywordAndBindings,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLetOrVarKeywordAndBindings(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLetOrVarKeywordAndBindings` replaced.
  /// - param newChild: The new `garbageBetweenLetOrVarKeywordAndBindings` to replace the node's
  ///                   current `garbageBetweenLetOrVarKeywordAndBindings`, if present.
  public func withGarbageBetweenLetOrVarKeywordAndBindings(
    _ newChild: GarbageNodesSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLetOrVarKeywordAndBindings)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is PatternBindingListSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternBindingListSyntax.self))
    }
  }
}

extension VariableDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndLetOrVarKeyword": garbageBetweenModifiersAndLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLetOrVarKeywordAndBindings": garbageBetweenLetOrVarKeywordAndBindings.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
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
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndCaseKeyword
    case caseKeyword
    case garbageBetweenCaseKeywordAndElements
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndCaseKeyword: GarbageNodesSyntax? = nil,
    caseKeyword: TokenSyntax,
    _ garbageBetweenCaseKeywordAndElements: GarbageNodesSyntax? = nil,
    elements: EnumCaseElementListSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndCaseKeyword?.raw,
      caseKeyword.raw,
      garbageBetweenCaseKeywordAndElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndCaseKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndCaseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndCaseKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndCaseKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndCaseKeyword`, if present.
  public func withGarbageBetweenModifiersAndCaseKeyword(
    _ newChild: GarbageNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndCaseKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return EnumCaseDeclSyntax(newData)
  }

  public var garbageBetweenCaseKeywordAndElements: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCaseKeywordAndElements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCaseKeywordAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCaseKeywordAndElements` replaced.
  /// - param newChild: The new `garbageBetweenCaseKeywordAndElements` to replace the node's
  ///                   current `garbageBetweenCaseKeywordAndElements`, if present.
  public func withGarbageBetweenCaseKeywordAndElements(
    _ newChild: GarbageNodesSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCaseKeywordAndElements)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is EnumCaseElementListSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(EnumCaseElementListSyntax.self))
    }
  }
}

extension EnumCaseDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndCaseKeyword": garbageBetweenModifiersAndCaseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCaseKeywordAndElements": garbageBetweenCaseKeywordAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - EnumDeclSyntax

/// A Swift `enum` declaration.
public struct EnumDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndEnumKeyword
    case enumKeyword
    case garbageBetweenEnumKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericParameters
    case genericParameters
    case garbageBetweenGenericParametersAndInheritanceClause
    case inheritanceClause
    case garbageBetweenInheritanceClauseAndGenericWhereClause
    case genericWhereClause
    case garbageBetweenGenericWhereClauseAndMembers
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndEnumKeyword: GarbageNodesSyntax? = nil,
    enumKeyword: TokenSyntax,
    _ garbageBetweenEnumKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameters: GarbageNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax?,
    _ garbageBetweenGenericParametersAndInheritanceClause: GarbageNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil,
    members: MemberDeclBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndEnumKeyword?.raw,
      enumKeyword.raw,
      garbageBetweenEnumKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameters?.raw,
      genericParameters?.raw,
      garbageBetweenGenericParametersAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndEnumKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndEnumKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndEnumKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndEnumKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndEnumKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndEnumKeyword`, if present.
  public func withGarbageBetweenModifiersAndEnumKeyword(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndEnumKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.enumKeyword)
    let newData = data.replacingChild(raw, at: Cursor.enumKeyword)
    return EnumDeclSyntax(newData)
  }

  public var garbageBetweenEnumKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenEnumKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenEnumKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenEnumKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenEnumKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenEnumKeywordAndIdentifier`, if present.
  public func withGarbageBetweenEnumKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenEnumKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EnumDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericParameters: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericParameters,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericParameters` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericParameters` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericParameters`, if present.
  public func withGarbageBetweenIdentifierAndGenericParameters(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericParameters)
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

  public var garbageBetweenGenericParametersAndInheritanceClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericParametersAndInheritanceClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericParametersAndInheritanceClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericParametersAndInheritanceClause` replaced.
  /// - param newChild: The new `garbageBetweenGenericParametersAndInheritanceClause` to replace the node's
  ///                   current `garbageBetweenGenericParametersAndInheritanceClause`, if present.
  public func withGarbageBetweenGenericParametersAndInheritanceClause(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericParametersAndInheritanceClause)
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

  public var garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInheritanceClauseAndGenericWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInheritanceClauseAndGenericWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenInheritanceClauseAndGenericWhereClause` to replace the node's
  ///                   current `garbageBetweenInheritanceClauseAndGenericWhereClause`, if present.
  public func withGarbageBetweenInheritanceClauseAndGenericWhereClause(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInheritanceClauseAndGenericWhereClause)
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

  public var garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGenericWhereClauseAndMembers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGenericWhereClauseAndMembers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGenericWhereClauseAndMembers` replaced.
  /// - param newChild: The new `garbageBetweenGenericWhereClauseAndMembers` to replace the node's
  ///                   current `garbageBetweenGenericWhereClauseAndMembers`, if present.
  public func withGarbageBetweenGenericWhereClauseAndMembers(
    _ newChild: GarbageNodesSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGenericWhereClauseAndMembers)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return EnumDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 16)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is GenericParameterClauseSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterClauseSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeInheritanceClauseSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInheritanceClauseSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is MemberDeclBlockSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclBlockSyntax.self))
    }
  }
}

extension EnumDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndEnumKeyword": garbageBetweenModifiersAndEnumKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "enumKeyword": Syntax(enumKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenEnumKeywordAndIdentifier": garbageBetweenEnumKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericParameters": garbageBetweenIdentifierAndGenericParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameters": genericParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericParametersAndInheritanceClause": garbageBetweenGenericParametersAndInheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritanceClause": inheritanceClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenInheritanceClauseAndGenericWhereClause": garbageBetweenInheritanceClauseAndGenericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericWhereClause": genericWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenGenericWhereClauseAndMembers": garbageBetweenGenericWhereClauseAndMembers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - OperatorDeclSyntax

/// A Swift `operator` declaration.
public struct OperatorDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndOperatorKeyword
    case operatorKeyword
    case garbageBetweenOperatorKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndOperatorPrecedenceAndTypes
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndOperatorKeyword: GarbageNodesSyntax? = nil,
    operatorKeyword: TokenSyntax,
    _ garbageBetweenOperatorKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: GarbageNodesSyntax? = nil,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndOperatorKeyword?.raw,
      operatorKeyword.raw,
      garbageBetweenOperatorKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw,
      operatorPrecedenceAndTypes?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.operatorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndOperatorKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndOperatorKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndOperatorKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndOperatorKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndOperatorKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndOperatorKeyword`, if present.
  public func withGarbageBetweenModifiersAndOperatorKeyword(
    _ newChild: GarbageNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndOperatorKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.operatorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.operatorKeyword)
    return OperatorDeclSyntax(newData)
  }

  public var garbageBetweenOperatorKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOperatorKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOperatorKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOperatorKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenOperatorKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenOperatorKeywordAndIdentifier`, if present.
  public func withGarbageBetweenOperatorKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOperatorKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unspacedBinaryOperator(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return OperatorDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndOperatorPrecedenceAndTypes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndOperatorPrecedenceAndTypes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndOperatorPrecedenceAndTypes` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndOperatorPrecedenceAndTypes` to replace the node's
  ///                   current `garbageBetweenIdentifierAndOperatorPrecedenceAndTypes`, if present.
  public func withGarbageBetweenIdentifierAndOperatorPrecedenceAndTypes(
    _ newChild: GarbageNodesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndOperatorPrecedenceAndTypes)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 10)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is OperatorPrecedenceAndTypesSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(OperatorPrecedenceAndTypesSyntax.self))
    }
  }
}

extension OperatorDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndOperatorKeyword": garbageBetweenModifiersAndOperatorKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorKeyword": Syntax(operatorKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenOperatorKeywordAndIdentifier": garbageBetweenOperatorKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndOperatorPrecedenceAndTypes": garbageBetweenIdentifierAndOperatorPrecedenceAndTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorPrecedenceAndTypes": operatorPrecedenceAndTypes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupDeclSyntax

/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAttributes
    case attributes
    case garbageBetweenAttributesAndModifiers
    case modifiers
    case garbageBetweenModifiersAndPrecedencegroupKeyword
    case precedencegroupKeyword
    case garbageBetweenPrecedencegroupKeywordAndIdentifier
    case identifier
    case garbageBetweenIdentifierAndLeftBrace
    case leftBrace
    case garbageBetweenLeftBraceAndGroupAttributes
    case groupAttributes
    case garbageBetweenGroupAttributesAndRightBrace
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
    _ garbageBeforeAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil,
    modifiers: ModifierListSyntax?,
    _ garbageBetweenModifiersAndPrecedencegroupKeyword: GarbageNodesSyntax? = nil,
    precedencegroupKeyword: TokenSyntax,
    _ garbageBetweenPrecedencegroupKeywordAndIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndLeftBrace: GarbageNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ garbageBetweenLeftBraceAndGroupAttributes: GarbageNodesSyntax? = nil,
    groupAttributes: PrecedenceGroupAttributeListSyntax,
    _ garbageBetweenGroupAttributesAndRightBrace: GarbageNodesSyntax? = nil,
    rightBrace: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndPrecedencegroupKeyword?.raw,
      precedencegroupKeyword.raw,
      garbageBetweenPrecedencegroupKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndGroupAttributes?.raw,
      groupAttributes.raw,
      garbageBetweenGroupAttributesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAttributes` replaced.
  /// - param newChild: The new `garbageBeforeAttributes` to replace the node's
  ///                   current `garbageBeforeAttributes`, if present.
  public func withGarbageBeforeAttributes(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAttributes)
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

  public var garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndModifiers,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndModifiers(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndModifiers` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndModifiers` to replace the node's
  ///                   current `garbageBetweenAttributesAndModifiers`, if present.
  public func withGarbageBetweenAttributesAndModifiers(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndModifiers)
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

  public var garbageBetweenModifiersAndPrecedencegroupKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenModifiersAndPrecedencegroupKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenModifiersAndPrecedencegroupKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenModifiersAndPrecedencegroupKeyword` replaced.
  /// - param newChild: The new `garbageBetweenModifiersAndPrecedencegroupKeyword` to replace the node's
  ///                   current `garbageBetweenModifiersAndPrecedencegroupKeyword`, if present.
  public func withGarbageBetweenModifiersAndPrecedencegroupKeyword(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenModifiersAndPrecedencegroupKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.precedencegroupKeyword)
    let newData = data.replacingChild(raw, at: Cursor.precedencegroupKeyword)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var garbageBetweenPrecedencegroupKeywordAndIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPrecedencegroupKeywordAndIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPrecedencegroupKeywordAndIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPrecedencegroupKeywordAndIdentifier` replaced.
  /// - param newChild: The new `garbageBetweenPrecedencegroupKeywordAndIdentifier` to replace the node's
  ///                   current `garbageBetweenPrecedencegroupKeywordAndIdentifier`, if present.
  public func withGarbageBetweenPrecedencegroupKeywordAndIdentifier(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPrecedencegroupKeywordAndIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var garbageBetweenIdentifierAndLeftBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndLeftBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndLeftBrace` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndLeftBrace` to replace the node's
  ///                   current `garbageBetweenIdentifierAndLeftBrace`, if present.
  public func withGarbageBetweenIdentifierAndLeftBrace(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndLeftBrace)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return PrecedenceGroupDeclSyntax(newData)
  }

  public var garbageBetweenLeftBraceAndGroupAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftBraceAndGroupAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftBraceAndGroupAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftBraceAndGroupAttributes` replaced.
  /// - param newChild: The new `garbageBetweenLeftBraceAndGroupAttributes` to replace the node's
  ///                   current `garbageBetweenLeftBraceAndGroupAttributes`, if present.
  public func withGarbageBetweenLeftBraceAndGroupAttributes(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftBraceAndGroupAttributes)
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

  public var garbageBetweenGroupAttributesAndRightBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGroupAttributesAndRightBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGroupAttributesAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGroupAttributesAndRightBrace` replaced.
  /// - param newChild: The new `garbageBetweenGroupAttributesAndRightBrace` to replace the node's
  ///                   current `garbageBetweenGroupAttributesAndRightBrace`, if present.
  public func withGarbageBetweenGroupAttributesAndRightBrace(
    _ newChild: GarbageNodesSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGroupAttributesAndRightBrace)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return PrecedenceGroupDeclSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 14)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is AttributeListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ModifierListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ModifierListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
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
    // Check child #6 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #7 child is TokenSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is TokenSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is PrecedenceGroupAttributeListSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PrecedenceGroupAttributeListSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is TokenSyntax 
    assert(rawChildren[13].raw != nil)
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrecedenceGroupDeclSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAttributes": garbageBeforeAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndModifiers": garbageBetweenAttributesAndModifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifiers": modifiers.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenModifiersAndPrecedencegroupKeyword": garbageBetweenModifiersAndPrecedencegroupKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "precedencegroupKeyword": Syntax(precedencegroupKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPrecedencegroupKeywordAndIdentifier": garbageBetweenPrecedencegroupKeywordAndIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndLeftBrace": garbageBetweenIdentifierAndLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftBraceAndGroupAttributes": garbageBetweenLeftBraceAndGroupAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "groupAttributes": Syntax(groupAttributes).asProtocol(SyntaxProtocol.self),
      "garbageBetweenGroupAttributesAndRightBrace": garbageBetweenGroupAttributesAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

