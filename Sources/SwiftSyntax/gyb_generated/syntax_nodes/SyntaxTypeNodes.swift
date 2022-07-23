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

public struct UnknownTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnknownTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnknownTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnknownTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnknownTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

extension UnknownTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - SimpleTypeIdentifierSyntax

public struct SimpleTypeIdentifierSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case name
    case genericArgumentClause
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSimpleTypeIdentifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SimpleTypeIdentifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SimpleTypeIdentifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SimpleTypeIdentifierSyntax` unsafely assuming `syntax` is valid.
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

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause.rawValue)
      return childData.map { GenericArgumentClauseSyntax(data: $0) }
    }
    set(value) {
      self = withGenericArgumentClause(value)
    }
  }
  public func withGenericArgumentClause(_ newChild: GenericArgumentClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.genericArgumentClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SimpleTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberTypeIdentifierSyntax

public struct MemberTypeIdentifierSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case baseType
    case period
    case name
    case genericArgumentClause
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMemberTypeIdentifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MemberTypeIdentifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MemberTypeIdentifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MemberTypeIdentifierSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withBaseType(value)
    }
  }
  public func withBaseType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.baseType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.period.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPeriod(value)
    }
  }
  public func withPeriod(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw

    let newRaw = raw.replacingChild(
      at: Cursor.period.rawValue, with: newChildRaw, arena: arena)
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

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause.rawValue)
      return childData.map { GenericArgumentClauseSyntax(data: $0) }
    }
    set(value) {
      self = withGenericArgumentClause(value)
    }
  }
  public func withGenericArgumentClause(_ newChild: GenericArgumentClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.genericArgumentClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MemberTypeIdentifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClassRestrictionTypeSyntax

public struct ClassRestrictionTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case classKeyword
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClassRestrictionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClassRestrictionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClassRestrictionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClassRestrictionTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var classKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.classKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withClassKeyword(value)
    }
  }
  public func withClassKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .classKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.classKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ClassRestrictionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "classKeyword": Syntax(classKeyword).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayTypeSyntax

public struct ArrayTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftSquareBracket
    case elementType
    case rightSquareBracket
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawArrayTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ArrayTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ArrayTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ArrayTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquareBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftSquareBracket(value)
    }
  }
  public func withLeftSquareBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftSquareBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elementType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.elementType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withElementType(value)
    }
  }
  public func withElementType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elementType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquareBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightSquareBracket(value)
    }
  }
  public func withRightSquareBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightSquareBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ArrayTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self) as Any,
      "elementType": Syntax(elementType).asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryTypeSyntax

public struct DictionaryTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftSquareBracket
    case keyType
    case colon
    case valueType
    case rightSquareBracket
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDictionaryTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DictionaryTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DictionaryTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DictionaryTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquareBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftSquareBracket(value)
    }
  }
  public func withLeftSquareBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftSquareBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var keyType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.keyType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withKeyType(value)
    }
  }
  public func withKeyType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.keyType.rawValue, with: newChildRaw, arena: arena)
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

  public var valueType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.valueType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withValueType(value)
    }
  }
  public func withValueType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.valueType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightSquareBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquareBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightSquareBracket(value)
    }
  }
  public func withRightSquareBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightSquareBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DictionaryTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquareBracket": Syntax(leftSquareBracket).asProtocol(SyntaxProtocol.self) as Any,
      "keyType": Syntax(keyType).asProtocol(SyntaxProtocol.self) as Any,
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self) as Any,
      "valueType": Syntax(valueType).asProtocol(SyntaxProtocol.self) as Any,
      "rightSquareBracket": Syntax(rightSquareBracket).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MetatypeTypeSyntax

public struct MetatypeTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case baseType
    case period
    case typeOrProtocol
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMetatypeTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MetatypeTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MetatypeTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MetatypeTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withBaseType(value)
    }
  }
  public func withBaseType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.baseType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var period: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.period.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPeriod(value)
    }
  }
  public func withPeriod(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw

    let newRaw = raw.replacingChild(
      at: Cursor.period.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeOrProtocol: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.typeOrProtocol.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withTypeOrProtocol(value)
    }
  }
  public func withTypeOrProtocol(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeOrProtocol.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MetatypeTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self) as Any,
      "typeOrProtocol": Syntax(typeOrProtocol).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalTypeSyntax

public struct OptionalTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case wrappedType
    case questionMark
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawOptionalTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `OptionalTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `OptionalTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `OptionalTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.wrappedType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withWrappedType(value)
    }
  }
  public func withWrappedType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.wrappedType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var questionMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.questionMark.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withQuestionMark(value)
    }
  }
  public func withQuestionMark(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixQuestionMark).raw

    let newRaw = raw.replacingChild(
      at: Cursor.questionMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension OptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ConstrainedSugarTypeSyntax

public struct ConstrainedSugarTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case someOrAnySpecifier
    case baseType
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawConstrainedSugarTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ConstrainedSugarTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ConstrainedSugarTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ConstrainedSugarTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var someOrAnySpecifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.someOrAnySpecifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withSomeOrAnySpecifier(value)
    }
  }
  public func withSomeOrAnySpecifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.someOrAnySpecifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withBaseType(value)
    }
  }
  public func withBaseType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.baseType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ConstrainedSugarTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "someOrAnySpecifier": Syntax(someOrAnySpecifier).asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImplicitlyUnwrappedOptionalTypeSyntax

public struct ImplicitlyUnwrappedOptionalTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case wrappedType
    case exclamationMark
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawImplicitlyUnwrappedOptionalTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ImplicitlyUnwrappedOptionalTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ImplicitlyUnwrappedOptionalTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var wrappedType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.wrappedType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withWrappedType(value)
    }
  }
  public func withWrappedType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.wrappedType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var exclamationMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.exclamationMark.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withExclamationMark(value)
    }
  }
  public func withExclamationMark(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .exclamationMark).raw

    let newRaw = raw.replacingChild(
      at: Cursor.exclamationMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ImplicitlyUnwrappedOptionalTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wrappedType": Syntax(wrappedType).asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CompositionTypeSyntax

public struct CompositionTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case elements
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCompositionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CompositionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `CompositionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `CompositionTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var elements: CompositionTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return CompositionTypeElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .compositionTypeElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElements(_ newChild: CompositionTypeElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCompositionTypeElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension CompositionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleTypeSyntax

public struct TupleTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case elements
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TupleTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TupleTypeSyntax` unsafely assuming `syntax` is valid.
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

  public var elements: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return TupleTypeElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleTypeElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElements(_ newChild: TupleTypeElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleTypeElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elements.rawValue, with: newChildRaw, arena: arena)
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

extension TupleTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionTypeSyntax

public struct FunctionTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case arguments
    case rightParen
    case asyncKeyword
    case throwsOrRethrowsKeyword
    case arrow
    case returnType
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FunctionTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FunctionTypeSyntax` unsafely assuming `syntax` is valid.
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

  public var arguments: TupleTypeElementListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return TupleTypeElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.arguments.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleTypeElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.arguments.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArguments(_ newChild: TupleTypeElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleTypeElementListSyntax.makeBlank(arena: arena).raw

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

extension FunctionTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self) as Any,
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AttributedTypeSyntax

public struct AttributedTypeSyntax: TypeSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case specifier
    case attributes
    case baseType
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAttributedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AttributedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AttributedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AttributedTypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var specifier: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.specifier.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withSpecifier(value)
    }
  }
  public func withSpecifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.specifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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
  public func addAttribute(_ element: Syntax) -> AttributedTypeSyntax {
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

  public var baseType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.baseType.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withBaseType(value)
    }
  }
  public func withBaseType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.baseType.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AttributedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "baseType": Syntax(baseType).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}
