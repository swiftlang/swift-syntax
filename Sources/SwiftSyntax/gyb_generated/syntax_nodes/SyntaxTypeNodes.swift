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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unknownType,
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.missingType,
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

extension MissingTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - SimpleTypeIdentifierSyntax

public struct SimpleTypeIdentifierSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?,
    _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.simpleTypeIdentifier,
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
    _ newChild: UnexpectedNodesSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return SimpleTypeIdentifierSyntax(newData)
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
    _ newChild: TokenSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public var unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndGenericArgumentClause` to replace the node's
  ///                   current `unexpectedBetweenNameAndGenericArgumentClause`, if present.
  public func withUnexpectedBetweenNameAndGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 3)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public var unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return SimpleTypeIdentifierSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeName,
      \Self.name,
      \Self.unexpectedBetweenNameAndGenericArgumentClause,
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
    default:
      fatalError("Invalid index")
    }
  }
}

extension SimpleTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeName": unexpectedBeforeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndGenericArgumentClause": unexpectedBetweenNameAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericArgumentClause": unexpectedAfterGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberTypeIdentifierSyntax

public struct MemberTypeIdentifierSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax,
    _ unexpectedBetweenPeriodAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?,
    _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberTypeIdentifier,
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
    _ newChild: UnexpectedNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBaseTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBaseTypeAndPeriod` replaced.
  /// - param newChild: The new `unexpectedBetweenBaseTypeAndPeriod` to replace the node's
  ///                   current `unexpectedBetweenBaseTypeAndPeriod`, if present.
  public func withUnexpectedBetweenBaseTypeAndPeriod(
    _ newChild: UnexpectedNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var unexpectedBetweenPeriodAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPeriodAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPeriodAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenPeriodAndName` to replace the node's
  ///                   current `unexpectedBetweenPeriodAndName`, if present.
  public func withUnexpectedBetweenPeriodAndName(
    _ newChild: UnexpectedNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MemberTypeIdentifierSyntax(newData)
  }

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
    _ newChild: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndGenericArgumentClause` to replace the node's
  ///                   current `unexpectedBetweenNameAndGenericArgumentClause`, if present.
  public func withUnexpectedBetweenNameAndGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 7)
    return MemberTypeIdentifierSyntax(newData)
  }

  public var unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return MemberTypeIdentifierSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBaseType,
      \Self.baseType,
      \Self.unexpectedBetweenBaseTypeAndPeriod,
      \Self.period,
      \Self.unexpectedBetweenPeriodAndName,
      \Self.name,
      \Self.unexpectedBetweenNameAndGenericArgumentClause,
      \Self.genericArgumentClause,
      \Self.unexpectedAfterGenericArgumentClause,
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
      return "member type"
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

extension MemberTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBaseType": unexpectedBeforeBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBaseTypeAndPeriod": unexpectedBetweenBaseTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPeriodAndName": unexpectedBetweenPeriodAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndGenericArgumentClause": unexpectedBetweenNameAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterGenericArgumentClause": unexpectedAfterGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClassRestrictionTypeSyntax

public struct ClassRestrictionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeClassKeyword: UnexpectedNodesSyntax? = nil,
    classKeyword: TokenSyntax,
    _ unexpectedAfterClassKeyword: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClassKeyword?.raw,
      classKeyword.raw,
      unexpectedAfterClassKeyword?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.classRestrictionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeClassKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeClassKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeClassKeyword` to replace the node's
  ///                   current `unexpectedBeforeClassKeyword`, if present.
  public func withUnexpectedBeforeClassKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ClassRestrictionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ClassRestrictionTypeSyntax(newData)
  }

  public var classKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ClassRestrictionTypeSyntax(newData)
  }

  public var unexpectedAfterClassKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterClassKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterClassKeyword` replaced.
  /// - param newChild: The new `unexpectedAfterClassKeyword` to replace the node's
  ///                   current `unexpectedAfterClassKeyword`, if present.
  public func withUnexpectedAfterClassKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ClassRestrictionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ClassRestrictionTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeClassKeyword,
      \Self.classKeyword,
      \Self.unexpectedAfterClassKeyword,
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

extension ClassRestrictionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeClassKeyword": unexpectedBeforeClassKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "classKeyword": Syntax(classKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterClassKeyword": unexpectedAfterClassKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayTypeSyntax

public struct ArrayTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax,
    _ unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? = nil,
    elementType: TypeSyntax,
    _ unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax,
    _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      unexpectedBetweenLeftSquareBracketAndElementType?.raw,
      elementType.raw,
      unexpectedBetweenElementTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
      unexpectedAfterRightSquareBracket?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftSquareBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftSquareBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftSquareBracket`, if present.
  public func withUnexpectedBeforeLeftSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ArrayTypeSyntax(newData)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ArrayTypeSyntax(newData)
  }

  public var unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftSquareBracketAndElementType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftSquareBracketAndElementType` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftSquareBracketAndElementType` to replace the node's
  ///                   current `unexpectedBetweenLeftSquareBracketAndElementType`, if present.
  public func withUnexpectedBetweenLeftSquareBracketAndElementType(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ArrayTypeSyntax(newData)
  }

  public var elementType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ArrayTypeSyntax(newData)
  }

  public var unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenElementTypeAndRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenElementTypeAndRightSquareBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenElementTypeAndRightSquareBracket` to replace the node's
  ///                   current `unexpectedBetweenElementTypeAndRightSquareBracket`, if present.
  public func withUnexpectedBetweenElementTypeAndRightSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ArrayTypeSyntax(newData)
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return ArrayTypeSyntax(newData)
  }

  public var unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightSquareBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightSquareBracket` to replace the node's
  ///                   current `unexpectedAfterRightSquareBracket`, if present.
  public func withUnexpectedAfterRightSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return ArrayTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftSquareBracket,
      \Self.leftSquareBracket,
      \Self.unexpectedBetweenLeftSquareBracketAndElementType,
      \Self.elementType,
      \Self.unexpectedBetweenElementTypeAndRightSquareBracket,
      \Self.rightSquareBracket,
      \Self.unexpectedAfterRightSquareBracket,
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

extension ArrayTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftSquareBracket": unexpectedBeforeLeftSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftSquareBracketAndElementType": unexpectedBetweenLeftSquareBracketAndElementType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elementType": Syntax(elementType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenElementTypeAndRightSquareBracket": unexpectedBetweenElementTypeAndRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightSquareBracket": unexpectedAfterRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryTypeSyntax

public struct DictionaryTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax,
    _ unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? = nil,
    keyType: TypeSyntax,
    _ unexpectedBetweenKeyTypeAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax,
    _ unexpectedBetweenColonAndValueType: UnexpectedNodesSyntax? = nil,
    valueType: TypeSyntax,
    _ unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax,
    _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      unexpectedBetweenLeftSquareBracketAndKeyType?.raw,
      keyType.raw,
      unexpectedBetweenKeyTypeAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValueType?.raw,
      valueType.raw,
      unexpectedBetweenValueTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
      unexpectedAfterRightSquareBracket?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftSquareBracket` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftSquareBracket` to replace the node's
  ///                   current `unexpectedBeforeLeftSquareBracket`, if present.
  public func withUnexpectedBeforeLeftSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return DictionaryTypeSyntax(newData)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return DictionaryTypeSyntax(newData)
  }

  public var unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftSquareBracketAndKeyType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftSquareBracketAndKeyType` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftSquareBracketAndKeyType` to replace the node's
  ///                   current `unexpectedBetweenLeftSquareBracketAndKeyType`, if present.
  public func withUnexpectedBetweenLeftSquareBracketAndKeyType(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return DictionaryTypeSyntax(newData)
  }

  public var keyType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return DictionaryTypeSyntax(newData)
  }

  public var unexpectedBetweenKeyTypeAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenKeyTypeAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenKeyTypeAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenKeyTypeAndColon` to replace the node's
  ///                   current `unexpectedBetweenKeyTypeAndColon`, if present.
  public func withUnexpectedBetweenKeyTypeAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return DictionaryTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return DictionaryTypeSyntax(newData)
  }

  public var unexpectedBetweenColonAndValueType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndValueType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndValueType` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndValueType` to replace the node's
  ///                   current `unexpectedBetweenColonAndValueType`, if present.
  public func withUnexpectedBetweenColonAndValueType(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return DictionaryTypeSyntax(newData)
  }

  public var valueType: TypeSyntax {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 7)
    return DictionaryTypeSyntax(newData)
  }

  public var unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenValueTypeAndRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenValueTypeAndRightSquareBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenValueTypeAndRightSquareBracket` to replace the node's
  ///                   current `unexpectedBetweenValueTypeAndRightSquareBracket`, if present.
  public func withUnexpectedBetweenValueTypeAndRightSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return DictionaryTypeSyntax(newData)
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: 9)
    return DictionaryTypeSyntax(newData)
  }

  public var unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterRightSquareBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterRightSquareBracket` replaced.
  /// - param newChild: The new `unexpectedAfterRightSquareBracket` to replace the node's
  ///                   current `unexpectedAfterRightSquareBracket`, if present.
  public func withUnexpectedAfterRightSquareBracket(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return DictionaryTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftSquareBracket,
      \Self.leftSquareBracket,
      \Self.unexpectedBetweenLeftSquareBracketAndKeyType,
      \Self.keyType,
      \Self.unexpectedBetweenKeyTypeAndColon,
      \Self.colon,
      \Self.unexpectedBetweenColonAndValueType,
      \Self.valueType,
      \Self.unexpectedBetweenValueTypeAndRightSquareBracket,
      \Self.rightSquareBracket,
      \Self.unexpectedAfterRightSquareBracket,
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
      return "key type"
    case 4:
      return nil
    case 5:
      return nil
    case 6:
      return nil
    case 7:
      return "value type"
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

extension DictionaryTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftSquareBracket": unexpectedBeforeLeftSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftSquareBracketAndKeyType": unexpectedBetweenLeftSquareBracketAndKeyType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "keyType": Syntax(keyType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenKeyTypeAndColon": unexpectedBetweenKeyTypeAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonAndValueType": unexpectedBetweenColonAndValueType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valueType": Syntax(valueType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenValueTypeAndRightSquareBracket": unexpectedBetweenValueTypeAndRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterRightSquareBracket": unexpectedAfterRightSquareBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MetatypeTypeSyntax

public struct MetatypeTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax,
    _ unexpectedBetweenPeriodAndTypeOrProtocol: UnexpectedNodesSyntax? = nil,
    typeOrProtocol: TokenSyntax,
    _ unexpectedAfterTypeOrProtocol: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndTypeOrProtocol?.raw,
      typeOrProtocol.raw,
      unexpectedAfterTypeOrProtocol?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.metatypeType,
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
    _ newChild: UnexpectedNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return MetatypeTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return MetatypeTypeSyntax(newData)
  }

  public var unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBaseTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBaseTypeAndPeriod` replaced.
  /// - param newChild: The new `unexpectedBetweenBaseTypeAndPeriod` to replace the node's
  ///                   current `unexpectedBetweenBaseTypeAndPeriod`, if present.
  public func withUnexpectedBetweenBaseTypeAndPeriod(
    _ newChild: UnexpectedNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return MetatypeTypeSyntax(newData)
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return MetatypeTypeSyntax(newData)
  }

  public var unexpectedBetweenPeriodAndTypeOrProtocol: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPeriodAndTypeOrProtocol(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPeriodAndTypeOrProtocol` replaced.
  /// - param newChild: The new `unexpectedBetweenPeriodAndTypeOrProtocol` to replace the node's
  ///                   current `unexpectedBetweenPeriodAndTypeOrProtocol`, if present.
  public func withUnexpectedBetweenPeriodAndTypeOrProtocol(
    _ newChild: UnexpectedNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return MetatypeTypeSyntax(newData)
  }

  public var typeOrProtocol: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return MetatypeTypeSyntax(newData)
  }

  public var unexpectedAfterTypeOrProtocol: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTypeOrProtocol(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTypeOrProtocol` replaced.
  /// - param newChild: The new `unexpectedAfterTypeOrProtocol` to replace the node's
  ///                   current `unexpectedAfterTypeOrProtocol`, if present.
  public func withUnexpectedAfterTypeOrProtocol(
    _ newChild: UnexpectedNodesSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return MetatypeTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeBaseType,
      \Self.baseType,
      \Self.unexpectedBetweenBaseTypeAndPeriod,
      \Self.period,
      \Self.unexpectedBetweenPeriodAndTypeOrProtocol,
      \Self.typeOrProtocol,
      \Self.unexpectedAfterTypeOrProtocol,
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
      return nil
    case 6:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension MetatypeTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBaseType": unexpectedBeforeBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBaseTypeAndPeriod": unexpectedBetweenBaseTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPeriodAndTypeOrProtocol": unexpectedBetweenPeriodAndTypeOrProtocol.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeOrProtocol": Syntax(typeOrProtocol).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterTypeOrProtocol": unexpectedAfterTypeOrProtocol.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalTypeSyntax

public struct OptionalTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil,
    wrappedType: TypeSyntax,
    _ unexpectedBetweenWrappedTypeAndQuestionMark: UnexpectedNodesSyntax? = nil,
    questionMark: TokenSyntax,
    _ unexpectedAfterQuestionMark: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedAfterQuestionMark?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWrappedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWrappedType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWrappedType` replaced.
  /// - param newChild: The new `unexpectedBeforeWrappedType` to replace the node's
  ///                   current `unexpectedBeforeWrappedType`, if present.
  public func withUnexpectedBeforeWrappedType(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return OptionalTypeSyntax(newData)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return OptionalTypeSyntax(newData)
  }

  public var unexpectedBetweenWrappedTypeAndQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWrappedTypeAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWrappedTypeAndQuestionMark` replaced.
  /// - param newChild: The new `unexpectedBetweenWrappedTypeAndQuestionMark` to replace the node's
  ///                   current `unexpectedBetweenWrappedTypeAndQuestionMark`, if present.
  public func withUnexpectedBetweenWrappedTypeAndQuestionMark(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return OptionalTypeSyntax(newData)
  }

  public var questionMark: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return OptionalTypeSyntax(newData)
  }

  public var unexpectedAfterQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterQuestionMark` replaced.
  /// - param newChild: The new `unexpectedAfterQuestionMark` to replace the node's
  ///                   current `unexpectedAfterQuestionMark`, if present.
  public func withUnexpectedAfterQuestionMark(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return OptionalTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWrappedType,
      \Self.wrappedType,
      \Self.unexpectedBetweenWrappedTypeAndQuestionMark,
      \Self.questionMark,
      \Self.unexpectedAfterQuestionMark,
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

extension OptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWrappedType": unexpectedBeforeWrappedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWrappedTypeAndQuestionMark": unexpectedBetweenWrappedTypeAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterQuestionMark": unexpectedAfterQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConstrainedSugarTypeSyntax

public struct ConstrainedSugarTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeSomeOrAnySpecifier: UnexpectedNodesSyntax? = nil,
    someOrAnySpecifier: TokenSyntax,
    _ unexpectedBetweenSomeOrAnySpecifierAndBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSomeOrAnySpecifier?.raw,
      someOrAnySpecifier.raw,
      unexpectedBetweenSomeOrAnySpecifierAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.constrainedSugarType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeSomeOrAnySpecifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeSomeOrAnySpecifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeSomeOrAnySpecifier` replaced.
  /// - param newChild: The new `unexpectedBeforeSomeOrAnySpecifier` to replace the node's
  ///                   current `unexpectedBeforeSomeOrAnySpecifier`, if present.
  public func withUnexpectedBeforeSomeOrAnySpecifier(
    _ newChild: UnexpectedNodesSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var someOrAnySpecifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var unexpectedBetweenSomeOrAnySpecifierAndBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSomeOrAnySpecifierAndBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSomeOrAnySpecifierAndBaseType` replaced.
  /// - param newChild: The new `unexpectedBetweenSomeOrAnySpecifierAndBaseType` to replace the node's
  ///                   current `unexpectedBetweenSomeOrAnySpecifierAndBaseType`, if present.
  public func withUnexpectedBetweenSomeOrAnySpecifierAndBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public var unexpectedAfterBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterBaseType` replaced.
  /// - param newChild: The new `unexpectedAfterBaseType` to replace the node's
  ///                   current `unexpectedAfterBaseType`, if present.
  public func withUnexpectedAfterBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> ConstrainedSugarTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ConstrainedSugarTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSomeOrAnySpecifier,
      \Self.someOrAnySpecifier,
      \Self.unexpectedBetweenSomeOrAnySpecifierAndBaseType,
      \Self.baseType,
      \Self.unexpectedAfterBaseType,
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

extension ConstrainedSugarTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSomeOrAnySpecifier": unexpectedBeforeSomeOrAnySpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "someOrAnySpecifier": Syntax(someOrAnySpecifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSomeOrAnySpecifierAndBaseType": unexpectedBetweenSomeOrAnySpecifierAndBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterBaseType": unexpectedAfterBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImplicitlyUnwrappedOptionalTypeSyntax

public struct ImplicitlyUnwrappedOptionalTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil,
    wrappedType: TypeSyntax,
    _ unexpectedBetweenWrappedTypeAndExclamationMark: UnexpectedNodesSyntax? = nil,
    exclamationMark: TokenSyntax,
    _ unexpectedAfterExclamationMark: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndExclamationMark?.raw,
      exclamationMark.raw,
      unexpectedAfterExclamationMark?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeWrappedType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWrappedType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWrappedType` replaced.
  /// - param newChild: The new `unexpectedBeforeWrappedType` to replace the node's
  ///                   current `unexpectedBeforeWrappedType`, if present.
  public func withUnexpectedBeforeWrappedType(
    _ newChild: UnexpectedNodesSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var unexpectedBetweenWrappedTypeAndExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWrappedTypeAndExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWrappedTypeAndExclamationMark` replaced.
  /// - param newChild: The new `unexpectedBetweenWrappedTypeAndExclamationMark` to replace the node's
  ///                   current `unexpectedBetweenWrappedTypeAndExclamationMark`, if present.
  public func withUnexpectedBetweenWrappedTypeAndExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var exclamationMark: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public var unexpectedAfterExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterExclamationMark` replaced.
  /// - param newChild: The new `unexpectedAfterExclamationMark` to replace the node's
  ///                   current `unexpectedAfterExclamationMark`, if present.
  public func withUnexpectedAfterExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWrappedType,
      \Self.wrappedType,
      \Self.unexpectedBetweenWrappedTypeAndExclamationMark,
      \Self.exclamationMark,
      \Self.unexpectedAfterExclamationMark,
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

extension ImplicitlyUnwrappedOptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWrappedType": unexpectedBeforeWrappedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWrappedTypeAndExclamationMark": unexpectedBetweenWrappedTypeAndExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterExclamationMark": unexpectedAfterExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CompositionTypeSyntax

public struct CompositionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil,
    elements: CompositionTypeElementListSyntax,
    _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
      unexpectedAfterElements?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeElements` replaced.
  /// - param newChild: The new `unexpectedBeforeElements` to replace the node's
  ///                   current `unexpectedBeforeElements`, if present.
  public func withUnexpectedBeforeElements(
    _ newChild: UnexpectedNodesSyntax?) -> CompositionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return CompositionTypeSyntax(newData)
  }

  public var elements: CompositionTypeElementListSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[1] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 1)
    return CompositionTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: CompositionTypeElementListSyntax?) -> CompositionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.compositionTypeElementList, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return CompositionTypeSyntax(newData)
  }

  public var unexpectedAfterElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> CompositionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return CompositionTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeElements,
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
    default:
      fatalError("Invalid index")
    }
  }
}

extension CompositionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeElements": unexpectedBeforeElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterElements": unexpectedAfterElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PackExpansionTypeSyntax

public struct PackExpansionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PackExpansionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .packExpansionType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PackExpansionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .packExpansionType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforePatternType: UnexpectedNodesSyntax? = nil,
    patternType: TypeSyntax,
    _ unexpectedBetweenPatternTypeAndEllipsis: UnexpectedNodesSyntax? = nil,
    ellipsis: TokenSyntax,
    _ unexpectedAfterEllipsis: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePatternType?.raw,
      patternType.raw,
      unexpectedBetweenPatternTypeAndEllipsis?.raw,
      ellipsis.raw,
      unexpectedAfterEllipsis?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.packExpansionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforePatternType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePatternType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePatternType` replaced.
  /// - param newChild: The new `unexpectedBeforePatternType` to replace the node's
  ///                   current `unexpectedBeforePatternType`, if present.
  public func withUnexpectedBeforePatternType(
    _ newChild: UnexpectedNodesSyntax?) -> PackExpansionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return PackExpansionTypeSyntax(newData)
  }

  public var patternType: TypeSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withPatternType(value)
    }
  }

  /// Returns a copy of the receiver with its `patternType` replaced.
  /// - param newChild: The new `patternType` to replace the node's
  ///                   current `patternType`, if present.
  public func withPatternType(
    _ newChild: TypeSyntax?) -> PackExpansionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return PackExpansionTypeSyntax(newData)
  }

  public var unexpectedBetweenPatternTypeAndEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternTypeAndEllipsis(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternTypeAndEllipsis` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternTypeAndEllipsis` to replace the node's
  ///                   current `unexpectedBetweenPatternTypeAndEllipsis`, if present.
  public func withUnexpectedBetweenPatternTypeAndEllipsis(
    _ newChild: UnexpectedNodesSyntax?) -> PackExpansionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return PackExpansionTypeSyntax(newData)
  }

  public var ellipsis: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TokenSyntax?) -> PackExpansionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.ellipsis, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return PackExpansionTypeSyntax(newData)
  }

  public var unexpectedAfterEllipsis: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterEllipsis(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterEllipsis` replaced.
  /// - param newChild: The new `unexpectedAfterEllipsis` to replace the node's
  ///                   current `unexpectedAfterEllipsis`, if present.
  public func withUnexpectedAfterEllipsis(
    _ newChild: UnexpectedNodesSyntax?) -> PackExpansionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return PackExpansionTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePatternType,
      \Self.patternType,
      \Self.unexpectedBetweenPatternTypeAndEllipsis,
      \Self.ellipsis,
      \Self.unexpectedAfterEllipsis,
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

extension PackExpansionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePatternType": unexpectedBeforePatternType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "patternType": Syntax(patternType).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternTypeAndEllipsis": unexpectedBetweenPatternTypeAndEllipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": Syntax(ellipsis).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterEllipsis": unexpectedAfterEllipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleTypeSyntax

public struct TupleTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil,
    elements: TupleTypeElementListSyntax,
    _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleType,
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
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return TupleTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return TupleTypeSyntax(newData)
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
  public func withUnexpectedBetweenLeftParenAndElements(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return TupleTypeSyntax(newData)
  }

  public var elements: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return TupleTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: TupleTypeElementListSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return TupleTypeSyntax(newData)
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
  public func withUnexpectedBetweenElementsAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return TupleTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return TupleTypeSyntax(newData)
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
    _ newChild: UnexpectedNodesSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return TupleTypeSyntax(newData)
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

extension TupleTypeSyntax: CustomReflectable {
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

// MARK: - FunctionTypeSyntax

public struct FunctionTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: TupleTypeElementListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax,
    _ unexpectedBetweenRightParenAndAsyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax?,
    _ unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: UnexpectedNodesSyntax? = nil,
    arrow: TokenSyntax,
    _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil,
    returnType: TypeSyntax,
    _ unexpectedAfterReturnType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      unexpectedBetweenRightParenAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      unexpectedBetweenThrowsOrRethrowsKeywordAndArrow?.raw,
      arrow.raw,
      unexpectedBetweenArrowAndReturnType?.raw,
      returnType.raw,
      unexpectedAfterReturnType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionType,
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return FunctionTypeSyntax(newData)
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return FunctionTypeSyntax(newData)
  }

  public var arguments: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElementList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return FunctionTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: TupleTypeElementListSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return FunctionTypeSyntax(newData)
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return FunctionTypeSyntax(newData)
  }

  public var unexpectedBetweenRightParenAndAsyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRightParenAndAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRightParenAndAsyncKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenRightParenAndAsyncKeyword` to replace the node's
  ///                   current `unexpectedBetweenRightParenAndAsyncKeyword`, if present.
  public func withUnexpectedBetweenRightParenAndAsyncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return FunctionTypeSyntax(newData)
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
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 7)
    return FunctionTypeSyntax(newData)
  }

  public var unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword` to replace the node's
  ///                   current `unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword`, if present.
  public func withUnexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 8)
    return FunctionTypeSyntax(newData)
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: 9, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 9)
    return FunctionTypeSyntax(newData)
  }

  public var unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 10, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenThrowsOrRethrowsKeywordAndArrow(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenThrowsOrRethrowsKeywordAndArrow` replaced.
  /// - param newChild: The new `unexpectedBetweenThrowsOrRethrowsKeywordAndArrow` to replace the node's
  ///                   current `unexpectedBetweenThrowsOrRethrowsKeywordAndArrow`, if present.
  public func withUnexpectedBetweenThrowsOrRethrowsKeywordAndArrow(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 10)
    return FunctionTypeSyntax(newData)
  }

  public var arrow: TokenSyntax {
    get {
      let childData = data.child(at: 11, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default)
    let newData = data.replacingChild(raw, at: 11)
    return FunctionTypeSyntax(newData)
  }

  public var unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 12, parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 12)
    return FunctionTypeSyntax(newData)
  }

  public var returnType: TypeSyntax {
    get {
      let childData = data.child(at: 13, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 13)
    return FunctionTypeSyntax(newData)
  }

  public var unexpectedAfterReturnType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 14, parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 14)
    return FunctionTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLeftParen,
      \Self.leftParen,
      \Self.unexpectedBetweenLeftParenAndArguments,
      \Self.arguments,
      \Self.unexpectedBetweenArgumentsAndRightParen,
      \Self.rightParen,
      \Self.unexpectedBetweenRightParenAndAsyncKeyword,
      \Self.asyncKeyword,
      \Self.unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword,
      \Self.throwsOrRethrowsKeyword,
      \Self.unexpectedBetweenThrowsOrRethrowsKeywordAndArrow,
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

extension FunctionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndArguments": unexpectedBetweenLeftParenAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentsAndRightParen": unexpectedBetweenArgumentsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenRightParenAndAsyncKeyword": unexpectedBetweenRightParenAndAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword": unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenThrowsOrRethrowsKeywordAndArrow": unexpectedBetweenThrowsOrRethrowsKeywordAndArrow.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArrowAndReturnType": unexpectedBetweenArrowAndReturnType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterReturnType": unexpectedAfterReturnType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AttributedTypeSyntax

public struct AttributedTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
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
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: TokenSyntax?,
    _ unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax?,
    _ unexpectedBetweenAttributesAndBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSpecifier?.raw,
      specifier?.raw,
      unexpectedBetweenSpecifierAndAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributedType,
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
    _ newChild: UnexpectedNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return AttributedTypeSyntax(newData)
  }

  public var specifier: TokenSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    let newData = data.replacingChild(raw, at: 1)
    return AttributedTypeSyntax(newData)
  }

  public var unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSpecifierAndAttributes(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSpecifierAndAttributes` replaced.
  /// - param newChild: The new `unexpectedBetweenSpecifierAndAttributes` to replace the node's
  ///                   current `unexpectedBetweenSpecifierAndAttributes`, if present.
  public func withUnexpectedBetweenSpecifierAndAttributes(
    _ newChild: UnexpectedNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return AttributedTypeSyntax(newData)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: [element.raw], arena: .default)
    }
    let newData = data.replacingChild(collection, at: 3)
    return AttributedTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 3)
    return AttributedTypeSyntax(newData)
  }

  public var unexpectedBetweenAttributesAndBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAttributesAndBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAttributesAndBaseType` replaced.
  /// - param newChild: The new `unexpectedBetweenAttributesAndBaseType` to replace the node's
  ///                   current `unexpectedBetweenAttributesAndBaseType`, if present.
  public func withUnexpectedBetweenAttributesAndBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return AttributedTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 5)
    return AttributedTypeSyntax(newData)
  }

  public var unexpectedAfterBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterBaseType` replaced.
  /// - param newChild: The new `unexpectedAfterBaseType` to replace the node's
  ///                   current `unexpectedAfterBaseType`, if present.
  public func withUnexpectedAfterBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 6)
    return AttributedTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSpecifier,
      \Self.specifier,
      \Self.unexpectedBetweenSpecifierAndAttributes,
      \Self.attributes,
      \Self.unexpectedBetweenAttributesAndBaseType,
      \Self.baseType,
      \Self.unexpectedAfterBaseType,
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

extension AttributedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSpecifier": unexpectedBeforeSpecifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSpecifierAndAttributes": unexpectedBetweenSpecifierAndAttributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAttributesAndBaseType": unexpectedBetweenAttributesAndBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterBaseType": unexpectedAfterBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - NamedOpaqueReturnTypeSyntax

public struct NamedOpaqueReturnTypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `NamedOpaqueReturnTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .namedOpaqueReturnType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `NamedOpaqueReturnTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .namedOpaqueReturnType)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax,
    _ unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? = nil,
    baseType: TypeSyntax,
    _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeGenericParameters?.raw,
      genericParameters.raw,
      unexpectedBetweenGenericParametersAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedOpaqueReturnType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeGenericParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeGenericParameters` replaced.
  /// - param newChild: The new `unexpectedBeforeGenericParameters` to replace the node's
  ///                   current `unexpectedBeforeGenericParameters`, if present.
  public func withUnexpectedBeforeGenericParameters(
    _ newChild: UnexpectedNodesSyntax?) -> NamedOpaqueReturnTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 0)
    return NamedOpaqueReturnTypeSyntax(newData)
  }

  public var genericParameters: GenericParameterClauseSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
    _ newChild: GenericParameterClauseSyntax?) -> NamedOpaqueReturnTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterClause, arena: .default)
    let newData = data.replacingChild(raw, at: 1)
    return NamedOpaqueReturnTypeSyntax(newData)
  }

  public var unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenGenericParametersAndBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenGenericParametersAndBaseType` replaced.
  /// - param newChild: The new `unexpectedBetweenGenericParametersAndBaseType` to replace the node's
  ///                   current `unexpectedBetweenGenericParametersAndBaseType`, if present.
  public func withUnexpectedBetweenGenericParametersAndBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> NamedOpaqueReturnTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 2)
    return NamedOpaqueReturnTypeSyntax(newData)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> NamedOpaqueReturnTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: 3)
    return NamedOpaqueReturnTypeSyntax(newData)
  }

  public var unexpectedAfterBaseType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterBaseType` replaced.
  /// - param newChild: The new `unexpectedAfterBaseType` to replace the node's
  ///                   current `unexpectedAfterBaseType`, if present.
  public func withUnexpectedAfterBaseType(
    _ newChild: UnexpectedNodesSyntax?) -> NamedOpaqueReturnTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: 4)
    return NamedOpaqueReturnTypeSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeGenericParameters,
      \Self.genericParameters,
      \Self.unexpectedBetweenGenericParametersAndBaseType,
      \Self.baseType,
      \Self.unexpectedAfterBaseType,
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

extension NamedOpaqueReturnTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeGenericParameters": unexpectedBeforeGenericParameters.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericParameters": Syntax(genericParameters).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenGenericParametersAndBaseType": unexpectedBetweenGenericParametersAndBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterBaseType": unexpectedAfterBaseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

