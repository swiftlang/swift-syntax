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


// MARK: - UnknownPatternSyntax

public struct UnknownPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnknownPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknownPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnknownPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknownPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }


  public func _validateLayout() {
    // We are verifying an unknown node. Since we don’t know anything about it
    // we need to assume it’s valid.
  }
}

extension UnknownPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - MissingPatternSyntax

public struct MissingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missingPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 0)
  }
}

extension MissingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - EnumCasePatternSyntax

public struct EnumCasePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeType
    case type
    case garbageBetweenTypeAndPeriod
    case period
    case garbageBetweenPeriodAndCaseName
    case caseName
    case garbageBetweenCaseNameAndAssociatedTuple
    case associatedTuple
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `EnumCasePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .enumCasePattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `EnumCasePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCasePattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeType` replaced.
  /// - param newChild: The new `garbageBeforeType` to replace the node's
  ///                   current `garbageBeforeType`, if present.
  public func withGarbageBeforeType(
    _ newChild: GarbageNodesSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeType)
    return EnumCasePatternSyntax(newData)
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.type)
    return EnumCasePatternSyntax(newData)
  }

  public var garbageBetweenTypeAndPeriod: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTypeAndPeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTypeAndPeriod` replaced.
  /// - param newChild: The new `garbageBetweenTypeAndPeriod` to replace the node's
  ///                   current `garbageBetweenTypeAndPeriod`, if present.
  public func withGarbageBetweenTypeAndPeriod(
    _ newChild: GarbageNodesSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTypeAndPeriod)
    return EnumCasePatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return EnumCasePatternSyntax(newData)
  }

  public var garbageBetweenPeriodAndCaseName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPeriodAndCaseName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPeriodAndCaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPeriodAndCaseName` replaced.
  /// - param newChild: The new `garbageBetweenPeriodAndCaseName` to replace the node's
  ///                   current `garbageBetweenPeriodAndCaseName`, if present.
  public func withGarbageBetweenPeriodAndCaseName(
    _ newChild: GarbageNodesSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPeriodAndCaseName)
    return EnumCasePatternSyntax(newData)
  }

  public var caseName: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseName,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `caseName` replaced.
  /// - param newChild: The new `caseName` to replace the node's
  ///                   current `caseName`, if present.
  public func withCaseName(
    _ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.caseName)
    return EnumCasePatternSyntax(newData)
  }

  public var garbageBetweenCaseNameAndAssociatedTuple: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCaseNameAndAssociatedTuple,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCaseNameAndAssociatedTuple(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCaseNameAndAssociatedTuple` replaced.
  /// - param newChild: The new `garbageBetweenCaseNameAndAssociatedTuple` to replace the node's
  ///                   current `garbageBetweenCaseNameAndAssociatedTuple`, if present.
  public func withGarbageBetweenCaseNameAndAssociatedTuple(
    _ newChild: GarbageNodesSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCaseNameAndAssociatedTuple)
    return EnumCasePatternSyntax(newData)
  }

  public var associatedTuple: TuplePatternSyntax? {
    get {
      let childData = data.child(at: Cursor.associatedTuple,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TuplePatternSyntax(childData!)
    }
    set(value) {
      self = withAssociatedTuple(value)
    }
  }

  /// Returns a copy of the receiver with its `associatedTuple` replaced.
  /// - param newChild: The new `associatedTuple` to replace the node's
  ///                   current `associatedTuple`, if present.
  public func withAssociatedTuple(
    _ newChild: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.associatedTuple)
    return EnumCasePatternSyntax(newData)
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
    // Check child #1 child is TypeSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
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
    // Check child #7 child is TuplePatternSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TuplePatternSyntax.self))
    }
  }
}

extension EnumCasePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeType": garbageBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenTypeAndPeriod": garbageBetweenTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPeriodAndCaseName": garbageBetweenPeriodAndCaseName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseName": Syntax(caseName).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCaseNameAndAssociatedTuple": garbageBetweenCaseNameAndAssociatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associatedTuple": associatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsTypePatternSyntax

public struct IsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIsKeyword
    case isKeyword
    case garbageBetweenIsKeywordAndType
    case type
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IsTypePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .isTypePattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .isTypePattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeIsKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeIsKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeIsKeyword` replaced.
  /// - param newChild: The new `garbageBeforeIsKeyword` to replace the node's
  ///                   current `garbageBeforeIsKeyword`, if present.
  public func withGarbageBeforeIsKeyword(
    _ newChild: GarbageNodesSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIsKeyword)
    return IsTypePatternSyntax(newData)
  }

  public var isKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.isKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `isKeyword` replaced.
  /// - param newChild: The new `isKeyword` to replace the node's
  ///                   current `isKeyword`, if present.
  public func withIsKeyword(
    _ newChild: TokenSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.isKeyword)
    let newData = data.replacingChild(raw, at: Cursor.isKeyword)
    return IsTypePatternSyntax(newData)
  }

  public var garbageBetweenIsKeywordAndType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIsKeywordAndType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIsKeywordAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIsKeywordAndType` replaced.
  /// - param newChild: The new `garbageBetweenIsKeywordAndType` to replace the node's
  ///                   current `garbageBetweenIsKeywordAndType`, if present.
  public func withGarbageBetweenIsKeywordAndType(
    _ newChild: GarbageNodesSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIsKeywordAndType)
    return IsTypePatternSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return IsTypePatternSyntax(newData)
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
    // Check child #3 child is TypeSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension IsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIsKeyword": garbageBeforeIsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "isKeyword": Syntax(isKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIsKeywordAndType": garbageBetweenIsKeywordAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - OptionalPatternSyntax

public struct OptionalPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeSubPattern
    case subPattern
    case garbageBetweenSubPatternAndQuestionMark
    case questionMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OptionalPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .optionalPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OptionalPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeSubPattern: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeSubPattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeSubPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeSubPattern` replaced.
  /// - param newChild: The new `garbageBeforeSubPattern` to replace the node's
  ///                   current `garbageBeforeSubPattern`, if present.
  public func withGarbageBeforeSubPattern(
    _ newChild: GarbageNodesSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeSubPattern)
    return OptionalPatternSyntax(newData)
  }

  public var subPattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.subPattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withSubPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `subPattern` replaced.
  /// - param newChild: The new `subPattern` to replace the node's
  ///                   current `subPattern`, if present.
  public func withSubPattern(
    _ newChild: PatternSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingPattern)
    let newData = data.replacingChild(raw, at: Cursor.subPattern)
    return OptionalPatternSyntax(newData)
  }

  public var garbageBetweenSubPatternAndQuestionMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSubPatternAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSubPatternAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSubPatternAndQuestionMark` replaced.
  /// - param newChild: The new `garbageBetweenSubPatternAndQuestionMark` to replace the node's
  ///                   current `garbageBetweenSubPatternAndQuestionMark`, if present.
  public func withGarbageBetweenSubPatternAndQuestionMark(
    _ newChild: GarbageNodesSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSubPatternAndQuestionMark)
    return OptionalPatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalPatternSyntax(newData)
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
    // Check child #1 child is PatternSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
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

extension OptionalPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeSubPattern": garbageBeforeSubPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "subPattern": Syntax(subPattern).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSubPatternAndQuestionMark": garbageBetweenSubPatternAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IdentifierPatternSyntax

public struct IdentifierPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIdentifier
    case identifier
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IdentifierPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .identifierPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IdentifierPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .identifierPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeIdentifier: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeIdentifier` replaced.
  /// - param newChild: The new `garbageBeforeIdentifier` to replace the node's
  ///                   current `garbageBeforeIdentifier`, if present.
  public func withGarbageBeforeIdentifier(
    _ newChild: GarbageNodesSyntax?) -> IdentifierPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIdentifier)
    return IdentifierPatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> IdentifierPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.selfKeyword)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return IdentifierPatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
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
  }
}

extension IdentifierPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIdentifier": garbageBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AsTypePatternSyntax

public struct AsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePattern
    case pattern
    case garbageBetweenPatternAndAsKeyword
    case asKeyword
    case garbageBetweenAsKeywordAndType
    case type
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AsTypePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .asTypePattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .asTypePattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePattern: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePattern` replaced.
  /// - param newChild: The new `garbageBeforePattern` to replace the node's
  ///                   current `garbageBeforePattern`, if present.
  public func withGarbageBeforePattern(
    _ newChild: GarbageNodesSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePattern)
    return AsTypePatternSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
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
    _ newChild: PatternSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingPattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return AsTypePatternSyntax(newData)
  }

  public var garbageBetweenPatternAndAsKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPatternAndAsKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPatternAndAsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPatternAndAsKeyword` replaced.
  /// - param newChild: The new `garbageBetweenPatternAndAsKeyword` to replace the node's
  ///                   current `garbageBetweenPatternAndAsKeyword`, if present.
  public func withGarbageBetweenPatternAndAsKeyword(
    _ newChild: GarbageNodesSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPatternAndAsKeyword)
    return AsTypePatternSyntax(newData)
  }

  public var asKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.asKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `asKeyword` replaced.
  /// - param newChild: The new `asKeyword` to replace the node's
  ///                   current `asKeyword`, if present.
  public func withAsKeyword(
    _ newChild: TokenSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.asKeyword)
    let newData = data.replacingChild(raw, at: Cursor.asKeyword)
    return AsTypePatternSyntax(newData)
  }

  public var garbageBetweenAsKeywordAndType: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAsKeywordAndType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAsKeywordAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAsKeywordAndType` replaced.
  /// - param newChild: The new `garbageBetweenAsKeywordAndType` to replace the node's
  ///                   current `garbageBetweenAsKeywordAndType`, if present.
  public func withGarbageBetweenAsKeywordAndType(
    _ newChild: GarbageNodesSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAsKeywordAndType)
    return AsTypePatternSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
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
    _ newChild: TypeSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return AsTypePatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 6)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is PatternSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
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
    // Check child #5 child is TypeSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension AsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePattern": garbageBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPatternAndAsKeyword": garbageBetweenPatternAndAsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asKeyword": Syntax(asKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAsKeywordAndType": garbageBetweenAsKeywordAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TuplePatternSyntax

public struct TuplePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftParen
    case leftParen
    case garbageBetweenLeftParenAndElements
    case elements
    case garbageBetweenElementsAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TuplePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tuplePattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TuplePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePattern)
    self._syntaxNode = Syntax(data)
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
    _ newChild: GarbageNodesSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftParen)
    return TuplePatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TuplePatternSyntax(newData)
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
    _ newChild: GarbageNodesSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndElements)
    return TuplePatternSyntax(newData)
  }

  public var elements: TuplePatternElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
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
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tuplePatternElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return TuplePatternSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: TuplePatternElementListSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tuplePatternElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return TuplePatternSyntax(newData)
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
    _ newChild: GarbageNodesSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElementsAndRightParen)
    return TuplePatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TuplePatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 6)
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
    // Check child #3 child is TuplePatternElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TuplePatternElementListSyntax.self))
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
  }
}

extension TuplePatternSyntax: CustomReflectable {
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

// MARK: - WildcardPatternSyntax

public struct WildcardPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeWildcard
    case wildcard
    case garbageBetweenWildcardAndTypeAnnotation
    case typeAnnotation
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `WildcardPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .wildcardPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `WildcardPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .wildcardPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeWildcard: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeWildcard,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeWildcard` replaced.
  /// - param newChild: The new `garbageBeforeWildcard` to replace the node's
  ///                   current `garbageBeforeWildcard`, if present.
  public func withGarbageBeforeWildcard(
    _ newChild: GarbageNodesSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeWildcard)
    return WildcardPatternSyntax(newData)
  }

  public var wildcard: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.wildcard,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `wildcard` replaced.
  /// - param newChild: The new `wildcard` to replace the node's
  ///                   current `wildcard`, if present.
  public func withWildcard(
    _ newChild: TokenSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.wildcardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return WildcardPatternSyntax(newData)
  }

  public var garbageBetweenWildcardAndTypeAnnotation: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWildcardAndTypeAnnotation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWildcardAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWildcardAndTypeAnnotation` replaced.
  /// - param newChild: The new `garbageBetweenWildcardAndTypeAnnotation` to replace the node's
  ///                   current `garbageBetweenWildcardAndTypeAnnotation`, if present.
  public func withGarbageBetweenWildcardAndTypeAnnotation(
    _ newChild: GarbageNodesSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWildcardAndTypeAnnotation)
    return WildcardPatternSyntax(newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: Cursor.typeAnnotation,
                                 parent: Syntax(self))
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
    _ newChild: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return WildcardPatternSyntax(newData)
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
    // Check child #3 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeAnnotationSyntax.self))
    }
  }
}

extension WildcardPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeWildcard": garbageBeforeWildcard.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
      "garbageBetweenWildcardAndTypeAnnotation": garbageBetweenWildcardAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionPatternSyntax

public struct ExpressionPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ExpressionPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .expressionPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ExpressionPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeExpression` replaced.
  /// - param newChild: The new `garbageBeforeExpression` to replace the node's
  ///                   current `garbageBeforeExpression`, if present.
  public func withGarbageBeforeExpression(
    _ newChild: GarbageNodesSyntax?) -> ExpressionPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return ExpressionPatternSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression,
                                 parent: Syntax(self))
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
    _ newChild: ExprSyntax?) -> ExpressionPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionPatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension ExpressionPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ValueBindingPatternSyntax

public struct ValueBindingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLetOrVarKeyword
    case letOrVarKeyword
    case garbageBetweenLetOrVarKeywordAndValuePattern
    case valuePattern
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ValueBindingPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .valueBindingPattern else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ValueBindingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .valueBindingPattern)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLetOrVarKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLetOrVarKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLetOrVarKeyword` replaced.
  /// - param newChild: The new `garbageBeforeLetOrVarKeyword` to replace the node's
  ///                   current `garbageBeforeLetOrVarKeyword`, if present.
  public func withGarbageBeforeLetOrVarKeyword(
    _ newChild: GarbageNodesSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLetOrVarKeyword)
    return ValueBindingPatternSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.letKeyword)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return ValueBindingPatternSyntax(newData)
  }

  public var garbageBetweenLetOrVarKeywordAndValuePattern: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLetOrVarKeywordAndValuePattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLetOrVarKeywordAndValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLetOrVarKeywordAndValuePattern` replaced.
  /// - param newChild: The new `garbageBetweenLetOrVarKeywordAndValuePattern` to replace the node's
  ///                   current `garbageBetweenLetOrVarKeywordAndValuePattern`, if present.
  public func withGarbageBetweenLetOrVarKeywordAndValuePattern(
    _ newChild: GarbageNodesSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLetOrVarKeywordAndValuePattern)
    return ValueBindingPatternSyntax(newData)
  }

  public var valuePattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.valuePattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `valuePattern` replaced.
  /// - param newChild: The new `valuePattern` to replace the node's
  ///                   current `valuePattern`, if present.
  public func withValuePattern(
    _ newChild: PatternSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingPattern)
    let newData = data.replacingChild(raw, at: Cursor.valuePattern)
    return ValueBindingPatternSyntax(newData)
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
    // Check child #3 child is PatternSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
  }
}

extension ValueBindingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLetOrVarKeyword": garbageBeforeLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLetOrVarKeywordAndValuePattern": garbageBetweenLetOrVarKeywordAndValuePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valuePattern": Syntax(valuePattern).asProtocol(SyntaxProtocol.self),
    ])
  }
}

