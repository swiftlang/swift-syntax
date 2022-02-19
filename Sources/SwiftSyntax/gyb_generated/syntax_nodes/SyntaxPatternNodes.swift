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

// MARK: - EnumCasePatternSyntax

public struct EnumCasePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case type
    case period
    case caseName
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
    assert(rawChildren.count == 4)
    // Check child #0 child is TypeSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
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
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TuplePatternSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
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
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "caseName": Syntax(caseName).asProtocol(SyntaxProtocol.self),
      "associatedTuple": associatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsTypePatternSyntax

public struct IsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case isKeyword
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return IsTypePatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "isKeyword": Syntax(isKeyword).asProtocol(SyntaxProtocol.self),
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - OptionalPatternSyntax

public struct OptionalPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case subPattern
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.subPattern)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is PatternSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
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

extension OptionalPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "subPattern": Syntax(subPattern).asProtocol(SyntaxProtocol.self),
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IdentifierPatternSyntax

public struct IdentifierPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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
    assert(rawChildren.count == 1)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
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
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AsTypePatternSyntax

public struct AsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case pattern
    case asKeyword
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return AsTypePatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is PatternSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
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
    // Check child #2 child is TypeSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
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
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "asKeyword": Syntax(asKeyword).asProtocol(SyntaxProtocol.self),
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TuplePatternSyntax

public struct TuplePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case elements
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
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TuplePatternElementListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TuplePatternElementListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
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
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - WildcardPatternSyntax

public struct WildcardPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case wildcard
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
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionPatternSyntax

public struct ExpressionPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionPatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 1)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
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
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ValueBindingPatternSyntax

public struct ValueBindingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case letOrVarKeyword
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.valuePattern)
    return ValueBindingPatternSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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
  }
}

extension ValueBindingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "valuePattern": Syntax(valuePattern).asProtocol(SyntaxProtocol.self),
    ])
  }
}

