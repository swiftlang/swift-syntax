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


// MARK: - UnknownTypeSyntax

public struct UnknownTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnknownTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknownType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnknownTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknownType)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unknownType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }
}

extension UnknownTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - MissingTypeSyntax

public struct MissingTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missingType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingType)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.missingType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }
}

extension MissingTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - SimpleTypeIdentifierSyntax

public struct SimpleTypeIdentifierSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeName
    case name
    case garbageBetweenNameAndGenericArgumentClause
    case genericArgumentClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SimpleTypeIdentifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .simpleTypeIdentifier else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SimpleTypeIdentifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .simpleTypeIdentifier)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeName: GarbageNodesSyntax? = nil,
    name: TokenSyntax,
    _ garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.simpleTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeName` replaced.
  /// - param newChild: The new `garbageBeforeName` to replace the node's
  ///                   current `garbageBeforeName`, if present.
  public func withGarbageBeforeName(
    _ newChild: GarbageNodesSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeName)
    return SimpleTypeIdentifierSyntax(newData)
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
    _ newChild: TokenSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public var garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenNameAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenNameAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenNameAndGenericArgumentClause` replaced.
  /// - param newChild: The new `garbageBetweenNameAndGenericArgumentClause` to replace the node's
  ///                   current `garbageBetweenNameAndGenericArgumentClause`, if present.
  public func withGarbageBetweenNameAndGenericArgumentClause(
    _ newChild: GarbageNodesSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenNameAndGenericArgumentClause)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SimpleTypeIdentifierSyntax(newData)
  }
}

extension SimpleTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeName": garbageBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "garbageBetweenNameAndGenericArgumentClause": garbageBetweenNameAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberTypeIdentifierSyntax

public struct MemberTypeIdentifierSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBaseType
    case baseType
    case garbageBetweenBaseTypeAndPeriod
    case period
    case garbageBetweenPeriodAndName
    case name
    case garbageBetweenNameAndGenericArgumentClause
    case genericArgumentClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MemberTypeIdentifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .memberTypeIdentifier else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MemberTypeIdentifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberTypeIdentifier)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBaseType: GarbageNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? = nil,
    period: TokenSyntax,
    _ garbageBetweenPeriodAndName: GarbageNodesSyntax? = nil,
    name: TokenSyntax,
    _ garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBaseType?.raw,
      baseType.raw,
      garbageBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      garbageBetweenPeriodAndName?.raw,
      name.raw,
      garbageBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBaseType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBaseType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBaseType` replaced.
  /// - param newChild: The new `garbageBeforeBaseType` to replace the node's
  ///                   current `garbageBeforeBaseType`, if present.
  public func withGarbageBeforeBaseType(
    _ newChild: GarbageNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBaseType)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBaseTypeAndPeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBaseTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBaseTypeAndPeriod` replaced.
  /// - param newChild: The new `garbageBetweenBaseTypeAndPeriod` to replace the node's
  ///                   current `garbageBetweenBaseTypeAndPeriod`, if present.
  public func withGarbageBetweenBaseTypeAndPeriod(
    _ newChild: GarbageNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBaseTypeAndPeriod)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.period,
                                 parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var garbageBetweenPeriodAndName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPeriodAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPeriodAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPeriodAndName` replaced.
  /// - param newChild: The new `garbageBetweenPeriodAndName` to replace the node's
  ///                   current `garbageBetweenPeriodAndName`, if present.
  public func withGarbageBetweenPeriodAndName(
    _ newChild: GarbageNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPeriodAndName)
    return MemberTypeIdentifierSyntax(newData)
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
    _ newChild: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenNameAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenNameAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenNameAndGenericArgumentClause` replaced.
  /// - param newChild: The new `garbageBetweenNameAndGenericArgumentClause` to replace the node's
  ///                   current `garbageBetweenNameAndGenericArgumentClause`, if present.
  public func withGarbageBetweenNameAndGenericArgumentClause(
    _ newChild: GarbageNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenNameAndGenericArgumentClause)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return MemberTypeIdentifierSyntax(newData)
  }
}

extension MemberTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBaseType": garbageBeforeBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBaseTypeAndPeriod": garbageBetweenBaseTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPeriodAndName": garbageBetweenPeriodAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "garbageBetweenNameAndGenericArgumentClause": garbageBetweenNameAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClassRestrictionTypeSyntax

public struct ClassRestrictionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeClassKeyword
    case classKeyword
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClassRestrictionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .classRestrictionType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClassRestrictionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .classRestrictionType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeClassKeyword: GarbageNodesSyntax? = nil,
    classKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeClassKeyword?.raw,
      classKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classRestrictionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeClassKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeClassKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeClassKeyword` replaced.
  /// - param newChild: The new `garbageBeforeClassKeyword` to replace the node's
  ///                   current `garbageBeforeClassKeyword`, if present.
  public func withGarbageBeforeClassKeyword(
    _ newChild: GarbageNodesSyntax?) -> ClassRestrictionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeClassKeyword)
    return ClassRestrictionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ClassRestrictionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.classKeyword)
    let newData = data.replacingChild(raw, at: Cursor.classKeyword)
    return ClassRestrictionTypeSyntax(newData)
  }
}

extension ClassRestrictionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeClassKeyword": garbageBeforeClassKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "classKeyword": Syntax(classKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrayTypeSyntax

public struct ArrayTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftSquareBracket
    case leftSquareBracket
    case garbageBetweenLeftSquareBracketAndElementType
    case elementType
    case garbageBetweenElementTypeAndRightSquareBracket
    case rightSquareBracket
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ArrayTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .arrayType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ArrayTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrayType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftSquareBracket: GarbageNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax,
    _ garbageBetweenLeftSquareBracketAndElementType: GarbageNodesSyntax? = nil,
    elementType: TypeSyntax,
    _ garbageBetweenElementTypeAndRightSquareBracket: GarbageNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      garbageBetweenLeftSquareBracketAndElementType?.raw,
      elementType.raw,
      garbageBetweenElementTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftSquareBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftSquareBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftSquareBracket` replaced.
  /// - param newChild: The new `garbageBeforeLeftSquareBracket` to replace the node's
  ///                   current `garbageBeforeLeftSquareBracket`, if present.
  public func withGarbageBeforeLeftSquareBracket(
    _ newChild: GarbageNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftSquareBracket)
    return ArrayTypeSyntax(newData)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquareBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var garbageBetweenLeftSquareBracketAndElementType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftSquareBracketAndElementType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftSquareBracketAndElementType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftSquareBracketAndElementType` replaced.
  /// - param newChild: The new `garbageBetweenLeftSquareBracketAndElementType` to replace the node's
  ///                   current `garbageBetweenLeftSquareBracketAndElementType`, if present.
  public func withGarbageBetweenLeftSquareBracketAndElementType(
    _ newChild: GarbageNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftSquareBracketAndElementType)
    return ArrayTypeSyntax(newData)
  }

  public var elementType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.elementType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.elementType)
    return ArrayTypeSyntax(newData)
  }

  public var garbageBetweenElementTypeAndRightSquareBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElementTypeAndRightSquareBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElementTypeAndRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElementTypeAndRightSquareBracket` replaced.
  /// - param newChild: The new `garbageBetweenElementTypeAndRightSquareBracket` to replace the node's
  ///                   current `garbageBetweenElementTypeAndRightSquareBracket`, if present.
  public func withGarbageBetweenElementTypeAndRightSquareBracket(
    _ newChild: GarbageNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElementTypeAndRightSquareBracket)
    return ArrayTypeSyntax(newData)
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquareBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
}

extension ArrayTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftSquareBracket": garbageBeforeLeftSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftSquareBracketAndElementType": garbageBetweenLeftSquareBracketAndElementType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elementType": Syntax(elementType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenElementTypeAndRightSquareBracket": garbageBetweenElementTypeAndRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DictionaryTypeSyntax

public struct DictionaryTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftSquareBracket
    case leftSquareBracket
    case garbageBetweenLeftSquareBracketAndKeyType
    case keyType
    case garbageBetweenKeyTypeAndColon
    case colon
    case garbageBetweenColonAndValueType
    case valueType
    case garbageBetweenValueTypeAndRightSquareBracket
    case rightSquareBracket
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DictionaryTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .dictionaryType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DictionaryTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dictionaryType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftSquareBracket: GarbageNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax,
    _ garbageBetweenLeftSquareBracketAndKeyType: GarbageNodesSyntax? = nil,
    keyType: TypeSyntax,
    _ garbageBetweenKeyTypeAndColon: GarbageNodesSyntax? = nil,
    colon: TokenSyntax,
    _ garbageBetweenColonAndValueType: GarbageNodesSyntax? = nil,
    valueType: TypeSyntax,
    _ garbageBetweenValueTypeAndRightSquareBracket: GarbageNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      garbageBetweenLeftSquareBracketAndKeyType?.raw,
      keyType.raw,
      garbageBetweenKeyTypeAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValueType?.raw,
      valueType.raw,
      garbageBetweenValueTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftSquareBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftSquareBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftSquareBracket` replaced.
  /// - param newChild: The new `garbageBeforeLeftSquareBracket` to replace the node's
  ///                   current `garbageBeforeLeftSquareBracket`, if present.
  public func withGarbageBeforeLeftSquareBracket(
    _ newChild: GarbageNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftSquareBracket)
    return DictionaryTypeSyntax(newData)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquareBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var garbageBetweenLeftSquareBracketAndKeyType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftSquareBracketAndKeyType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftSquareBracketAndKeyType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftSquareBracketAndKeyType` replaced.
  /// - param newChild: The new `garbageBetweenLeftSquareBracketAndKeyType` to replace the node's
  ///                   current `garbageBetweenLeftSquareBracketAndKeyType`, if present.
  public func withGarbageBetweenLeftSquareBracketAndKeyType(
    _ newChild: GarbageNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftSquareBracketAndKeyType)
    return DictionaryTypeSyntax(newData)
  }

  public var keyType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.keyType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.keyType)
    return DictionaryTypeSyntax(newData)
  }

  public var garbageBetweenKeyTypeAndColon: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenKeyTypeAndColon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenKeyTypeAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenKeyTypeAndColon` replaced.
  /// - param newChild: The new `garbageBetweenKeyTypeAndColon` to replace the node's
  ///                   current `garbageBetweenKeyTypeAndColon`, if present.
  public func withGarbageBetweenKeyTypeAndColon(
    _ newChild: GarbageNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenKeyTypeAndColon)
    return DictionaryTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DictionaryTypeSyntax(newData)
  }

  public var garbageBetweenColonAndValueType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenColonAndValueType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenColonAndValueType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenColonAndValueType` replaced.
  /// - param newChild: The new `garbageBetweenColonAndValueType` to replace the node's
  ///                   current `garbageBetweenColonAndValueType`, if present.
  public func withGarbageBetweenColonAndValueType(
    _ newChild: GarbageNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenColonAndValueType)
    return DictionaryTypeSyntax(newData)
  }

  public var valueType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.valueType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.valueType)
    return DictionaryTypeSyntax(newData)
  }

  public var garbageBetweenValueTypeAndRightSquareBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenValueTypeAndRightSquareBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenValueTypeAndRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenValueTypeAndRightSquareBracket` replaced.
  /// - param newChild: The new `garbageBetweenValueTypeAndRightSquareBracket` to replace the node's
  ///                   current `garbageBetweenValueTypeAndRightSquareBracket`, if present.
  public func withGarbageBetweenValueTypeAndRightSquareBracket(
    _ newChild: GarbageNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenValueTypeAndRightSquareBracket)
    return DictionaryTypeSyntax(newData)
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquareBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
}

extension DictionaryTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftSquareBracket": garbageBeforeLeftSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftSquareBracketAndKeyType": garbageBetweenLeftSquareBracketAndKeyType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "keyType": Syntax(keyType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenKeyTypeAndColon": garbageBetweenKeyTypeAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "garbageBetweenColonAndValueType": garbageBetweenColonAndValueType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valueType": Syntax(valueType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenValueTypeAndRightSquareBracket": garbageBetweenValueTypeAndRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MetatypeTypeSyntax

public struct MetatypeTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBaseType
    case baseType
    case garbageBetweenBaseTypeAndPeriod
    case period
    case garbageBetweenPeriodAndTypeOrProtocol
    case typeOrProtocol
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MetatypeTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .metatypeType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MetatypeTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .metatypeType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBaseType: GarbageNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? = nil,
    period: TokenSyntax,
    _ garbageBetweenPeriodAndTypeOrProtocol: GarbageNodesSyntax? = nil,
    typeOrProtocol: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBaseType?.raw,
      baseType.raw,
      garbageBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      garbageBetweenPeriodAndTypeOrProtocol?.raw,
      typeOrProtocol.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.metatypeType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBaseType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBaseType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBaseType` replaced.
  /// - param newChild: The new `garbageBeforeBaseType` to replace the node's
  ///                   current `garbageBeforeBaseType`, if present.
  public func withGarbageBeforeBaseType(
    _ newChild: GarbageNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBaseType)
    return MetatypeTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return MetatypeTypeSyntax(newData)
  }

  public var garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBaseTypeAndPeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBaseTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBaseTypeAndPeriod` replaced.
  /// - param newChild: The new `garbageBetweenBaseTypeAndPeriod` to replace the node's
  ///                   current `garbageBetweenBaseTypeAndPeriod`, if present.
  public func withGarbageBetweenBaseTypeAndPeriod(
    _ newChild: GarbageNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBaseTypeAndPeriod)
    return MetatypeTypeSyntax(newData)
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.period,
                                 parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return MetatypeTypeSyntax(newData)
  }

  public var garbageBetweenPeriodAndTypeOrProtocol: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPeriodAndTypeOrProtocol,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPeriodAndTypeOrProtocol(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPeriodAndTypeOrProtocol` replaced.
  /// - param newChild: The new `garbageBetweenPeriodAndTypeOrProtocol` to replace the node's
  ///                   current `garbageBetweenPeriodAndTypeOrProtocol`, if present.
  public func withGarbageBetweenPeriodAndTypeOrProtocol(
    _ newChild: GarbageNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPeriodAndTypeOrProtocol)
    return MetatypeTypeSyntax(newData)
  }

  public var typeOrProtocol: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.typeOrProtocol,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
}

extension MetatypeTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBaseType": garbageBeforeBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBaseTypeAndPeriod": garbageBetweenBaseTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPeriodAndTypeOrProtocol": garbageBetweenPeriodAndTypeOrProtocol.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeOrProtocol": Syntax(typeOrProtocol).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - OptionalTypeSyntax

public struct OptionalTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeWrappedType
    case wrappedType
    case garbageBetweenWrappedTypeAndQuestionMark
    case questionMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OptionalTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .optionalType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OptionalTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeWrappedType: GarbageNodesSyntax? = nil,
    wrappedType: TypeSyntax,
    _ garbageBetweenWrappedTypeAndQuestionMark: GarbageNodesSyntax? = nil,
    questionMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeWrappedType?.raw,
      wrappedType.raw,
      garbageBetweenWrappedTypeAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeWrappedType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeWrappedType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeWrappedType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeWrappedType` replaced.
  /// - param newChild: The new `garbageBeforeWrappedType` to replace the node's
  ///                   current `garbageBeforeWrappedType`, if present.
  public func withGarbageBeforeWrappedType(
    _ newChild: GarbageNodesSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeWrappedType)
    return OptionalTypeSyntax(newData)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.wrappedType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.wrappedType)
    return OptionalTypeSyntax(newData)
  }

  public var garbageBetweenWrappedTypeAndQuestionMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWrappedTypeAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWrappedTypeAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWrappedTypeAndQuestionMark` replaced.
  /// - param newChild: The new `garbageBetweenWrappedTypeAndQuestionMark` to replace the node's
  ///                   current `garbageBetweenWrappedTypeAndQuestionMark`, if present.
  public func withGarbageBetweenWrappedTypeAndQuestionMark(
    _ newChild: GarbageNodesSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWrappedTypeAndQuestionMark)
    return OptionalTypeSyntax(newData)
  }

  public var questionMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.questionMark,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
}

extension OptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeWrappedType": garbageBeforeWrappedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenWrappedTypeAndQuestionMark": garbageBetweenWrappedTypeAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ConstrainedSugarTypeSyntax

public struct ConstrainedSugarTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeSomeOrAnySpecifier
    case someOrAnySpecifier
    case garbageBetweenSomeOrAnySpecifierAndBaseType
    case baseType
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ConstrainedSugarTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .constrainedSugarType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ConstrainedSugarTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .constrainedSugarType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeSomeOrAnySpecifier: GarbageNodesSyntax? = nil,
    someOrAnySpecifier: TokenSyntax,
    _ garbageBetweenSomeOrAnySpecifierAndBaseType: GarbageNodesSyntax? = nil,
    baseType: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeSomeOrAnySpecifier?.raw,
      someOrAnySpecifier.raw,
      garbageBetweenSomeOrAnySpecifierAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.constrainedSugarType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeSomeOrAnySpecifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeSomeOrAnySpecifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeSomeOrAnySpecifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeSomeOrAnySpecifier` replaced.
  /// - param newChild: The new `garbageBeforeSomeOrAnySpecifier` to replace the node's
  ///                   current `garbageBeforeSomeOrAnySpecifier`, if present.
  public func withGarbageBeforeSomeOrAnySpecifier(
    _ newChild: GarbageNodesSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeSomeOrAnySpecifier)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var someOrAnySpecifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.someOrAnySpecifier,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSomeOrAnySpecifier(value)
    }
  }

  /// Returns a copy of the receiver with its `someOrAnySpecifier` replaced.
  /// - param newChild: The new `someOrAnySpecifier` to replace the node's
  ///                   current `someOrAnySpecifier`, if present.
  public func withSomeOrAnySpecifier(
    _ newChild: TokenSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.someOrAnySpecifier)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var garbageBetweenSomeOrAnySpecifierAndBaseType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSomeOrAnySpecifierAndBaseType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSomeOrAnySpecifierAndBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSomeOrAnySpecifierAndBaseType` replaced.
  /// - param newChild: The new `garbageBetweenSomeOrAnySpecifierAndBaseType` to replace the node's
  ///                   current `garbageBetweenSomeOrAnySpecifierAndBaseType`, if present.
  public func withGarbageBetweenSomeOrAnySpecifierAndBaseType(
    _ newChild: GarbageNodesSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSomeOrAnySpecifierAndBaseType)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return ConstrainedSugarTypeSyntax(newData)
  }
}

extension ConstrainedSugarTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeSomeOrAnySpecifier": garbageBeforeSomeOrAnySpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "someOrAnySpecifier": Syntax(someOrAnySpecifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSomeOrAnySpecifierAndBaseType": garbageBetweenSomeOrAnySpecifierAndBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ImplicitlyUnwrappedOptionalTypeSyntax

public struct ImplicitlyUnwrappedOptionalTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeWrappedType
    case wrappedType
    case garbageBetweenWrappedTypeAndExclamationMark
    case exclamationMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ImplicitlyUnwrappedOptionalTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .implicitlyUnwrappedOptionalType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .implicitlyUnwrappedOptionalType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeWrappedType: GarbageNodesSyntax? = nil,
    wrappedType: TypeSyntax,
    _ garbageBetweenWrappedTypeAndExclamationMark: GarbageNodesSyntax? = nil,
    exclamationMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeWrappedType?.raw,
      wrappedType.raw,
      garbageBetweenWrappedTypeAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeWrappedType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeWrappedType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeWrappedType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeWrappedType` replaced.
  /// - param newChild: The new `garbageBeforeWrappedType` to replace the node's
  ///                   current `garbageBeforeWrappedType`, if present.
  public func withGarbageBeforeWrappedType(
    _ newChild: GarbageNodesSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeWrappedType)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.wrappedType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.wrappedType)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var garbageBetweenWrappedTypeAndExclamationMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWrappedTypeAndExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWrappedTypeAndExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWrappedTypeAndExclamationMark` replaced.
  /// - param newChild: The new `garbageBetweenWrappedTypeAndExclamationMark` to replace the node's
  ///                   current `garbageBetweenWrappedTypeAndExclamationMark`, if present.
  public func withGarbageBetweenWrappedTypeAndExclamationMark(
    _ newChild: GarbageNodesSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWrappedTypeAndExclamationMark)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var exclamationMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.exclamationMark,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
}

extension ImplicitlyUnwrappedOptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeWrappedType": garbageBeforeWrappedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self),
      "garbageBetweenWrappedTypeAndExclamationMark": garbageBetweenWrappedTypeAndExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - CompositionTypeSyntax

public struct CompositionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeElements
    case elements
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CompositionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .compositionType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CompositionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .compositionType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeElements: GarbageNodesSyntax? = nil,
    elements: CompositionTypeElementListSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeElements: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeElements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeElements(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeElements` replaced.
  /// - param newChild: The new `garbageBeforeElements` to replace the node's
  ///                   current `garbageBeforeElements`, if present.
  public func withGarbageBeforeElements(
    _ newChild: GarbageNodesSyntax?) -> CompositionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeElements)
    return CompositionTypeSyntax(newData)
  }

  public var elements: CompositionTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
      return CompositionTypeElementListSyntax(childData!)
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
  public func addElement(_ element: CompositionTypeElementSyntax) -> CompositionTypeSyntax {
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
}

extension CompositionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeElements": garbageBeforeElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TupleTypeSyntax

public struct TupleTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftParen
    case leftParen
    case garbageBetweenLeftParenAndElements
    case elements
    case garbageBetweenElementsAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TupleTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tupleType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TupleTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndElements: GarbageNodesSyntax? = nil,
    elements: TupleTypeElementListSyntax,
    _ garbageBetweenElementsAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElements?.raw,
      elements.raw,
      garbageBetweenElementsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftParen` replaced.
  /// - param newChild: The new `garbageBeforeLeftParen` to replace the node's
  ///                   current `garbageBeforeLeftParen`, if present.
  public func withGarbageBeforeLeftParen(
    _ newChild: GarbageNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftParen)
    return TupleTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TupleTypeSyntax(newData)
  }

  public var garbageBetweenLeftParenAndElements: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndElements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndElements` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndElements` to replace the node's
  ///                   current `garbageBetweenLeftParenAndElements`, if present.
  public func withGarbageBetweenLeftParenAndElements(
    _ newChild: GarbageNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndElements)
    return TupleTypeSyntax(newData)
  }

  public var elements: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
      return TupleTypeElementListSyntax(childData!)
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
  public func addElement(_ element: TupleTypeElementSyntax) -> TupleTypeSyntax {
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

  public var garbageBetweenElementsAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElementsAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElementsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElementsAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenElementsAndRightParen` to replace the node's
  ///                   current `garbageBetweenElementsAndRightParen`, if present.
  public func withGarbageBetweenElementsAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElementsAndRightParen)
    return TupleTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TupleTypeSyntax(newData)
  }
}

extension TupleTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftParen": garbageBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndElements": garbageBetweenLeftParenAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "garbageBetweenElementsAndRightParen": garbageBetweenElementsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionTypeSyntax

public struct FunctionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftParen
    case leftParen
    case garbageBetweenLeftParenAndArguments
    case arguments
    case garbageBetweenArgumentsAndRightParen
    case rightParen
    case garbageBetweenRightParenAndAsyncKeyword
    case asyncKeyword
    case garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword
    case throwsOrRethrowsKeyword
    case garbageBetweenThrowsOrRethrowsKeywordAndArrow
    case arrow
    case garbageBetweenArrowAndReturnType
    case returnType
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? = nil,
    arguments: TupleTypeElementListSyntax,
    _ garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ garbageBetweenRightParenAndAsyncKeyword: GarbageNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodesSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax?,
    _ garbageBetweenThrowsOrRethrowsKeywordAndArrow: GarbageNodesSyntax? = nil,
    arrow: TokenSyntax,
    _ garbageBetweenArrowAndReturnType: GarbageNodesSyntax? = nil,
    returnType: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      garbageBetweenRightParenAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      garbageBetweenThrowsOrRethrowsKeywordAndArrow?.raw,
      arrow.raw,
      garbageBetweenArrowAndReturnType?.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftParen` replaced.
  /// - param newChild: The new `garbageBeforeLeftParen` to replace the node's
  ///                   current `garbageBeforeLeftParen`, if present.
  public func withGarbageBeforeLeftParen(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftParen)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return FunctionTypeSyntax(newData)
  }

  public var garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndArguments` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndArguments` to replace the node's
  ///                   current `garbageBetweenLeftParenAndArguments`, if present.
  public func withGarbageBetweenLeftParenAndArguments(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndArguments)
    return FunctionTypeSyntax(newData)
  }

  public var arguments: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      return TupleTypeElementListSyntax(childData!)
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
  public func addArgument(_ element: TupleTypeElementSyntax) -> FunctionTypeSyntax {
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

  public var garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenArgumentsAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenArgumentsAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenArgumentsAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenArgumentsAndRightParen` to replace the node's
  ///                   current `garbageBetweenArgumentsAndRightParen`, if present.
  public func withGarbageBetweenArgumentsAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArgumentsAndRightParen)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return FunctionTypeSyntax(newData)
  }

  public var garbageBetweenRightParenAndAsyncKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenRightParenAndAsyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenRightParenAndAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenRightParenAndAsyncKeyword` replaced.
  /// - param newChild: The new `garbageBetweenRightParenAndAsyncKeyword` to replace the node's
  ///                   current `garbageBetweenRightParenAndAsyncKeyword`, if present.
  public func withGarbageBetweenRightParenAndAsyncKeyword(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenRightParenAndAsyncKeyword)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.asyncKeyword)
    return FunctionTypeSyntax(newData)
  }

  public var garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword` to replace the node's
  ///                   current `garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword`, if present.
  public func withGarbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsOrRethrowsKeyword)
    return FunctionTypeSyntax(newData)
  }

  public var garbageBetweenThrowsOrRethrowsKeywordAndArrow: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenThrowsOrRethrowsKeywordAndArrow,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenThrowsOrRethrowsKeywordAndArrow(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenThrowsOrRethrowsKeywordAndArrow` replaced.
  /// - param newChild: The new `garbageBetweenThrowsOrRethrowsKeywordAndArrow` to replace the node's
  ///                   current `garbageBetweenThrowsOrRethrowsKeywordAndArrow`, if present.
  public func withGarbageBetweenThrowsOrRethrowsKeywordAndArrow(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenThrowsOrRethrowsKeywordAndArrow)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.arrow)
    let newData = data.replacingChild(raw, at: Cursor.arrow)
    return FunctionTypeSyntax(newData)
  }

  public var garbageBetweenArrowAndReturnType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenArrowAndReturnType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenArrowAndReturnType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenArrowAndReturnType` replaced.
  /// - param newChild: The new `garbageBetweenArrowAndReturnType` to replace the node's
  ///                   current `garbageBetweenArrowAndReturnType`, if present.
  public func withGarbageBetweenArrowAndReturnType(
    _ newChild: GarbageNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArrowAndReturnType)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TypeSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.returnType)
    return FunctionTypeSyntax(newData)
  }
}

extension FunctionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftParen": garbageBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndArguments": garbageBetweenLeftParenAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "garbageBetweenArgumentsAndRightParen": garbageBetweenArgumentsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenRightParenAndAsyncKeyword": garbageBetweenRightParenAndAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword": garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenThrowsOrRethrowsKeywordAndArrow": garbageBetweenThrowsOrRethrowsKeywordAndArrow.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self),
      "garbageBetweenArrowAndReturnType": garbageBetweenArrowAndReturnType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AttributedTypeSyntax

public struct AttributedTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeSpecifier
    case specifier
    case garbageBetweenSpecifierAndAttributes
    case attributes
    case garbageBetweenAttributesAndBaseType
    case baseType
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AttributedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .attributedType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AttributedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .attributedType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeSpecifier: GarbageNodesSyntax? = nil,
    specifier: TokenSyntax?,
    _ garbageBetweenSpecifierAndAttributes: GarbageNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ garbageBetweenAttributesAndBaseType: GarbageNodesSyntax? = nil,
    baseType: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeSpecifier?.raw,
      specifier?.raw,
      garbageBetweenSpecifierAndAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attributedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeSpecifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeSpecifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeSpecifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeSpecifier` replaced.
  /// - param newChild: The new `garbageBeforeSpecifier` to replace the node's
  ///                   current `garbageBeforeSpecifier`, if present.
  public func withGarbageBeforeSpecifier(
    _ newChild: GarbageNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeSpecifier)
    return AttributedTypeSyntax(newData)
  }

  public var specifier: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.specifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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

  public var garbageBetweenSpecifierAndAttributes: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSpecifierAndAttributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSpecifierAndAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSpecifierAndAttributes` replaced.
  /// - param newChild: The new `garbageBetweenSpecifierAndAttributes` to replace the node's
  ///                   current `garbageBetweenSpecifierAndAttributes`, if present.
  public func withGarbageBetweenSpecifierAndAttributes(
    _ newChild: GarbageNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSpecifierAndAttributes)
    return AttributedTypeSyntax(newData)
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
  public func addAttribute(_ element: Syntax) -> AttributedTypeSyntax {
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

  public var garbageBetweenAttributesAndBaseType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAttributesAndBaseType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAttributesAndBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAttributesAndBaseType` replaced.
  /// - param newChild: The new `garbageBetweenAttributesAndBaseType` to replace the node's
  ///                   current `garbageBetweenAttributesAndBaseType`, if present.
  public func withGarbageBetweenAttributesAndBaseType(
    _ newChild: GarbageNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAttributesAndBaseType)
    return AttributedTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return AttributedTypeSyntax(newData)
  }
}

extension AttributedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeSpecifier": garbageBeforeSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenSpecifierAndAttributes": garbageBetweenSpecifierAndAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAttributesAndBaseType": garbageBetweenAttributesAndBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
    ])
  }
}

