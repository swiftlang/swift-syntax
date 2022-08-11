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


// MARK: - UnknownExprSyntax

public struct UnknownExprSyntax: ExprSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnknownExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknownExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnknownExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknownExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unknownExpr,
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

extension UnknownExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - MissingExprSyntax

public struct MissingExprSyntax: ExprSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missingExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.missingExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 0)
  }
}

extension MissingExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - InOutExprSyntax

public struct InOutExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAmpersand
    case ampersand
    case garbageBetweenAmpersandAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `InOutExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .inOutExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `InOutExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .inOutExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeAmpersand: GarbageNodesSyntax? = nil,
    ampersand: TokenSyntax,
    _ garbageBetweenAmpersandAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAmpersand?.raw,
      ampersand.raw,
      garbageBetweenAmpersandAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inOutExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAmpersand: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAmpersand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAmpersand(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAmpersand` replaced.
  /// - param newChild: The new `garbageBeforeAmpersand` to replace the node's
  ///                   current `garbageBeforeAmpersand`, if present.
  public func withGarbageBeforeAmpersand(
    _ newChild: GarbageNodesSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAmpersand)
    return InOutExprSyntax(newData)
  }

  public var ampersand: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ampersand,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAmpersand(value)
    }
  }

  /// Returns a copy of the receiver with its `ampersand` replaced.
  /// - param newChild: The new `ampersand` to replace the node's
  ///                   current `ampersand`, if present.
  public func withAmpersand(
    _ newChild: TokenSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.prefixAmpersand)
    let newData = data.replacingChild(raw, at: Cursor.ampersand)
    return InOutExprSyntax(newData)
  }

  public var garbageBetweenAmpersandAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAmpersandAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAmpersandAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAmpersandAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenAmpersandAndExpression` to replace the node's
  ///                   current `garbageBetweenAmpersandAndExpression`, if present.
  public func withGarbageBetweenAmpersandAndExpression(
    _ newChild: GarbageNodesSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAmpersandAndExpression)
    return InOutExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return InOutExprSyntax(newData)
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
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension InOutExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAmpersand": garbageBeforeAmpersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ampersand": Syntax(ampersand).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAmpersandAndExpression": garbageBetweenAmpersandAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundColumnExprSyntax

public struct PoundColumnExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundColumn
    case poundColumn
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundColumnExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundColumnExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundColumnExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundColumnExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundColumn: GarbageNodesSyntax? = nil,
    poundColumn: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundColumn?.raw,
      poundColumn.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundColumnExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundColumn: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundColumn,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundColumn(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundColumn` replaced.
  /// - param newChild: The new `garbageBeforePoundColumn` to replace the node's
  ///                   current `garbageBeforePoundColumn`, if present.
  public func withGarbageBeforePoundColumn(
    _ newChild: GarbageNodesSyntax?) -> PoundColumnExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundColumn)
    return PoundColumnExprSyntax(newData)
  }

  public var poundColumn: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundColumn,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundColumn(value)
    }
  }

  /// Returns a copy of the receiver with its `poundColumn` replaced.
  /// - param newChild: The new `poundColumn` to replace the node's
  ///                   current `poundColumn`, if present.
  public func withPoundColumn(
    _ newChild: TokenSyntax?) -> PoundColumnExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundColumnKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundColumn)
    return PoundColumnExprSyntax(newData)
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

extension PoundColumnExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundColumn": garbageBeforePoundColumn.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundColumn": Syntax(poundColumn).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TryExprSyntax

public struct TryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeTryKeyword
    case tryKeyword
    case garbageBetweenTryKeywordAndQuestionOrExclamationMark
    case questionOrExclamationMark
    case garbageBetweenQuestionOrExclamationMarkAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tryExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tryExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeTryKeyword: GarbageNodesSyntax? = nil,
    tryKeyword: TokenSyntax,
    _ garbageBetweenTryKeywordAndQuestionOrExclamationMark: GarbageNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax?,
    _ garbageBetweenQuestionOrExclamationMarkAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeTryKeyword?.raw,
      tryKeyword.raw,
      garbageBetweenTryKeywordAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      garbageBetweenQuestionOrExclamationMarkAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeTryKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeTryKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeTryKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeTryKeyword` replaced.
  /// - param newChild: The new `garbageBeforeTryKeyword` to replace the node's
  ///                   current `garbageBeforeTryKeyword`, if present.
  public func withGarbageBeforeTryKeyword(
    _ newChild: GarbageNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeTryKeyword)
    return TryExprSyntax(newData)
  }

  public var tryKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.tryKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTryKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `tryKeyword` replaced.
  /// - param newChild: The new `tryKeyword` to replace the node's
  ///                   current `tryKeyword`, if present.
  public func withTryKeyword(
    _ newChild: TokenSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.tryKeyword)
    let newData = data.replacingChild(raw, at: Cursor.tryKeyword)
    return TryExprSyntax(newData)
  }

  public var garbageBetweenTryKeywordAndQuestionOrExclamationMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTryKeywordAndQuestionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTryKeywordAndQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTryKeywordAndQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `garbageBetweenTryKeywordAndQuestionOrExclamationMark` to replace the node's
  ///                   current `garbageBetweenTryKeywordAndQuestionOrExclamationMark`, if present.
  public func withGarbageBetweenTryKeywordAndQuestionOrExclamationMark(
    _ newChild: GarbageNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTryKeywordAndQuestionOrExclamationMark)
    return TryExprSyntax(newData)
  }

  public var questionOrExclamationMark: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.questionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `questionOrExclamationMark` replaced.
  /// - param newChild: The new `questionOrExclamationMark` to replace the node's
  ///                   current `questionOrExclamationMark`, if present.
  public func withQuestionOrExclamationMark(
    _ newChild: TokenSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.questionOrExclamationMark)
    return TryExprSyntax(newData)
  }

  public var garbageBetweenQuestionOrExclamationMarkAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenQuestionOrExclamationMarkAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenQuestionOrExclamationMarkAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenQuestionOrExclamationMarkAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenQuestionOrExclamationMarkAndExpression` to replace the node's
  ///                   current `garbageBetweenQuestionOrExclamationMarkAndExpression`, if present.
  public func withGarbageBetweenQuestionOrExclamationMarkAndExpression(
    _ newChild: GarbageNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenQuestionOrExclamationMarkAndExpression)
    return TryExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TryExprSyntax(newData)
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
    // Check child #3 child is TokenSyntax or missing
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
    // Check child #5 child is ExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension TryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeTryKeyword": garbageBeforeTryKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "tryKeyword": Syntax(tryKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenTryKeywordAndQuestionOrExclamationMark": garbageBetweenTryKeywordAndQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenQuestionOrExclamationMarkAndExpression": garbageBetweenQuestionOrExclamationMarkAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AwaitExprSyntax

public struct AwaitExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAwaitKeyword
    case awaitKeyword
    case garbageBetweenAwaitKeywordAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AwaitExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .awaitExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AwaitExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .awaitExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeAwaitKeyword: GarbageNodesSyntax? = nil,
    awaitKeyword: TokenSyntax,
    _ garbageBetweenAwaitKeywordAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAwaitKeyword?.raw,
      awaitKeyword.raw,
      garbageBetweenAwaitKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.awaitExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAwaitKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAwaitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAwaitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAwaitKeyword` replaced.
  /// - param newChild: The new `garbageBeforeAwaitKeyword` to replace the node's
  ///                   current `garbageBeforeAwaitKeyword`, if present.
  public func withGarbageBeforeAwaitKeyword(
    _ newChild: GarbageNodesSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAwaitKeyword)
    return AwaitExprSyntax(newData)
  }

  public var awaitKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.awaitKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAwaitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `awaitKeyword` replaced.
  /// - param newChild: The new `awaitKeyword` to replace the node's
  ///                   current `awaitKeyword`, if present.
  public func withAwaitKeyword(
    _ newChild: TokenSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.contextualKeyword(""))
    let newData = data.replacingChild(raw, at: Cursor.awaitKeyword)
    return AwaitExprSyntax(newData)
  }

  public var garbageBetweenAwaitKeywordAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAwaitKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAwaitKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAwaitKeywordAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenAwaitKeywordAndExpression` to replace the node's
  ///                   current `garbageBetweenAwaitKeywordAndExpression`, if present.
  public func withGarbageBetweenAwaitKeywordAndExpression(
    _ newChild: GarbageNodesSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAwaitKeywordAndExpression)
    return AwaitExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return AwaitExprSyntax(newData)
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
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension AwaitExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAwaitKeyword": garbageBeforeAwaitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "awaitKeyword": Syntax(awaitKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAwaitKeywordAndExpression": garbageBetweenAwaitKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MoveExprSyntax

public struct MoveExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeMoveKeyword
    case moveKeyword
    case garbageBetweenMoveKeywordAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MoveExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .moveExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MoveExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .moveExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeMoveKeyword: GarbageNodesSyntax? = nil,
    moveKeyword: TokenSyntax,
    _ garbageBetweenMoveKeywordAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeMoveKeyword?.raw,
      moveKeyword.raw,
      garbageBetweenMoveKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.moveExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeMoveKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeMoveKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeMoveKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeMoveKeyword` replaced.
  /// - param newChild: The new `garbageBeforeMoveKeyword` to replace the node's
  ///                   current `garbageBeforeMoveKeyword`, if present.
  public func withGarbageBeforeMoveKeyword(
    _ newChild: GarbageNodesSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeMoveKeyword)
    return MoveExprSyntax(newData)
  }

  public var moveKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.moveKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withMoveKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `moveKeyword` replaced.
  /// - param newChild: The new `moveKeyword` to replace the node's
  ///                   current `moveKeyword`, if present.
  public func withMoveKeyword(
    _ newChild: TokenSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.contextualKeyword(""))
    let newData = data.replacingChild(raw, at: Cursor.moveKeyword)
    return MoveExprSyntax(newData)
  }

  public var garbageBetweenMoveKeywordAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenMoveKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenMoveKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenMoveKeywordAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenMoveKeywordAndExpression` to replace the node's
  ///                   current `garbageBetweenMoveKeywordAndExpression`, if present.
  public func withGarbageBetweenMoveKeywordAndExpression(
    _ newChild: GarbageNodesSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenMoveKeywordAndExpression)
    return MoveExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return MoveExprSyntax(newData)
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
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension MoveExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeMoveKeyword": garbageBeforeMoveKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "moveKeyword": Syntax(moveKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenMoveKeywordAndExpression": garbageBetweenMoveKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IdentifierExprSyntax

public struct IdentifierExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIdentifier
    case identifier
    case garbageBetweenIdentifierAndDeclNameArguments
    case declNameArguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IdentifierExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .identifierExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IdentifierExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .identifierExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndDeclNameArguments: GarbageNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIdentifier)
    return IdentifierExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return IdentifierExprSyntax(newData)
  }

  public var garbageBetweenIdentifierAndDeclNameArguments: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndDeclNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndDeclNameArguments` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndDeclNameArguments` to replace the node's
  ///                   current `garbageBetweenIdentifierAndDeclNameArguments`, if present.
  public func withGarbageBetweenIdentifierAndDeclNameArguments(
    _ newChild: GarbageNodesSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndDeclNameArguments)
    return IdentifierExprSyntax(newData)
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return IdentifierExprSyntax(newData)
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
    // Check child #3 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension IdentifierExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIdentifier": garbageBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndDeclNameArguments": garbageBetweenIdentifierAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SuperRefExprSyntax

public struct SuperRefExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeSuperKeyword
    case superKeyword
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SuperRefExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .superRefExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SuperRefExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .superRefExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeSuperKeyword: GarbageNodesSyntax? = nil,
    superKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeSuperKeyword?.raw,
      superKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.superRefExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeSuperKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeSuperKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeSuperKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeSuperKeyword` replaced.
  /// - param newChild: The new `garbageBeforeSuperKeyword` to replace the node's
  ///                   current `garbageBeforeSuperKeyword`, if present.
  public func withGarbageBeforeSuperKeyword(
    _ newChild: GarbageNodesSyntax?) -> SuperRefExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeSuperKeyword)
    return SuperRefExprSyntax(newData)
  }

  public var superKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.superKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSuperKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `superKeyword` replaced.
  /// - param newChild: The new `superKeyword` to replace the node's
  ///                   current `superKeyword`, if present.
  public func withSuperKeyword(
    _ newChild: TokenSyntax?) -> SuperRefExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.superKeyword)
    let newData = data.replacingChild(raw, at: Cursor.superKeyword)
    return SuperRefExprSyntax(newData)
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

extension SuperRefExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeSuperKeyword": garbageBeforeSuperKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "superKeyword": Syntax(superKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - NilLiteralExprSyntax

public struct NilLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeNilKeyword
    case nilKeyword
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `NilLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .nilLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `NilLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .nilLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeNilKeyword: GarbageNodesSyntax? = nil,
    nilKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeNilKeyword?.raw,
      nilKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.nilLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeNilKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeNilKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeNilKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeNilKeyword` replaced.
  /// - param newChild: The new `garbageBeforeNilKeyword` to replace the node's
  ///                   current `garbageBeforeNilKeyword`, if present.
  public func withGarbageBeforeNilKeyword(
    _ newChild: GarbageNodesSyntax?) -> NilLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeNilKeyword)
    return NilLiteralExprSyntax(newData)
  }

  public var nilKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.nilKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withNilKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `nilKeyword` replaced.
  /// - param newChild: The new `nilKeyword` to replace the node's
  ///                   current `nilKeyword`, if present.
  public func withNilKeyword(
    _ newChild: TokenSyntax?) -> NilLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.nilKeyword)
    let newData = data.replacingChild(raw, at: Cursor.nilKeyword)
    return NilLiteralExprSyntax(newData)
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

extension NilLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeNilKeyword": garbageBeforeNilKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "nilKeyword": Syntax(nilKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DiscardAssignmentExprSyntax

public struct DiscardAssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeWildcard
    case wildcard
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DiscardAssignmentExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .discardAssignmentExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DiscardAssignmentExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .discardAssignmentExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeWildcard: GarbageNodesSyntax? = nil,
    wildcard: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeWildcard?.raw,
      wildcard.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.discardAssignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeWildcard)
    return DiscardAssignmentExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.wildcardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return DiscardAssignmentExprSyntax(newData)
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

extension DiscardAssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeWildcard": garbageBeforeWildcard.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AssignmentExprSyntax

public struct AssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAssignToken
    case assignToken
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AssignmentExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .assignmentExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AssignmentExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .assignmentExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeAssignToken: GarbageNodesSyntax? = nil,
    assignToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAssignToken?.raw,
      assignToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.assignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAssignToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAssignToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAssignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAssignToken` replaced.
  /// - param newChild: The new `garbageBeforeAssignToken` to replace the node's
  ///                   current `garbageBeforeAssignToken`, if present.
  public func withGarbageBeforeAssignToken(
    _ newChild: GarbageNodesSyntax?) -> AssignmentExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAssignToken)
    return AssignmentExprSyntax(newData)
  }

  public var assignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.assignToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAssignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `assignToken` replaced.
  /// - param newChild: The new `assignToken` to replace the node's
  ///                   current `assignToken`, if present.
  public func withAssignToken(
    _ newChild: TokenSyntax?) -> AssignmentExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.equal)
    let newData = data.replacingChild(raw, at: Cursor.assignToken)
    return AssignmentExprSyntax(newData)
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

extension AssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAssignToken": garbageBeforeAssignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignToken": Syntax(assignToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SequenceExprSyntax

public struct SequenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeElements
    case elements
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SequenceExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .sequenceExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SequenceExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .sequenceExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeElements: GarbageNodesSyntax? = nil,
    elements: ExprListSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sequenceExpr,
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
    _ newChild: GarbageNodesSyntax?) -> SequenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeElements)
    return SequenceExprSyntax(newData)
  }

  public var elements: ExprListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
      return ExprListSyntax(childData!)
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
  public func addElement(_ element: ExprSyntax) -> SequenceExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.exprList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return SequenceExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: ExprListSyntax?) -> SequenceExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.exprList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return SequenceExprSyntax(newData)
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
    // Check child #1 child is ExprListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprListSyntax.self))
    }
  }
}

extension SequenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeElements": garbageBeforeElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundLineExprSyntax

public struct PoundLineExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundLine
    case poundLine
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundLineExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundLineExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundLineExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundLineExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundLine: GarbageNodesSyntax? = nil,
    poundLine: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundLine?.raw,
      poundLine.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundLineExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundLine: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundLine,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundLine(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundLine` replaced.
  /// - param newChild: The new `garbageBeforePoundLine` to replace the node's
  ///                   current `garbageBeforePoundLine`, if present.
  public func withGarbageBeforePoundLine(
    _ newChild: GarbageNodesSyntax?) -> PoundLineExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundLine)
    return PoundLineExprSyntax(newData)
  }

  public var poundLine: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundLine,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundLine(value)
    }
  }

  /// Returns a copy of the receiver with its `poundLine` replaced.
  /// - param newChild: The new `poundLine` to replace the node's
  ///                   current `poundLine`, if present.
  public func withPoundLine(
    _ newChild: TokenSyntax?) -> PoundLineExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundLineKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundLine)
    return PoundLineExprSyntax(newData)
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

extension PoundLineExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundLine": garbageBeforePoundLine.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundLine": Syntax(poundLine).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileExprSyntax

public struct PoundFileExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundFile
    case poundFile
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundFileExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundFileExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundFileExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundFileExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundFile: GarbageNodesSyntax? = nil,
    poundFile: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFile?.raw,
      poundFile.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundFile: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundFile,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundFile(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundFile` replaced.
  /// - param newChild: The new `garbageBeforePoundFile` to replace the node's
  ///                   current `garbageBeforePoundFile`, if present.
  public func withGarbageBeforePoundFile(
    _ newChild: GarbageNodesSyntax?) -> PoundFileExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundFile)
    return PoundFileExprSyntax(newData)
  }

  public var poundFile: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFile,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundFile(value)
    }
  }

  /// Returns a copy of the receiver with its `poundFile` replaced.
  /// - param newChild: The new `poundFile` to replace the node's
  ///                   current `poundFile`, if present.
  public func withPoundFile(
    _ newChild: TokenSyntax?) -> PoundFileExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFile)
    return PoundFileExprSyntax(newData)
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

extension PoundFileExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundFile": garbageBeforePoundFile.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFile": Syntax(poundFile).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileIDExprSyntax

public struct PoundFileIDExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundFileID
    case poundFileID
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundFileIDExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundFileIDExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundFileIDExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundFileIDExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundFileID: GarbageNodesSyntax? = nil,
    poundFileID: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFileID?.raw,
      poundFileID.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileIDExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundFileID: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundFileID,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundFileID(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundFileID` replaced.
  /// - param newChild: The new `garbageBeforePoundFileID` to replace the node's
  ///                   current `garbageBeforePoundFileID`, if present.
  public func withGarbageBeforePoundFileID(
    _ newChild: GarbageNodesSyntax?) -> PoundFileIDExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundFileID)
    return PoundFileIDExprSyntax(newData)
  }

  public var poundFileID: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFileID,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundFileID(value)
    }
  }

  /// Returns a copy of the receiver with its `poundFileID` replaced.
  /// - param newChild: The new `poundFileID` to replace the node's
  ///                   current `poundFileID`, if present.
  public func withPoundFileID(
    _ newChild: TokenSyntax?) -> PoundFileIDExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFileIDKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFileID)
    return PoundFileIDExprSyntax(newData)
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

extension PoundFileIDExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundFileID": garbageBeforePoundFileID.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFileID": Syntax(poundFileID).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFilePathExprSyntax

public struct PoundFilePathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundFilePath
    case poundFilePath
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundFilePathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundFilePathExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundFilePathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundFilePathExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundFilePath: GarbageNodesSyntax? = nil,
    poundFilePath: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFilePath?.raw,
      poundFilePath.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFilePathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundFilePath: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundFilePath,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundFilePath(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundFilePath` replaced.
  /// - param newChild: The new `garbageBeforePoundFilePath` to replace the node's
  ///                   current `garbageBeforePoundFilePath`, if present.
  public func withGarbageBeforePoundFilePath(
    _ newChild: GarbageNodesSyntax?) -> PoundFilePathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundFilePath)
    return PoundFilePathExprSyntax(newData)
  }

  public var poundFilePath: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFilePath,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundFilePath(value)
    }
  }

  /// Returns a copy of the receiver with its `poundFilePath` replaced.
  /// - param newChild: The new `poundFilePath` to replace the node's
  ///                   current `poundFilePath`, if present.
  public func withPoundFilePath(
    _ newChild: TokenSyntax?) -> PoundFilePathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFilePathKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFilePath)
    return PoundFilePathExprSyntax(newData)
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

extension PoundFilePathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundFilePath": garbageBeforePoundFilePath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFilePath": Syntax(poundFilePath).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFunctionExprSyntax

public struct PoundFunctionExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundFunction
    case poundFunction
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundFunctionExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundFunctionExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundFunctionExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundFunctionExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundFunction: GarbageNodesSyntax? = nil,
    poundFunction: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFunction?.raw,
      poundFunction.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFunctionExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundFunction: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundFunction,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundFunction(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundFunction` replaced.
  /// - param newChild: The new `garbageBeforePoundFunction` to replace the node's
  ///                   current `garbageBeforePoundFunction`, if present.
  public func withGarbageBeforePoundFunction(
    _ newChild: GarbageNodesSyntax?) -> PoundFunctionExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundFunction)
    return PoundFunctionExprSyntax(newData)
  }

  public var poundFunction: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFunction,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundFunction(value)
    }
  }

  /// Returns a copy of the receiver with its `poundFunction` replaced.
  /// - param newChild: The new `poundFunction` to replace the node's
  ///                   current `poundFunction`, if present.
  public func withPoundFunction(
    _ newChild: TokenSyntax?) -> PoundFunctionExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFunctionKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFunction)
    return PoundFunctionExprSyntax(newData)
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

extension PoundFunctionExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundFunction": garbageBeforePoundFunction.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFunction": Syntax(poundFunction).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundDsohandleExprSyntax

public struct PoundDsohandleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundDsohandle
    case poundDsohandle
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundDsohandleExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundDsohandleExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundDsohandleExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundDsohandleExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundDsohandle: GarbageNodesSyntax? = nil,
    poundDsohandle: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundDsohandle?.raw,
      poundDsohandle.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundDsohandleExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundDsohandle: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundDsohandle,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundDsohandle(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundDsohandle` replaced.
  /// - param newChild: The new `garbageBeforePoundDsohandle` to replace the node's
  ///                   current `garbageBeforePoundDsohandle`, if present.
  public func withGarbageBeforePoundDsohandle(
    _ newChild: GarbageNodesSyntax?) -> PoundDsohandleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundDsohandle)
    return PoundDsohandleExprSyntax(newData)
  }

  public var poundDsohandle: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundDsohandle,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundDsohandle(value)
    }
  }

  /// Returns a copy of the receiver with its `poundDsohandle` replaced.
  /// - param newChild: The new `poundDsohandle` to replace the node's
  ///                   current `poundDsohandle`, if present.
  public func withPoundDsohandle(
    _ newChild: TokenSyntax?) -> PoundDsohandleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundDsohandleKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundDsohandle)
    return PoundDsohandleExprSyntax(newData)
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

extension PoundDsohandleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundDsohandle": garbageBeforePoundDsohandle.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundDsohandle": Syntax(poundDsohandle).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SymbolicReferenceExprSyntax

public struct SymbolicReferenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIdentifier
    case identifier
    case garbageBetweenIdentifierAndGenericArgumentClause
    case genericArgumentClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SymbolicReferenceExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .symbolicReferenceExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SymbolicReferenceExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .symbolicReferenceExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndGenericArgumentClause: GarbageNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.symbolicReferenceExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIdentifier)
    return SymbolicReferenceExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return SymbolicReferenceExprSyntax(newData)
  }

  public var garbageBetweenIdentifierAndGenericArgumentClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndGenericArgumentClause` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndGenericArgumentClause` to replace the node's
  ///                   current `garbageBetweenIdentifierAndGenericArgumentClause`, if present.
  public func withGarbageBetweenIdentifierAndGenericArgumentClause(
    _ newChild: GarbageNodesSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndGenericArgumentClause)
    return SymbolicReferenceExprSyntax(newData)
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
    _ newChild: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SymbolicReferenceExprSyntax(newData)
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
    // Check child #3 child is GenericArgumentClauseSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericArgumentClauseSyntax.self))
    }
  }
}

extension SymbolicReferenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIdentifier": garbageBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndGenericArgumentClause": garbageBetweenIdentifierAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrefixOperatorExprSyntax

public struct PrefixOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeOperatorToken
    case operatorToken
    case garbageBetweenOperatorTokenAndPostfixExpression
    case postfixExpression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrefixOperatorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .prefixOperatorExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrefixOperatorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .prefixOperatorExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeOperatorToken: GarbageNodesSyntax? = nil,
    operatorToken: TokenSyntax?,
    _ garbageBetweenOperatorTokenAndPostfixExpression: GarbageNodesSyntax? = nil,
    postfixExpression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeOperatorToken?.raw,
      operatorToken?.raw,
      garbageBetweenOperatorTokenAndPostfixExpression?.raw,
      postfixExpression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.prefixOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeOperatorToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeOperatorToken` replaced.
  /// - param newChild: The new `garbageBeforeOperatorToken` to replace the node's
  ///                   current `garbageBeforeOperatorToken`, if present.
  public func withGarbageBeforeOperatorToken(
    _ newChild: GarbageNodesSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeOperatorToken)
    return PrefixOperatorExprSyntax(newData)
  }

  public var operatorToken: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.operatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return PrefixOperatorExprSyntax(newData)
  }

  public var garbageBetweenOperatorTokenAndPostfixExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOperatorTokenAndPostfixExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOperatorTokenAndPostfixExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOperatorTokenAndPostfixExpression` replaced.
  /// - param newChild: The new `garbageBetweenOperatorTokenAndPostfixExpression` to replace the node's
  ///                   current `garbageBetweenOperatorTokenAndPostfixExpression`, if present.
  public func withGarbageBetweenOperatorTokenAndPostfixExpression(
    _ newChild: GarbageNodesSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOperatorTokenAndPostfixExpression)
    return PrefixOperatorExprSyntax(newData)
  }

  public var postfixExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.postfixExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withPostfixExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `postfixExpression` replaced.
  /// - param newChild: The new `postfixExpression` to replace the node's
  ///                   current `postfixExpression`, if present.
  public func withPostfixExpression(
    _ newChild: ExprSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.postfixExpression)
    return PrefixOperatorExprSyntax(newData)
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
    // Check child #1 child is TokenSyntax or missing
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
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension PrefixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeOperatorToken": garbageBeforeOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": operatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenOperatorTokenAndPostfixExpression": garbageBetweenOperatorTokenAndPostfixExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "postfixExpression": Syntax(postfixExpression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BinaryOperatorExprSyntax

public struct BinaryOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeOperatorToken
    case operatorToken
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `BinaryOperatorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .binaryOperatorExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `BinaryOperatorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .binaryOperatorExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeOperatorToken: GarbageNodesSyntax? = nil,
    operatorToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.binaryOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeOperatorToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeOperatorToken` replaced.
  /// - param newChild: The new `garbageBeforeOperatorToken` to replace the node's
  ///                   current `garbageBeforeOperatorToken`, if present.
  public func withGarbageBeforeOperatorToken(
    _ newChild: GarbageNodesSyntax?) -> BinaryOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeOperatorToken)
    return BinaryOperatorExprSyntax(newData)
  }

  public var operatorToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.operatorToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> BinaryOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return BinaryOperatorExprSyntax(newData)
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

extension BinaryOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeOperatorToken": garbageBeforeOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrowExprSyntax

public struct ArrowExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAsyncKeyword
    case asyncKeyword
    case garbageBetweenAsyncKeywordAndThrowsToken
    case throwsToken
    case garbageBetweenThrowsTokenAndArrowToken
    case arrowToken
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ArrowExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .arrowExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ArrowExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrowExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeAsyncKeyword: GarbageNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsToken: GarbageNodesSyntax? = nil,
    throwsToken: TokenSyntax?,
    _ garbageBetweenThrowsTokenAndArrowToken: GarbageNodesSyntax? = nil,
    arrowToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsToken?.raw,
      throwsToken?.raw,
      garbageBetweenThrowsTokenAndArrowToken?.raw,
      arrowToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrowExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAsyncKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAsyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAsyncKeyword` replaced.
  /// - param newChild: The new `garbageBeforeAsyncKeyword` to replace the node's
  ///                   current `garbageBeforeAsyncKeyword`, if present.
  public func withGarbageBeforeAsyncKeyword(
    _ newChild: GarbageNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAsyncKeyword)
    return ArrowExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.asyncKeyword)
    return ArrowExprSyntax(newData)
  }

  public var garbageBetweenAsyncKeywordAndThrowsToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAsyncKeywordAndThrowsToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAsyncKeywordAndThrowsToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAsyncKeywordAndThrowsToken` replaced.
  /// - param newChild: The new `garbageBetweenAsyncKeywordAndThrowsToken` to replace the node's
  ///                   current `garbageBetweenAsyncKeywordAndThrowsToken`, if present.
  public func withGarbageBetweenAsyncKeywordAndThrowsToken(
    _ newChild: GarbageNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAsyncKeywordAndThrowsToken)
    return ArrowExprSyntax(newData)
  }

  public var throwsToken: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withThrowsToken(value)
    }
  }

  /// Returns a copy of the receiver with its `throwsToken` replaced.
  /// - param newChild: The new `throwsToken` to replace the node's
  ///                   current `throwsToken`, if present.
  public func withThrowsToken(
    _ newChild: TokenSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsToken)
    return ArrowExprSyntax(newData)
  }

  public var garbageBetweenThrowsTokenAndArrowToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenThrowsTokenAndArrowToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenThrowsTokenAndArrowToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenThrowsTokenAndArrowToken` replaced.
  /// - param newChild: The new `garbageBetweenThrowsTokenAndArrowToken` to replace the node's
  ///                   current `garbageBetweenThrowsTokenAndArrowToken`, if present.
  public func withGarbageBetweenThrowsTokenAndArrowToken(
    _ newChild: GarbageNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenThrowsTokenAndArrowToken)
    return ArrowExprSyntax(newData)
  }

  public var arrowToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.arrowToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withArrowToken(value)
    }
  }

  /// Returns a copy of the receiver with its `arrowToken` replaced.
  /// - param newChild: The new `arrowToken` to replace the node's
  ///                   current `arrowToken`, if present.
  public func withArrowToken(
    _ newChild: TokenSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.arrow)
    let newData = data.replacingChild(raw, at: Cursor.arrowToken)
    return ArrowExprSyntax(newData)
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
    // Check child #1 child is TokenSyntax or missing
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
    // Check child #3 child is TokenSyntax or missing
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
  }
}

extension ArrowExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAsyncKeyword": garbageBeforeAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAsyncKeywordAndThrowsToken": garbageBetweenAsyncKeywordAndThrowsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsToken": throwsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenThrowsTokenAndArrowToken": garbageBetweenThrowsTokenAndArrowToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrowToken": Syntax(arrowToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - InfixOperatorExprSyntax

public struct InfixOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftOperand
    case leftOperand
    case garbageBetweenLeftOperandAndOperatorOperand
    case operatorOperand
    case garbageBetweenOperatorOperandAndRightOperand
    case rightOperand
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `InfixOperatorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .infixOperatorExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `InfixOperatorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .infixOperatorExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftOperand: GarbageNodesSyntax? = nil,
    leftOperand: ExprSyntax,
    _ garbageBetweenLeftOperandAndOperatorOperand: GarbageNodesSyntax? = nil,
    operatorOperand: ExprSyntax,
    _ garbageBetweenOperatorOperandAndRightOperand: GarbageNodesSyntax? = nil,
    rightOperand: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftOperand?.raw,
      leftOperand.raw,
      garbageBetweenLeftOperandAndOperatorOperand?.raw,
      operatorOperand.raw,
      garbageBetweenOperatorOperandAndRightOperand?.raw,
      rightOperand.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.infixOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftOperand: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftOperand` replaced.
  /// - param newChild: The new `garbageBeforeLeftOperand` to replace the node's
  ///                   current `garbageBeforeLeftOperand`, if present.
  public func withGarbageBeforeLeftOperand(
    _ newChild: GarbageNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var leftOperand: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.leftOperand,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withLeftOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `leftOperand` replaced.
  /// - param newChild: The new `leftOperand` to replace the node's
  ///                   current `leftOperand`, if present.
  public func withLeftOperand(
    _ newChild: ExprSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.leftOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var garbageBetweenLeftOperandAndOperatorOperand: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftOperandAndOperatorOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftOperandAndOperatorOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftOperandAndOperatorOperand` replaced.
  /// - param newChild: The new `garbageBetweenLeftOperandAndOperatorOperand` to replace the node's
  ///                   current `garbageBetweenLeftOperandAndOperatorOperand`, if present.
  public func withGarbageBetweenLeftOperandAndOperatorOperand(
    _ newChild: GarbageNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftOperandAndOperatorOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var operatorOperand: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.operatorOperand,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withOperatorOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorOperand` replaced.
  /// - param newChild: The new `operatorOperand` to replace the node's
  ///                   current `operatorOperand`, if present.
  public func withOperatorOperand(
    _ newChild: ExprSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.operatorOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var garbageBetweenOperatorOperandAndRightOperand: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOperatorOperandAndRightOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOperatorOperandAndRightOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOperatorOperandAndRightOperand` replaced.
  /// - param newChild: The new `garbageBetweenOperatorOperandAndRightOperand` to replace the node's
  ///                   current `garbageBetweenOperatorOperandAndRightOperand`, if present.
  public func withGarbageBetweenOperatorOperandAndRightOperand(
    _ newChild: GarbageNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOperatorOperandAndRightOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var rightOperand: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.rightOperand,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withRightOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `rightOperand` replaced.
  /// - param newChild: The new `rightOperand` to replace the node's
  ///                   current `rightOperand`, if present.
  public func withRightOperand(
    _ newChild: ExprSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.rightOperand)
    return InfixOperatorExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is ExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension InfixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftOperand": garbageBeforeLeftOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftOperand": Syntax(leftOperand).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftOperandAndOperatorOperand": garbageBetweenLeftOperandAndOperatorOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorOperand": Syntax(operatorOperand).asProtocol(SyntaxProtocol.self),
      "garbageBetweenOperatorOperandAndRightOperand": garbageBetweenOperatorOperandAndRightOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightOperand": Syntax(rightOperand).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FloatLiteralExprSyntax

public struct FloatLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeFloatingDigits
    case floatingDigits
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FloatLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .floatLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FloatLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .floatLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeFloatingDigits: GarbageNodesSyntax? = nil,
    floatingDigits: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeFloatingDigits?.raw,
      floatingDigits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.floatLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeFloatingDigits: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeFloatingDigits,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeFloatingDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeFloatingDigits` replaced.
  /// - param newChild: The new `garbageBeforeFloatingDigits` to replace the node's
  ///                   current `garbageBeforeFloatingDigits`, if present.
  public func withGarbageBeforeFloatingDigits(
    _ newChild: GarbageNodesSyntax?) -> FloatLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeFloatingDigits)
    return FloatLiteralExprSyntax(newData)
  }

  public var floatingDigits: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.floatingDigits,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withFloatingDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `floatingDigits` replaced.
  /// - param newChild: The new `floatingDigits` to replace the node's
  ///                   current `floatingDigits`, if present.
  public func withFloatingDigits(
    _ newChild: TokenSyntax?) -> FloatLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.floatingLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.floatingDigits)
    return FloatLiteralExprSyntax(newData)
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

extension FloatLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeFloatingDigits": garbageBeforeFloatingDigits.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "floatingDigits": Syntax(floatingDigits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TupleExprSyntax

public struct TupleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftParen
    case leftParen
    case garbageBetweenLeftParenAndElementList
    case elementList
    case garbageBetweenElementListAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TupleExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tupleExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TupleExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndElementList: GarbageNodesSyntax? = nil,
    elementList: TupleExprElementListSyntax,
    _ garbageBetweenElementListAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      garbageBetweenElementListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExpr,
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
    _ newChild: GarbageNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftParen)
    return TupleExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TupleExprSyntax(newData)
  }

  public var garbageBetweenLeftParenAndElementList: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndElementList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndElementList(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndElementList` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndElementList` to replace the node's
  ///                   current `garbageBetweenLeftParenAndElementList`, if present.
  public func withGarbageBetweenLeftParenAndElementList(
    _ newChild: GarbageNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndElementList)
    return TupleExprSyntax(newData)
  }

  public var elementList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elementList,
                                 parent: Syntax(self))
      return TupleExprElementListSyntax(childData!)
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
  public func addElement(_ element: TupleExprElementSyntax) -> TupleExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elementList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elementList)
    return TupleExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elementList` replaced.
  /// - param newChild: The new `elementList` to replace the node's
  ///                   current `elementList`, if present.
  public func withElementList(
    _ newChild: TupleExprElementListSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleExprElementList)
    let newData = data.replacingChild(raw, at: Cursor.elementList)
    return TupleExprSyntax(newData)
  }

  public var garbageBetweenElementListAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElementListAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElementListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElementListAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenElementListAndRightParen` to replace the node's
  ///                   current `garbageBetweenElementListAndRightParen`, if present.
  public func withGarbageBetweenElementListAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElementListAndRightParen)
    return TupleExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TupleExprSyntax(newData)
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
    // Check child #3 child is TupleExprElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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

extension TupleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftParen": garbageBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndElementList": garbageBetweenLeftParenAndElementList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self),
      "garbageBetweenElementListAndRightParen": garbageBetweenElementListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrayExprSyntax

public struct ArrayExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftSquare
    case leftSquare
    case garbageBetweenLeftSquareAndElements
    case elements
    case garbageBetweenElementsAndRightSquare
    case rightSquare
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ArrayExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .arrayExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ArrayExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrayExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftSquare: GarbageNodesSyntax? = nil,
    leftSquare: TokenSyntax,
    _ garbageBetweenLeftSquareAndElements: GarbageNodesSyntax? = nil,
    elements: ArrayElementListSyntax,
    _ garbageBetweenElementsAndRightSquare: GarbageNodesSyntax? = nil,
    rightSquare: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquare?.raw,
      leftSquare.raw,
      garbageBetweenLeftSquareAndElements?.raw,
      elements.raw,
      garbageBetweenElementsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftSquare: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftSquare` replaced.
  /// - param newChild: The new `garbageBeforeLeftSquare` to replace the node's
  ///                   current `garbageBeforeLeftSquare`, if present.
  public func withGarbageBeforeLeftSquare(
    _ newChild: GarbageNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftSquare)
    return ArrayExprSyntax(newData)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `leftSquare` replaced.
  /// - param newChild: The new `leftSquare` to replace the node's
  ///                   current `leftSquare`, if present.
  public func withLeftSquare(
    _ newChild: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return ArrayExprSyntax(newData)
  }

  public var garbageBetweenLeftSquareAndElements: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftSquareAndElements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftSquareAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftSquareAndElements` replaced.
  /// - param newChild: The new `garbageBetweenLeftSquareAndElements` to replace the node's
  ///                   current `garbageBetweenLeftSquareAndElements`, if present.
  public func withGarbageBetweenLeftSquareAndElements(
    _ newChild: GarbageNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftSquareAndElements)
    return ArrayExprSyntax(newData)
  }

  public var elements: ArrayElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
      return ArrayElementListSyntax(childData!)
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
  public func addElement(_ element: ArrayElementSyntax) -> ArrayExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.arrayElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return ArrayExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: ArrayElementListSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.arrayElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return ArrayExprSyntax(newData)
  }

  public var garbageBetweenElementsAndRightSquare: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElementsAndRightSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElementsAndRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElementsAndRightSquare` replaced.
  /// - param newChild: The new `garbageBetweenElementsAndRightSquare` to replace the node's
  ///                   current `garbageBetweenElementsAndRightSquare`, if present.
  public func withGarbageBetweenElementsAndRightSquare(
    _ newChild: GarbageNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElementsAndRightSquare)
    return ArrayExprSyntax(newData)
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `rightSquare` replaced.
  /// - param newChild: The new `rightSquare` to replace the node's
  ///                   current `rightSquare`, if present.
  public func withRightSquare(
    _ newChild: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return ArrayExprSyntax(newData)
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
    // Check child #3 child is ArrayElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ArrayElementListSyntax.self))
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

extension ArrayExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftSquare": garbageBeforeLeftSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftSquareAndElements": garbageBetweenLeftSquareAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "garbageBetweenElementsAndRightSquare": garbageBetweenElementsAndRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DictionaryExprSyntax

public struct DictionaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftSquare
    case leftSquare
    case garbageBetweenLeftSquareAndContent
    case content
    case garbageBetweenContentAndRightSquare
    case rightSquare
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DictionaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .dictionaryExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DictionaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dictionaryExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftSquare: GarbageNodesSyntax? = nil,
    leftSquare: TokenSyntax,
    _ garbageBetweenLeftSquareAndContent: GarbageNodesSyntax? = nil,
    content: Syntax,
    _ garbageBetweenContentAndRightSquare: GarbageNodesSyntax? = nil,
    rightSquare: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquare?.raw,
      leftSquare.raw,
      garbageBetweenLeftSquareAndContent?.raw,
      content.raw,
      garbageBetweenContentAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftSquare: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftSquare` replaced.
  /// - param newChild: The new `garbageBeforeLeftSquare` to replace the node's
  ///                   current `garbageBeforeLeftSquare`, if present.
  public func withGarbageBeforeLeftSquare(
    _ newChild: GarbageNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftSquare)
    return DictionaryExprSyntax(newData)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `leftSquare` replaced.
  /// - param newChild: The new `leftSquare` to replace the node's
  ///                   current `leftSquare`, if present.
  public func withLeftSquare(
    _ newChild: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return DictionaryExprSyntax(newData)
  }

  public var garbageBetweenLeftSquareAndContent: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftSquareAndContent,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftSquareAndContent(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftSquareAndContent` replaced.
  /// - param newChild: The new `garbageBetweenLeftSquareAndContent` to replace the node's
  ///                   current `garbageBetweenLeftSquareAndContent`, if present.
  public func withGarbageBetweenLeftSquareAndContent(
    _ newChild: GarbageNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftSquareAndContent)
    return DictionaryExprSyntax(newData)
  }

  public var content: Syntax {
    get {
      let childData = data.child(at: Cursor.content,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withContent(value)
    }
  }

  /// Returns a copy of the receiver with its `content` replaced.
  /// - param newChild: The new `content` to replace the node's
  ///                   current `content`, if present.
  public func withContent(
    _ newChild: Syntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.content)
    return DictionaryExprSyntax(newData)
  }

  public var garbageBetweenContentAndRightSquare: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenContentAndRightSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenContentAndRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenContentAndRightSquare` replaced.
  /// - param newChild: The new `garbageBetweenContentAndRightSquare` to replace the node's
  ///                   current `garbageBetweenContentAndRightSquare`, if present.
  public func withGarbageBetweenContentAndRightSquare(
    _ newChild: GarbageNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenContentAndRightSquare)
    return DictionaryExprSyntax(newData)
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `rightSquare` replaced.
  /// - param newChild: The new `rightSquare` to replace the node's
  ///                   current `rightSquare`, if present.
  public func withRightSquare(
    _ newChild: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return DictionaryExprSyntax(newData)
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
    // Check child #3 child is Syntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
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

extension DictionaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftSquare": garbageBeforeLeftSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftSquareAndContent": garbageBetweenLeftSquareAndContent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "content": Syntax(content).asProtocol(SyntaxProtocol.self),
      "garbageBetweenContentAndRightSquare": garbageBetweenContentAndRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IntegerLiteralExprSyntax

public struct IntegerLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeDigits
    case digits
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IntegerLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .integerLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IntegerLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .integerLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeDigits: GarbageNodesSyntax? = nil,
    digits: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeDigits?.raw,
      digits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.integerLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeDigits: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeDigits,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeDigits` replaced.
  /// - param newChild: The new `garbageBeforeDigits` to replace the node's
  ///                   current `garbageBeforeDigits`, if present.
  public func withGarbageBeforeDigits(
    _ newChild: GarbageNodesSyntax?) -> IntegerLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeDigits)
    return IntegerLiteralExprSyntax(newData)
  }

  public var digits: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.digits,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `digits` replaced.
  /// - param newChild: The new `digits` to replace the node's
  ///                   current `digits`, if present.
  public func withDigits(
    _ newChild: TokenSyntax?) -> IntegerLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.integerLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.digits)
    return IntegerLiteralExprSyntax(newData)
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

extension IntegerLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeDigits": garbageBeforeDigits.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "digits": Syntax(digits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BooleanLiteralExprSyntax

public struct BooleanLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBooleanLiteral
    case booleanLiteral
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `BooleanLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .booleanLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `BooleanLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .booleanLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBooleanLiteral: GarbageNodesSyntax? = nil,
    booleanLiteral: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBooleanLiteral?.raw,
      booleanLiteral.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.booleanLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBooleanLiteral: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBooleanLiteral,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBooleanLiteral(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBooleanLiteral` replaced.
  /// - param newChild: The new `garbageBeforeBooleanLiteral` to replace the node's
  ///                   current `garbageBeforeBooleanLiteral`, if present.
  public func withGarbageBeforeBooleanLiteral(
    _ newChild: GarbageNodesSyntax?) -> BooleanLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBooleanLiteral)
    return BooleanLiteralExprSyntax(newData)
  }

  public var booleanLiteral: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.booleanLiteral,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withBooleanLiteral(value)
    }
  }

  /// Returns a copy of the receiver with its `booleanLiteral` replaced.
  /// - param newChild: The new `booleanLiteral` to replace the node's
  ///                   current `booleanLiteral`, if present.
  public func withBooleanLiteral(
    _ newChild: TokenSyntax?) -> BooleanLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.trueKeyword)
    let newData = data.replacingChild(raw, at: Cursor.booleanLiteral)
    return BooleanLiteralExprSyntax(newData)
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

extension BooleanLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBooleanLiteral": garbageBeforeBooleanLiteral.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "booleanLiteral": Syntax(booleanLiteral).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TernaryExprSyntax

public struct TernaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeConditionExpression
    case conditionExpression
    case garbageBetweenConditionExpressionAndQuestionMark
    case questionMark
    case garbageBetweenQuestionMarkAndFirstChoice
    case firstChoice
    case garbageBetweenFirstChoiceAndColonMark
    case colonMark
    case garbageBetweenColonMarkAndSecondChoice
    case secondChoice
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TernaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .ternaryExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TernaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ternaryExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeConditionExpression: GarbageNodesSyntax? = nil,
    conditionExpression: ExprSyntax,
    _ garbageBetweenConditionExpressionAndQuestionMark: GarbageNodesSyntax? = nil,
    questionMark: TokenSyntax,
    _ garbageBetweenQuestionMarkAndFirstChoice: GarbageNodesSyntax? = nil,
    firstChoice: ExprSyntax,
    _ garbageBetweenFirstChoiceAndColonMark: GarbageNodesSyntax? = nil,
    colonMark: TokenSyntax,
    _ garbageBetweenColonMarkAndSecondChoice: GarbageNodesSyntax? = nil,
    secondChoice: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeConditionExpression?.raw,
      conditionExpression.raw,
      garbageBetweenConditionExpressionAndQuestionMark?.raw,
      questionMark.raw,
      garbageBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      garbageBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
      garbageBetweenColonMarkAndSecondChoice?.raw,
      secondChoice.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ternaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeConditionExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeConditionExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeConditionExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeConditionExpression` replaced.
  /// - param newChild: The new `garbageBeforeConditionExpression` to replace the node's
  ///                   current `garbageBeforeConditionExpression`, if present.
  public func withGarbageBeforeConditionExpression(
    _ newChild: GarbageNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeConditionExpression)
    return TernaryExprSyntax(newData)
  }

  public var conditionExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.conditionExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withConditionExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `conditionExpression` replaced.
  /// - param newChild: The new `conditionExpression` to replace the node's
  ///                   current `conditionExpression`, if present.
  public func withConditionExpression(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.conditionExpression)
    return TernaryExprSyntax(newData)
  }

  public var garbageBetweenConditionExpressionAndQuestionMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenConditionExpressionAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenConditionExpressionAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenConditionExpressionAndQuestionMark` replaced.
  /// - param newChild: The new `garbageBetweenConditionExpressionAndQuestionMark` to replace the node's
  ///                   current `garbageBetweenConditionExpressionAndQuestionMark`, if present.
  public func withGarbageBetweenConditionExpressionAndQuestionMark(
    _ newChild: GarbageNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenConditionExpressionAndQuestionMark)
    return TernaryExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.infixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return TernaryExprSyntax(newData)
  }

  public var garbageBetweenQuestionMarkAndFirstChoice: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenQuestionMarkAndFirstChoice,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenQuestionMarkAndFirstChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenQuestionMarkAndFirstChoice` replaced.
  /// - param newChild: The new `garbageBetweenQuestionMarkAndFirstChoice` to replace the node's
  ///                   current `garbageBetweenQuestionMarkAndFirstChoice`, if present.
  public func withGarbageBetweenQuestionMarkAndFirstChoice(
    _ newChild: GarbageNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenQuestionMarkAndFirstChoice)
    return TernaryExprSyntax(newData)
  }

  public var firstChoice: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.firstChoice,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withFirstChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `firstChoice` replaced.
  /// - param newChild: The new `firstChoice` to replace the node's
  ///                   current `firstChoice`, if present.
  public func withFirstChoice(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.firstChoice)
    return TernaryExprSyntax(newData)
  }

  public var garbageBetweenFirstChoiceAndColonMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenFirstChoiceAndColonMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenFirstChoiceAndColonMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenFirstChoiceAndColonMark` replaced.
  /// - param newChild: The new `garbageBetweenFirstChoiceAndColonMark` to replace the node's
  ///                   current `garbageBetweenFirstChoiceAndColonMark`, if present.
  public func withGarbageBetweenFirstChoiceAndColonMark(
    _ newChild: GarbageNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenFirstChoiceAndColonMark)
    return TernaryExprSyntax(newData)
  }

  public var colonMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colonMark,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColonMark(value)
    }
  }

  /// Returns a copy of the receiver with its `colonMark` replaced.
  /// - param newChild: The new `colonMark` to replace the node's
  ///                   current `colonMark`, if present.
  public func withColonMark(
    _ newChild: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colonMark)
    return TernaryExprSyntax(newData)
  }

  public var garbageBetweenColonMarkAndSecondChoice: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenColonMarkAndSecondChoice,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenColonMarkAndSecondChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenColonMarkAndSecondChoice` replaced.
  /// - param newChild: The new `garbageBetweenColonMarkAndSecondChoice` to replace the node's
  ///                   current `garbageBetweenColonMarkAndSecondChoice`, if present.
  public func withGarbageBetweenColonMarkAndSecondChoice(
    _ newChild: GarbageNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenColonMarkAndSecondChoice)
    return TernaryExprSyntax(newData)
  }

  public var secondChoice: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.secondChoice,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withSecondChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `secondChoice` replaced.
  /// - param newChild: The new `secondChoice` to replace the node's
  ///                   current `secondChoice`, if present.
  public func withSecondChoice(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.secondChoice)
    return TernaryExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #5 child is ExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #9 child is ExprSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension TernaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeConditionExpression": garbageBeforeConditionExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conditionExpression": Syntax(conditionExpression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenConditionExpressionAndQuestionMark": garbageBetweenConditionExpressionAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "garbageBetweenQuestionMarkAndFirstChoice": garbageBetweenQuestionMarkAndFirstChoice.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "firstChoice": Syntax(firstChoice).asProtocol(SyntaxProtocol.self),
      "garbageBetweenFirstChoiceAndColonMark": garbageBetweenFirstChoiceAndColonMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colonMark": Syntax(colonMark).asProtocol(SyntaxProtocol.self),
      "garbageBetweenColonMarkAndSecondChoice": garbageBetweenColonMarkAndSecondChoice.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondChoice": Syntax(secondChoice).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MemberAccessExprSyntax

public struct MemberAccessExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBase
    case base
    case garbageBetweenBaseAndDot
    case dot
    case garbageBetweenDotAndName
    case name
    case garbageBetweenNameAndDeclNameArguments
    case declNameArguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MemberAccessExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .memberAccessExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MemberAccessExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberAccessExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBase: GarbageNodesSyntax? = nil,
    base: ExprSyntax?,
    _ garbageBetweenBaseAndDot: GarbageNodesSyntax? = nil,
    dot: TokenSyntax,
    _ garbageBetweenDotAndName: GarbageNodesSyntax? = nil,
    name: TokenSyntax,
    _ garbageBetweenNameAndDeclNameArguments: GarbageNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBase?.raw,
      base?.raw,
      garbageBetweenBaseAndDot?.raw,
      dot.raw,
      garbageBetweenDotAndName?.raw,
      name.raw,
      garbageBetweenNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberAccessExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBase: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBase,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBase(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBase` replaced.
  /// - param newChild: The new `garbageBeforeBase` to replace the node's
  ///                   current `garbageBeforeBase`, if present.
  public func withGarbageBeforeBase(
    _ newChild: GarbageNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBase)
    return MemberAccessExprSyntax(newData)
  }

  public var base: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.base,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withBase(value)
    }
  }

  /// Returns a copy of the receiver with its `base` replaced.
  /// - param newChild: The new `base` to replace the node's
  ///                   current `base`, if present.
  public func withBase(
    _ newChild: ExprSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.base)
    return MemberAccessExprSyntax(newData)
  }

  public var garbageBetweenBaseAndDot: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBaseAndDot,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBaseAndDot(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBaseAndDot` replaced.
  /// - param newChild: The new `garbageBetweenBaseAndDot` to replace the node's
  ///                   current `garbageBetweenBaseAndDot`, if present.
  public func withGarbageBetweenBaseAndDot(
    _ newChild: GarbageNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBaseAndDot)
    return MemberAccessExprSyntax(newData)
  }

  public var dot: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.dot,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDot(value)
    }
  }

  /// Returns a copy of the receiver with its `dot` replaced.
  /// - param newChild: The new `dot` to replace the node's
  ///                   current `dot`, if present.
  public func withDot(
    _ newChild: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.dot)
    return MemberAccessExprSyntax(newData)
  }

  public var garbageBetweenDotAndName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenDotAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenDotAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenDotAndName` replaced.
  /// - param newChild: The new `garbageBetweenDotAndName` to replace the node's
  ///                   current `garbageBetweenDotAndName`, if present.
  public func withGarbageBetweenDotAndName(
    _ newChild: GarbageNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenDotAndName)
    return MemberAccessExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return MemberAccessExprSyntax(newData)
  }

  public var garbageBetweenNameAndDeclNameArguments: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenNameAndDeclNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenNameAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenNameAndDeclNameArguments` replaced.
  /// - param newChild: The new `garbageBetweenNameAndDeclNameArguments` to replace the node's
  ///                   current `garbageBetweenNameAndDeclNameArguments`, if present.
  public func withGarbageBetweenNameAndDeclNameArguments(
    _ newChild: GarbageNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenNameAndDeclNameArguments)
    return MemberAccessExprSyntax(newData)
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return MemberAccessExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #7 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension MemberAccessExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBase": garbageBeforeBase.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenBaseAndDot": garbageBetweenBaseAndDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": Syntax(dot).asProtocol(SyntaxProtocol.self),
      "garbageBetweenDotAndName": garbageBetweenDotAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "garbageBetweenNameAndDeclNameArguments": garbageBetweenNameAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsExprSyntax

public struct IsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIsTok
    case isTok
    case garbageBetweenIsTokAndTypeName
    case typeName
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IsExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .isExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IsExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .isExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIsTok: GarbageNodesSyntax? = nil,
    isTok: TokenSyntax,
    _ garbageBetweenIsTokAndTypeName: GarbageNodesSyntax? = nil,
    typeName: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIsTok?.raw,
      isTok.raw,
      garbageBetweenIsTokAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.isExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeIsTok: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeIsTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeIsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeIsTok` replaced.
  /// - param newChild: The new `garbageBeforeIsTok` to replace the node's
  ///                   current `garbageBeforeIsTok`, if present.
  public func withGarbageBeforeIsTok(
    _ newChild: GarbageNodesSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIsTok)
    return IsExprSyntax(newData)
  }

  public var isTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.isTok,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `isTok` replaced.
  /// - param newChild: The new `isTok` to replace the node's
  ///                   current `isTok`, if present.
  public func withIsTok(
    _ newChild: TokenSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.isKeyword)
    let newData = data.replacingChild(raw, at: Cursor.isTok)
    return IsExprSyntax(newData)
  }

  public var garbageBetweenIsTokAndTypeName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIsTokAndTypeName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIsTokAndTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIsTokAndTypeName` replaced.
  /// - param newChild: The new `garbageBetweenIsTokAndTypeName` to replace the node's
  ///                   current `garbageBetweenIsTokAndTypeName`, if present.
  public func withGarbageBetweenIsTokAndTypeName(
    _ newChild: GarbageNodesSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIsTokAndTypeName)
    return IsExprSyntax(newData)
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `typeName` replaced.
  /// - param newChild: The new `typeName` to replace the node's
  ///                   current `typeName`, if present.
  public func withTypeName(
    _ newChild: TypeSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return IsExprSyntax(newData)
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

extension IsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIsTok": garbageBeforeIsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "isTok": Syntax(isTok).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIsTokAndTypeName": garbageBetweenIsTokAndTypeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AsExprSyntax

public struct AsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeAsTok
    case asTok
    case garbageBetweenAsTokAndQuestionOrExclamationMark
    case questionOrExclamationMark
    case garbageBetweenQuestionOrExclamationMarkAndTypeName
    case typeName
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AsExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .asExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AsExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .asExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeAsTok: GarbageNodesSyntax? = nil,
    asTok: TokenSyntax,
    _ garbageBetweenAsTokAndQuestionOrExclamationMark: GarbageNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax?,
    _ garbageBetweenQuestionOrExclamationMarkAndTypeName: GarbageNodesSyntax? = nil,
    typeName: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeAsTok?.raw,
      asTok.raw,
      garbageBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      garbageBetweenQuestionOrExclamationMarkAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.asExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeAsTok: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeAsTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeAsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeAsTok` replaced.
  /// - param newChild: The new `garbageBeforeAsTok` to replace the node's
  ///                   current `garbageBeforeAsTok`, if present.
  public func withGarbageBeforeAsTok(
    _ newChild: GarbageNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeAsTok)
    return AsExprSyntax(newData)
  }

  public var asTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.asTok,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `asTok` replaced.
  /// - param newChild: The new `asTok` to replace the node's
  ///                   current `asTok`, if present.
  public func withAsTok(
    _ newChild: TokenSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.asKeyword)
    let newData = data.replacingChild(raw, at: Cursor.asTok)
    return AsExprSyntax(newData)
  }

  public var garbageBetweenAsTokAndQuestionOrExclamationMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAsTokAndQuestionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAsTokAndQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAsTokAndQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `garbageBetweenAsTokAndQuestionOrExclamationMark` to replace the node's
  ///                   current `garbageBetweenAsTokAndQuestionOrExclamationMark`, if present.
  public func withGarbageBetweenAsTokAndQuestionOrExclamationMark(
    _ newChild: GarbageNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAsTokAndQuestionOrExclamationMark)
    return AsExprSyntax(newData)
  }

  public var questionOrExclamationMark: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.questionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `questionOrExclamationMark` replaced.
  /// - param newChild: The new `questionOrExclamationMark` to replace the node's
  ///                   current `questionOrExclamationMark`, if present.
  public func withQuestionOrExclamationMark(
    _ newChild: TokenSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.questionOrExclamationMark)
    return AsExprSyntax(newData)
  }

  public var garbageBetweenQuestionOrExclamationMarkAndTypeName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenQuestionOrExclamationMarkAndTypeName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenQuestionOrExclamationMarkAndTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenQuestionOrExclamationMarkAndTypeName` replaced.
  /// - param newChild: The new `garbageBetweenQuestionOrExclamationMarkAndTypeName` to replace the node's
  ///                   current `garbageBetweenQuestionOrExclamationMarkAndTypeName`, if present.
  public func withGarbageBetweenQuestionOrExclamationMarkAndTypeName(
    _ newChild: GarbageNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenQuestionOrExclamationMarkAndTypeName)
    return AsExprSyntax(newData)
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `typeName` replaced.
  /// - param newChild: The new `typeName` to replace the node's
  ///                   current `typeName`, if present.
  public func withTypeName(
    _ newChild: TypeSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return AsExprSyntax(newData)
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
    // Check child #3 child is TokenSyntax or missing
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

extension AsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeAsTok": garbageBeforeAsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asTok": Syntax(asTok).asProtocol(SyntaxProtocol.self),
      "garbageBetweenAsTokAndQuestionOrExclamationMark": garbageBetweenAsTokAndQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenQuestionOrExclamationMarkAndTypeName": garbageBetweenQuestionOrExclamationMarkAndTypeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TypeExprSyntax

public struct TypeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeType
    case type
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TypeExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .typeExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TypeExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeType: GarbageNodesSyntax? = nil,
    type: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> TypeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeType)
    return TypeExprSyntax(newData)
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
    _ newChild: TypeSyntax?) -> TypeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingType)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TypeExprSyntax(newData)
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

extension TypeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeType": garbageBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ClosureExprSyntax

public struct ClosureExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLeftBrace
    case leftBrace
    case garbageBetweenLeftBraceAndSignature
    case signature
    case garbageBetweenSignatureAndStatements
    case statements
    case garbageBetweenStatementsAndRightBrace
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClosureExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .closureExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClosureExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLeftBrace: GarbageNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ garbageBetweenLeftBraceAndSignature: GarbageNodesSyntax? = nil,
    signature: ClosureSignatureSyntax?,
    _ garbageBetweenSignatureAndStatements: GarbageNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ garbageBetweenStatementsAndRightBrace: GarbageNodesSyntax? = nil,
    rightBrace: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndSignature?.raw,
      signature?.raw,
      garbageBetweenSignatureAndStatements?.raw,
      statements.raw,
      garbageBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLeftBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLeftBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLeftBrace` replaced.
  /// - param newChild: The new `garbageBeforeLeftBrace` to replace the node's
  ///                   current `garbageBeforeLeftBrace`, if present.
  public func withGarbageBeforeLeftBrace(
    _ newChild: GarbageNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLeftBrace)
    return ClosureExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return ClosureExprSyntax(newData)
  }

  public var garbageBetweenLeftBraceAndSignature: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftBraceAndSignature,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftBraceAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftBraceAndSignature` replaced.
  /// - param newChild: The new `garbageBetweenLeftBraceAndSignature` to replace the node's
  ///                   current `garbageBetweenLeftBraceAndSignature`, if present.
  public func withGarbageBetweenLeftBraceAndSignature(
    _ newChild: GarbageNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftBraceAndSignature)
    return ClosureExprSyntax(newData)
  }

  public var signature: ClosureSignatureSyntax? {
    get {
      let childData = data.child(at: Cursor.signature,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureSignatureSyntax(childData!)
    }
    set(value) {
      self = withSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(
    _ newChild: ClosureSignatureSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return ClosureExprSyntax(newData)
  }

  public var garbageBetweenSignatureAndStatements: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSignatureAndStatements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSignatureAndStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSignatureAndStatements` replaced.
  /// - param newChild: The new `garbageBetweenSignatureAndStatements` to replace the node's
  ///                   current `garbageBetweenSignatureAndStatements`, if present.
  public func withGarbageBetweenSignatureAndStatements(
    _ newChild: GarbageNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSignatureAndStatements)
    return ClosureExprSyntax(newData)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements,
                                 parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
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
  public func addStatement(_ element: CodeBlockItemSyntax) -> ClosureExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.statements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.statements)
    return ClosureExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlockItemList)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return ClosureExprSyntax(newData)
  }

  public var garbageBetweenStatementsAndRightBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenStatementsAndRightBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenStatementsAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenStatementsAndRightBrace` replaced.
  /// - param newChild: The new `garbageBetweenStatementsAndRightBrace` to replace the node's
  ///                   current `garbageBetweenStatementsAndRightBrace`, if present.
  public func withGarbageBetweenStatementsAndRightBrace(
    _ newChild: GarbageNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenStatementsAndRightBrace)
    return ClosureExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return ClosureExprSyntax(newData)
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
    // Check child #3 child is ClosureSignatureSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureSignatureSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is CodeBlockItemListSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockItemListSyntax.self))
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

extension ClosureExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLeftBrace": garbageBeforeLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftBraceAndSignature": garbageBetweenLeftBraceAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": signature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenSignatureAndStatements": garbageBetweenSignatureAndStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "garbageBetweenStatementsAndRightBrace": garbageBetweenStatementsAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - UnresolvedPatternExprSyntax

public struct UnresolvedPatternExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePattern
    case pattern
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnresolvedPatternExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unresolvedPatternExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnresolvedPatternExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unresolvedPatternExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePattern: GarbageNodesSyntax? = nil,
    pattern: PatternSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unresolvedPatternExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> UnresolvedPatternExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePattern)
    return UnresolvedPatternExprSyntax(newData)
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
    _ newChild: PatternSyntax?) -> UnresolvedPatternExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingPattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return UnresolvedPatternExprSyntax(newData)
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

extension UnresolvedPatternExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePattern": garbageBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionCallExprSyntax

public struct FunctionCallExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeCalledExpression
    case calledExpression
    case garbageBetweenCalledExpressionAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndArgumentList
    case argumentList
    case garbageBetweenArgumentListAndRightParen
    case rightParen
    case garbageBetweenRightParenAndTrailingClosure
    case trailingClosure
    case garbageBetweenTrailingClosureAndAdditionalTrailingClosures
    case additionalTrailingClosures
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionCallExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionCallExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionCallExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionCallExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeCalledExpression: GarbageNodesSyntax? = nil,
    calledExpression: ExprSyntax,
    _ garbageBetweenCalledExpressionAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ garbageBetweenLeftParenAndArgumentList: GarbageNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ garbageBetweenArgumentListAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ garbageBetweenRightParenAndTrailingClosure: GarbageNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax?,
    _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeCalledExpression?.raw,
      calledExpression.raw,
      garbageBetweenCalledExpressionAndLeftParen?.raw,
      leftParen?.raw,
      garbageBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      garbageBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      garbageBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionCallExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeCalledExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeCalledExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeCalledExpression` replaced.
  /// - param newChild: The new `garbageBeforeCalledExpression` to replace the node's
  ///                   current `garbageBeforeCalledExpression`, if present.
  public func withGarbageBeforeCalledExpression(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeCalledExpression)
    return FunctionCallExprSyntax(newData)
  }

  public var calledExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.calledExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `calledExpression` replaced.
  /// - param newChild: The new `calledExpression` to replace the node's
  ///                   current `calledExpression`, if present.
  public func withCalledExpression(
    _ newChild: ExprSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return FunctionCallExprSyntax(newData)
  }

  public var garbageBetweenCalledExpressionAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCalledExpressionAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCalledExpressionAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCalledExpressionAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenCalledExpressionAndLeftParen` to replace the node's
  ///                   current `garbageBetweenCalledExpressionAndLeftParen`, if present.
  public func withGarbageBetweenCalledExpressionAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCalledExpressionAndLeftParen)
    return FunctionCallExprSyntax(newData)
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
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
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return FunctionCallExprSyntax(newData)
  }

  public var garbageBetweenLeftParenAndArgumentList: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndArgumentList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndArgumentList(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndArgumentList` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndArgumentList` to replace the node's
  ///                   current `garbageBetweenLeftParenAndArgumentList`, if present.
  public func withGarbageBetweenLeftParenAndArgumentList(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndArgumentList)
    return FunctionCallExprSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.argumentList,
                                 parent: Syntax(self))
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
  public func addArgument(_ element: TupleExprElementSyntax) -> FunctionCallExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.argumentList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.argumentList)
    return FunctionCallExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: TupleExprElementListSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleExprElementList)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return FunctionCallExprSyntax(newData)
  }

  public var garbageBetweenArgumentListAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenArgumentListAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenArgumentListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenArgumentListAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenArgumentListAndRightParen` to replace the node's
  ///                   current `garbageBetweenArgumentListAndRightParen`, if present.
  public func withGarbageBetweenArgumentListAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArgumentListAndRightParen)
    return FunctionCallExprSyntax(newData)
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
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
  public func withRightParen(
    _ newChild: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return FunctionCallExprSyntax(newData)
  }

  public var garbageBetweenRightParenAndTrailingClosure: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenRightParenAndTrailingClosure,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenRightParenAndTrailingClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenRightParenAndTrailingClosure` replaced.
  /// - param newChild: The new `garbageBetweenRightParenAndTrailingClosure` to replace the node's
  ///                   current `garbageBetweenRightParenAndTrailingClosure`, if present.
  public func withGarbageBetweenRightParenAndTrailingClosure(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenRightParenAndTrailingClosure)
    return FunctionCallExprSyntax(newData)
  }

  public var trailingClosure: ClosureExprSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingClosure,
                                 parent: Syntax(self))
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
  public func withTrailingClosure(
    _ newChild: ClosureExprSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingClosure)
    return FunctionCallExprSyntax(newData)
  }

  public var garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTrailingClosureAndAdditionalTrailingClosures,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTrailingClosureAndAdditionalTrailingClosures(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTrailingClosureAndAdditionalTrailingClosures` replaced.
  /// - param newChild: The new `garbageBetweenTrailingClosureAndAdditionalTrailingClosures` to replace the node's
  ///                   current `garbageBetweenTrailingClosureAndAdditionalTrailingClosures`, if present.
  public func withGarbageBetweenTrailingClosureAndAdditionalTrailingClosures(
    _ newChild: GarbageNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTrailingClosureAndAdditionalTrailingClosures)
    return FunctionCallExprSyntax(newData)
  }

  public var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.additionalTrailingClosures,
                                 parent: Syntax(self))
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
  public func addAdditionalTrailingClosure(_ element: MultipleTrailingClosureElementSyntax) -> FunctionCallExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.additionalTrailingClosures] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.multipleTrailingClosureElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.additionalTrailingClosures)
    return FunctionCallExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `additionalTrailingClosures` replaced.
  /// - param newChild: The new `additionalTrailingClosures` to replace the node's
  ///                   current `additionalTrailingClosures`, if present.
  public func withAdditionalTrailingClosures(
    _ newChild: MultipleTrailingClosureElementListSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.additionalTrailingClosures)
    return FunctionCallExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 12)
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
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
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
    // Check child #5 child is TupleExprElementListSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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
    // Check child #9 child is ClosureExprSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureExprSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is MultipleTrailingClosureElementListSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MultipleTrailingClosureElementListSyntax.self))
    }
  }
}

extension FunctionCallExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeCalledExpression": garbageBeforeCalledExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCalledExpressionAndLeftParen": garbageBetweenCalledExpressionAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenLeftParenAndArgumentList": garbageBetweenLeftParenAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "garbageBetweenArgumentListAndRightParen": garbageBetweenArgumentListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenRightParenAndTrailingClosure": garbageBetweenRightParenAndTrailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenTrailingClosureAndAdditionalTrailingClosures": garbageBetweenTrailingClosureAndAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptExprSyntax

public struct SubscriptExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeCalledExpression
    case calledExpression
    case garbageBetweenCalledExpressionAndLeftBracket
    case leftBracket
    case garbageBetweenLeftBracketAndArgumentList
    case argumentList
    case garbageBetweenArgumentListAndRightBracket
    case rightBracket
    case garbageBetweenRightBracketAndTrailingClosure
    case trailingClosure
    case garbageBetweenTrailingClosureAndAdditionalTrailingClosures
    case additionalTrailingClosures
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SubscriptExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .subscriptExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SubscriptExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .subscriptExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeCalledExpression: GarbageNodesSyntax? = nil,
    calledExpression: ExprSyntax,
    _ garbageBetweenCalledExpressionAndLeftBracket: GarbageNodesSyntax? = nil,
    leftBracket: TokenSyntax,
    _ garbageBetweenLeftBracketAndArgumentList: GarbageNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ garbageBetweenArgumentListAndRightBracket: GarbageNodesSyntax? = nil,
    rightBracket: TokenSyntax,
    _ garbageBetweenRightBracketAndTrailingClosure: GarbageNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax?,
    _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeCalledExpression?.raw,
      calledExpression.raw,
      garbageBetweenCalledExpressionAndLeftBracket?.raw,
      leftBracket.raw,
      garbageBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      garbageBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      garbageBetweenRightBracketAndTrailingClosure?.raw,
      trailingClosure?.raw,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeCalledExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeCalledExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeCalledExpression` replaced.
  /// - param newChild: The new `garbageBeforeCalledExpression` to replace the node's
  ///                   current `garbageBeforeCalledExpression`, if present.
  public func withGarbageBeforeCalledExpression(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeCalledExpression)
    return SubscriptExprSyntax(newData)
  }

  public var calledExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.calledExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `calledExpression` replaced.
  /// - param newChild: The new `calledExpression` to replace the node's
  ///                   current `calledExpression`, if present.
  public func withCalledExpression(
    _ newChild: ExprSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return SubscriptExprSyntax(newData)
  }

  public var garbageBetweenCalledExpressionAndLeftBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCalledExpressionAndLeftBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCalledExpressionAndLeftBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCalledExpressionAndLeftBracket` replaced.
  /// - param newChild: The new `garbageBetweenCalledExpressionAndLeftBracket` to replace the node's
  ///                   current `garbageBetweenCalledExpressionAndLeftBracket`, if present.
  public func withGarbageBetweenCalledExpressionAndLeftBracket(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCalledExpressionAndLeftBracket)
    return SubscriptExprSyntax(newData)
  }

  public var leftBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `leftBracket` replaced.
  /// - param newChild: The new `leftBracket` to replace the node's
  ///                   current `leftBracket`, if present.
  public func withLeftBracket(
    _ newChild: TokenSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftBracket)
    return SubscriptExprSyntax(newData)
  }

  public var garbageBetweenLeftBracketAndArgumentList: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftBracketAndArgumentList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftBracketAndArgumentList(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftBracketAndArgumentList` replaced.
  /// - param newChild: The new `garbageBetweenLeftBracketAndArgumentList` to replace the node's
  ///                   current `garbageBetweenLeftBracketAndArgumentList`, if present.
  public func withGarbageBetweenLeftBracketAndArgumentList(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftBracketAndArgumentList)
    return SubscriptExprSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.argumentList,
                                 parent: Syntax(self))
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
  public func addArgument(_ element: TupleExprElementSyntax) -> SubscriptExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.argumentList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.argumentList)
    return SubscriptExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: TupleExprElementListSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleExprElementList)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return SubscriptExprSyntax(newData)
  }

  public var garbageBetweenArgumentListAndRightBracket: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenArgumentListAndRightBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenArgumentListAndRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenArgumentListAndRightBracket` replaced.
  /// - param newChild: The new `garbageBetweenArgumentListAndRightBracket` to replace the node's
  ///                   current `garbageBetweenArgumentListAndRightBracket`, if present.
  public func withGarbageBetweenArgumentListAndRightBracket(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArgumentListAndRightBracket)
    return SubscriptExprSyntax(newData)
  }

  public var rightBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `rightBracket` replaced.
  /// - param newChild: The new `rightBracket` to replace the node's
  ///                   current `rightBracket`, if present.
  public func withRightBracket(
    _ newChild: TokenSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightBracket)
    return SubscriptExprSyntax(newData)
  }

  public var garbageBetweenRightBracketAndTrailingClosure: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenRightBracketAndTrailingClosure,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenRightBracketAndTrailingClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenRightBracketAndTrailingClosure` replaced.
  /// - param newChild: The new `garbageBetweenRightBracketAndTrailingClosure` to replace the node's
  ///                   current `garbageBetweenRightBracketAndTrailingClosure`, if present.
  public func withGarbageBetweenRightBracketAndTrailingClosure(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenRightBracketAndTrailingClosure)
    return SubscriptExprSyntax(newData)
  }

  public var trailingClosure: ClosureExprSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingClosure,
                                 parent: Syntax(self))
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
  public func withTrailingClosure(
    _ newChild: ClosureExprSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingClosure)
    return SubscriptExprSyntax(newData)
  }

  public var garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTrailingClosureAndAdditionalTrailingClosures,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTrailingClosureAndAdditionalTrailingClosures(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTrailingClosureAndAdditionalTrailingClosures` replaced.
  /// - param newChild: The new `garbageBetweenTrailingClosureAndAdditionalTrailingClosures` to replace the node's
  ///                   current `garbageBetweenTrailingClosureAndAdditionalTrailingClosures`, if present.
  public func withGarbageBetweenTrailingClosureAndAdditionalTrailingClosures(
    _ newChild: GarbageNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTrailingClosureAndAdditionalTrailingClosures)
    return SubscriptExprSyntax(newData)
  }

  public var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.additionalTrailingClosures,
                                 parent: Syntax(self))
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
  public func addAdditionalTrailingClosure(_ element: MultipleTrailingClosureElementSyntax) -> SubscriptExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.additionalTrailingClosures] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.multipleTrailingClosureElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.additionalTrailingClosures)
    return SubscriptExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `additionalTrailingClosures` replaced.
  /// - param newChild: The new `additionalTrailingClosures` to replace the node's
  ///                   current `additionalTrailingClosures`, if present.
  public func withAdditionalTrailingClosures(
    _ newChild: MultipleTrailingClosureElementListSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.additionalTrailingClosures)
    return SubscriptExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 12)
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
    // Check child #5 child is TupleExprElementListSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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
    // Check child #9 child is ClosureExprSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureExprSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is MultipleTrailingClosureElementListSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MultipleTrailingClosureElementListSyntax.self))
    }
  }
}

extension SubscriptExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeCalledExpression": garbageBeforeCalledExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCalledExpressionAndLeftBracket": garbageBetweenCalledExpressionAndLeftBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBracket": Syntax(leftBracket).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftBracketAndArgumentList": garbageBetweenLeftBracketAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "garbageBetweenArgumentListAndRightBracket": garbageBetweenArgumentListAndRightBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBracket": Syntax(rightBracket).asProtocol(SyntaxProtocol.self),
      "garbageBetweenRightBracketAndTrailingClosure": garbageBetweenRightBracketAndTrailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenTrailingClosureAndAdditionalTrailingClosures": garbageBetweenTrailingClosureAndAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalChainingExprSyntax

public struct OptionalChainingExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
    case garbageBetweenExpressionAndQuestionMark
    case questionMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OptionalChainingExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .optionalChainingExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OptionalChainingExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalChainingExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax,
    _ garbageBetweenExpressionAndQuestionMark: GarbageNodesSyntax? = nil,
    questionMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalChainingExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return OptionalChainingExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return OptionalChainingExprSyntax(newData)
  }

  public var garbageBetweenExpressionAndQuestionMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExpressionAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExpressionAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExpressionAndQuestionMark` replaced.
  /// - param newChild: The new `garbageBetweenExpressionAndQuestionMark` to replace the node's
  ///                   current `garbageBetweenExpressionAndQuestionMark`, if present.
  public func withGarbageBetweenExpressionAndQuestionMark(
    _ newChild: GarbageNodesSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExpressionAndQuestionMark)
    return OptionalChainingExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalChainingExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension OptionalChainingExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExpressionAndQuestionMark": garbageBetweenExpressionAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ForcedValueExprSyntax

public struct ForcedValueExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
    case garbageBetweenExpressionAndExclamationMark
    case exclamationMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ForcedValueExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .forcedValueExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ForcedValueExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .forcedValueExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax,
    _ garbageBetweenExpressionAndExclamationMark: GarbageNodesSyntax? = nil,
    exclamationMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forcedValueExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return ForcedValueExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ForcedValueExprSyntax(newData)
  }

  public var garbageBetweenExpressionAndExclamationMark: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExpressionAndExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExpressionAndExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExpressionAndExclamationMark` replaced.
  /// - param newChild: The new `garbageBetweenExpressionAndExclamationMark` to replace the node's
  ///                   current `garbageBetweenExpressionAndExclamationMark`, if present.
  public func withGarbageBetweenExpressionAndExclamationMark(
    _ newChild: GarbageNodesSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExpressionAndExclamationMark)
    return ForcedValueExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.exclamationMark)
    let newData = data.replacingChild(raw, at: Cursor.exclamationMark)
    return ForcedValueExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension ForcedValueExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExpressionAndExclamationMark": garbageBetweenExpressionAndExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixUnaryExprSyntax

public struct PostfixUnaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
    case garbageBetweenExpressionAndOperatorToken
    case operatorToken
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PostfixUnaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .postfixUnaryExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PostfixUnaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .postfixUnaryExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax,
    _ garbageBetweenExpressionAndOperatorToken: GarbageNodesSyntax? = nil,
    operatorToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixUnaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return PostfixUnaryExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return PostfixUnaryExprSyntax(newData)
  }

  public var garbageBetweenExpressionAndOperatorToken: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExpressionAndOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExpressionAndOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExpressionAndOperatorToken` replaced.
  /// - param newChild: The new `garbageBetweenExpressionAndOperatorToken` to replace the node's
  ///                   current `garbageBetweenExpressionAndOperatorToken`, if present.
  public func withGarbageBetweenExpressionAndOperatorToken(
    _ newChild: GarbageNodesSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExpressionAndOperatorToken)
    return PostfixUnaryExprSyntax(newData)
  }

  public var operatorToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.operatorToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixOperator(""))
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return PostfixUnaryExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension PostfixUnaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExpressionAndOperatorToken": garbageBetweenExpressionAndOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SpecializeExprSyntax

public struct SpecializeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
    case garbageBetweenExpressionAndGenericArgumentClause
    case genericArgumentClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SpecializeExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .specializeExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SpecializeExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .specializeExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax,
    _ garbageBetweenExpressionAndGenericArgumentClause: GarbageNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndGenericArgumentClause?.raw,
      genericArgumentClause.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.specializeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return SpecializeExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return SpecializeExprSyntax(newData)
  }

  public var garbageBetweenExpressionAndGenericArgumentClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExpressionAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExpressionAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExpressionAndGenericArgumentClause` replaced.
  /// - param newChild: The new `garbageBetweenExpressionAndGenericArgumentClause` to replace the node's
  ///                   current `garbageBetweenExpressionAndGenericArgumentClause`, if present.
  public func withGarbageBetweenExpressionAndGenericArgumentClause(
    _ newChild: GarbageNodesSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExpressionAndGenericArgumentClause)
    return SpecializeExprSyntax(newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause,
                                 parent: Syntax(self))
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
    _ newChild: GenericArgumentClauseSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause)
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SpecializeExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is GenericArgumentClauseSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericArgumentClauseSyntax.self))
    }
  }
}

extension SpecializeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExpressionAndGenericArgumentClause": garbageBetweenExpressionAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": Syntax(genericArgumentClause).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - StringLiteralExprSyntax

public struct StringLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeOpenDelimiter
    case openDelimiter
    case garbageBetweenOpenDelimiterAndOpenQuote
    case openQuote
    case garbageBetweenOpenQuoteAndSegments
    case segments
    case garbageBetweenSegmentsAndCloseQuote
    case closeQuote
    case garbageBetweenCloseQuoteAndCloseDelimiter
    case closeDelimiter
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `StringLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .stringLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `StringLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .stringLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeOpenDelimiter: GarbageNodesSyntax? = nil,
    openDelimiter: TokenSyntax?,
    _ garbageBetweenOpenDelimiterAndOpenQuote: GarbageNodesSyntax? = nil,
    openQuote: TokenSyntax,
    _ garbageBetweenOpenQuoteAndSegments: GarbageNodesSyntax? = nil,
    segments: StringLiteralSegmentsSyntax,
    _ garbageBetweenSegmentsAndCloseQuote: GarbageNodesSyntax? = nil,
    closeQuote: TokenSyntax,
    _ garbageBetweenCloseQuoteAndCloseDelimiter: GarbageNodesSyntax? = nil,
    closeDelimiter: TokenSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeOpenDelimiter?.raw,
      openDelimiter?.raw,
      garbageBetweenOpenDelimiterAndOpenQuote?.raw,
      openQuote.raw,
      garbageBetweenOpenQuoteAndSegments?.raw,
      segments.raw,
      garbageBetweenSegmentsAndCloseQuote?.raw,
      closeQuote.raw,
      garbageBetweenCloseQuoteAndCloseDelimiter?.raw,
      closeDelimiter?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeOpenDelimiter: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeOpenDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeOpenDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeOpenDelimiter` replaced.
  /// - param newChild: The new `garbageBeforeOpenDelimiter` to replace the node's
  ///                   current `garbageBeforeOpenDelimiter`, if present.
  public func withGarbageBeforeOpenDelimiter(
    _ newChild: GarbageNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeOpenDelimiter)
    return StringLiteralExprSyntax(newData)
  }

  public var openDelimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.openDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOpenDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `openDelimiter` replaced.
  /// - param newChild: The new `openDelimiter` to replace the node's
  ///                   current `openDelimiter`, if present.
  public func withOpenDelimiter(
    _ newChild: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.openDelimiter)
    return StringLiteralExprSyntax(newData)
  }

  public var garbageBetweenOpenDelimiterAndOpenQuote: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOpenDelimiterAndOpenQuote,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOpenDelimiterAndOpenQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOpenDelimiterAndOpenQuote` replaced.
  /// - param newChild: The new `garbageBetweenOpenDelimiterAndOpenQuote` to replace the node's
  ///                   current `garbageBetweenOpenDelimiterAndOpenQuote`, if present.
  public func withGarbageBetweenOpenDelimiterAndOpenQuote(
    _ newChild: GarbageNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOpenDelimiterAndOpenQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var openQuote: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.openQuote,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOpenQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `openQuote` replaced.
  /// - param newChild: The new `openQuote` to replace the node's
  ///                   current `openQuote`, if present.
  public func withOpenQuote(
    _ newChild: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringQuote)
    let newData = data.replacingChild(raw, at: Cursor.openQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var garbageBetweenOpenQuoteAndSegments: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenOpenQuoteAndSegments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenOpenQuoteAndSegments(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenOpenQuoteAndSegments` replaced.
  /// - param newChild: The new `garbageBetweenOpenQuoteAndSegments` to replace the node's
  ///                   current `garbageBetweenOpenQuoteAndSegments`, if present.
  public func withGarbageBetweenOpenQuoteAndSegments(
    _ newChild: GarbageNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenOpenQuoteAndSegments)
    return StringLiteralExprSyntax(newData)
  }

  public var segments: StringLiteralSegmentsSyntax {
    get {
      let childData = data.child(at: Cursor.segments,
                                 parent: Syntax(self))
      return StringLiteralSegmentsSyntax(childData!)
    }
    set(value) {
      self = withSegments(value)
    }
  }

  /// Adds the provided `Segment` to the node's `segments`
  /// collection.
  /// - param element: The new `Segment` to add to the node's
  ///                  `segments` collection.
  /// - returns: A copy of the receiver with the provided `Segment`
  ///            appended to its `segments` collection.
  public func addSegment(_ element: Syntax) -> StringLiteralExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.segments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.stringLiteralSegments,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.segments)
    return StringLiteralExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `segments` replaced.
  /// - param newChild: The new `segments` to replace the node's
  ///                   current `segments`, if present.
  public func withSegments(
    _ newChild: StringLiteralSegmentsSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringLiteralSegments)
    let newData = data.replacingChild(raw, at: Cursor.segments)
    return StringLiteralExprSyntax(newData)
  }

  public var garbageBetweenSegmentsAndCloseQuote: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSegmentsAndCloseQuote,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSegmentsAndCloseQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSegmentsAndCloseQuote` replaced.
  /// - param newChild: The new `garbageBetweenSegmentsAndCloseQuote` to replace the node's
  ///                   current `garbageBetweenSegmentsAndCloseQuote`, if present.
  public func withGarbageBetweenSegmentsAndCloseQuote(
    _ newChild: GarbageNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSegmentsAndCloseQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var closeQuote: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.closeQuote,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCloseQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `closeQuote` replaced.
  /// - param newChild: The new `closeQuote` to replace the node's
  ///                   current `closeQuote`, if present.
  public func withCloseQuote(
    _ newChild: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringQuote)
    let newData = data.replacingChild(raw, at: Cursor.closeQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var garbageBetweenCloseQuoteAndCloseDelimiter: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCloseQuoteAndCloseDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCloseQuoteAndCloseDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCloseQuoteAndCloseDelimiter` replaced.
  /// - param newChild: The new `garbageBetweenCloseQuoteAndCloseDelimiter` to replace the node's
  ///                   current `garbageBetweenCloseQuoteAndCloseDelimiter`, if present.
  public func withGarbageBetweenCloseQuoteAndCloseDelimiter(
    _ newChild: GarbageNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCloseQuoteAndCloseDelimiter)
    return StringLiteralExprSyntax(newData)
  }

  public var closeDelimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.closeDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCloseDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `closeDelimiter` replaced.
  /// - param newChild: The new `closeDelimiter` to replace the node's
  ///                   current `closeDelimiter`, if present.
  public func withCloseDelimiter(
    _ newChild: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.closeDelimiter)
    return StringLiteralExprSyntax(newData)
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
    // Check child #1 child is TokenSyntax or missing
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
    // Check child #5 child is StringLiteralSegmentsSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(StringLiteralSegmentsSyntax.self))
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
    // Check child #9 child is TokenSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension StringLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeOpenDelimiter": garbageBeforeOpenDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openDelimiter": openDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenOpenDelimiterAndOpenQuote": garbageBetweenOpenDelimiterAndOpenQuote.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openQuote": Syntax(openQuote).asProtocol(SyntaxProtocol.self),
      "garbageBetweenOpenQuoteAndSegments": garbageBetweenOpenQuoteAndSegments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "segments": Syntax(segments).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSegmentsAndCloseQuote": garbageBetweenSegmentsAndCloseQuote.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "closeQuote": Syntax(closeQuote).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCloseQuoteAndCloseDelimiter": garbageBetweenCloseQuoteAndCloseDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "closeDelimiter": closeDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - RegexLiteralExprSyntax

public struct RegexLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeRegex
    case regex
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `RegexLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .regexLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `RegexLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .regexLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeRegex: GarbageNodesSyntax? = nil,
    regex: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeRegex?.raw,
      regex.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.regexLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeRegex: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeRegex,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeRegex(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeRegex` replaced.
  /// - param newChild: The new `garbageBeforeRegex` to replace the node's
  ///                   current `garbageBeforeRegex`, if present.
  public func withGarbageBeforeRegex(
    _ newChild: GarbageNodesSyntax?) -> RegexLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeRegex)
    return RegexLiteralExprSyntax(newData)
  }

  public var regex: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.regex,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRegex(value)
    }
  }

  /// Returns a copy of the receiver with its `regex` replaced.
  /// - param newChild: The new `regex` to replace the node's
  ///                   current `regex`, if present.
  public func withRegex(
    _ newChild: TokenSyntax?) -> RegexLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.regexLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.regex)
    return RegexLiteralExprSyntax(newData)
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

extension RegexLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeRegex": garbageBeforeRegex.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "regex": Syntax(regex).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathExprSyntax

public struct KeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBackslash
    case backslash
    case garbageBetweenBackslashAndRootExpr
    case rootExpr
    case garbageBetweenRootExprAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBackslash: GarbageNodesSyntax? = nil,
    backslash: TokenSyntax,
    _ garbageBetweenBackslashAndRootExpr: GarbageNodesSyntax? = nil,
    rootExpr: ExprSyntax?,
    _ garbageBetweenRootExprAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBackslash?.raw,
      backslash.raw,
      garbageBetweenBackslashAndRootExpr?.raw,
      rootExpr?.raw,
      garbageBetweenRootExprAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBackslash: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBackslash,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBackslash(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBackslash` replaced.
  /// - param newChild: The new `garbageBeforeBackslash` to replace the node's
  ///                   current `garbageBeforeBackslash`, if present.
  public func withGarbageBeforeBackslash(
    _ newChild: GarbageNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBackslash)
    return KeyPathExprSyntax(newData)
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.backslash,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withBackslash(value)
    }
  }

  /// Returns a copy of the receiver with its `backslash` replaced.
  /// - param newChild: The new `backslash` to replace the node's
  ///                   current `backslash`, if present.
  public func withBackslash(
    _ newChild: TokenSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.backslash)
    let newData = data.replacingChild(raw, at: Cursor.backslash)
    return KeyPathExprSyntax(newData)
  }

  public var garbageBetweenBackslashAndRootExpr: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBackslashAndRootExpr,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBackslashAndRootExpr(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBackslashAndRootExpr` replaced.
  /// - param newChild: The new `garbageBetweenBackslashAndRootExpr` to replace the node's
  ///                   current `garbageBetweenBackslashAndRootExpr`, if present.
  public func withGarbageBetweenBackslashAndRootExpr(
    _ newChild: GarbageNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBackslashAndRootExpr)
    return KeyPathExprSyntax(newData)
  }

  public var rootExpr: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.rootExpr,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withRootExpr(value)
    }
  }

  /// Returns a copy of the receiver with its `rootExpr` replaced.
  /// - param newChild: The new `rootExpr` to replace the node's
  ///                   current `rootExpr`, if present.
  public func withRootExpr(
    _ newChild: ExprSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rootExpr)
    return KeyPathExprSyntax(newData)
  }

  public var garbageBetweenRootExprAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenRootExprAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenRootExprAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenRootExprAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenRootExprAndExpression` to replace the node's
  ///                   current `garbageBetweenRootExprAndExpression`, if present.
  public func withGarbageBetweenRootExprAndExpression(
    _ newChild: GarbageNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenRootExprAndExpression)
    return KeyPathExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return KeyPathExprSyntax(newData)
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
    // Check child #3 child is ExprSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is ExprSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension KeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBackslash": garbageBeforeBackslash.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBackslashAndRootExpr": garbageBetweenBackslashAndRootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rootExpr": rootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenRootExprAndExpression": garbageBetweenRootExprAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathBaseExprSyntax

public struct KeyPathBaseExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePeriod
    case period
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `KeyPathBaseExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .keyPathBaseExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `KeyPathBaseExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathBaseExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePeriod: GarbageNodesSyntax? = nil,
    period: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePeriod?.raw,
      period.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathBaseExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePeriod: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePeriod` replaced.
  /// - param newChild: The new `garbageBeforePeriod` to replace the node's
  ///                   current `garbageBeforePeriod`, if present.
  public func withGarbageBeforePeriod(
    _ newChild: GarbageNodesSyntax?) -> KeyPathBaseExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePeriod)
    return KeyPathBaseExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> KeyPathBaseExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return KeyPathBaseExprSyntax(newData)
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

extension KeyPathBaseExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePeriod": garbageBeforePeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcKeyPathExprSyntax

public struct ObjcKeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeKeyPath
    case keyPath
    case garbageBetweenKeyPathAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndName
    case name
    case garbageBetweenNameAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ObjcKeyPathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .objcKeyPathExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ObjcKeyPathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objcKeyPathExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeKeyPath: GarbageNodesSyntax? = nil,
    keyPath: TokenSyntax,
    _ garbageBetweenKeyPathAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndName: GarbageNodesSyntax? = nil,
    name: ObjcNameSyntax,
    _ garbageBetweenNameAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeKeyPath?.raw,
      keyPath.raw,
      garbageBetweenKeyPathAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndName?.raw,
      name.raw,
      garbageBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcKeyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeKeyPath: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeKeyPath,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeKeyPath(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeKeyPath` replaced.
  /// - param newChild: The new `garbageBeforeKeyPath` to replace the node's
  ///                   current `garbageBeforeKeyPath`, if present.
  public func withGarbageBeforeKeyPath(
    _ newChild: GarbageNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeKeyPath)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var keyPath: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.keyPath,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withKeyPath(value)
    }
  }

  /// Returns a copy of the receiver with its `keyPath` replaced.
  /// - param newChild: The new `keyPath` to replace the node's
  ///                   current `keyPath`, if present.
  public func withKeyPath(
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundKeyPathKeyword)
    let newData = data.replacingChild(raw, at: Cursor.keyPath)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var garbageBetweenKeyPathAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenKeyPathAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenKeyPathAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenKeyPathAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenKeyPathAndLeftParen` to replace the node's
  ///                   current `garbageBetweenKeyPathAndLeftParen`, if present.
  public func withGarbageBetweenKeyPathAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenKeyPathAndLeftParen)
    return ObjcKeyPathExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var garbageBetweenLeftParenAndName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndName` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndName` to replace the node's
  ///                   current `garbageBetweenLeftParenAndName`, if present.
  public func withGarbageBetweenLeftParenAndName(
    _ newChild: GarbageNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndName)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var name: ObjcNameSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return ObjcNameSyntax(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Adds the provided `NamePiece` to the node's `name`
  /// collection.
  /// - param element: The new `NamePiece` to add to the node's
  ///                  `name` collection.
  /// - returns: A copy of the receiver with the provided `NamePiece`
  ///            appended to its `name` collection.
  public func addNamePiece(_ element: ObjcNamePieceSyntax) -> ObjcKeyPathExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.name] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.objcName,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.name)
    return ObjcKeyPathExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: ObjcNameSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.objcName)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var garbageBetweenNameAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenNameAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenNameAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenNameAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenNameAndRightParen` to replace the node's
  ///                   current `garbageBetweenNameAndRightParen`, if present.
  public func withGarbageBetweenNameAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenNameAndRightParen)
    return ObjcKeyPathExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcKeyPathExprSyntax(newData)
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
    // Check child #5 child is ObjcNameSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ObjcNameSyntax.self))
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

extension ObjcKeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeKeyPath": garbageBeforeKeyPath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "keyPath": Syntax(keyPath).asProtocol(SyntaxProtocol.self),
      "garbageBetweenKeyPathAndLeftParen": garbageBetweenKeyPathAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndName": garbageBetweenLeftParenAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "garbageBetweenNameAndRightParen": garbageBetweenNameAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcSelectorExprSyntax

public struct ObjcSelectorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundSelector
    case poundSelector
    case garbageBetweenPoundSelectorAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndKind
    case kind
    case garbageBetweenKindAndColon
    case colon
    case garbageBetweenColonAndName
    case name
    case garbageBetweenNameAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ObjcSelectorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .objcSelectorExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ObjcSelectorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objcSelectorExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundSelector: GarbageNodesSyntax? = nil,
    poundSelector: TokenSyntax,
    _ garbageBetweenPoundSelectorAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndKind: GarbageNodesSyntax? = nil,
    kind: TokenSyntax?,
    _ garbageBetweenKindAndColon: GarbageNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ garbageBetweenColonAndName: GarbageNodesSyntax? = nil,
    name: ExprSyntax,
    _ garbageBetweenNameAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundSelector?.raw,
      poundSelector.raw,
      garbageBetweenPoundSelectorAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndKind?.raw,
      kind?.raw,
      garbageBetweenKindAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndName?.raw,
      name.raw,
      garbageBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcSelectorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundSelector: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundSelector,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundSelector(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundSelector` replaced.
  /// - param newChild: The new `garbageBeforePoundSelector` to replace the node's
  ///                   current `garbageBeforePoundSelector`, if present.
  public func withGarbageBeforePoundSelector(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundSelector)
    return ObjcSelectorExprSyntax(newData)
  }

  public var poundSelector: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundSelector,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundSelector(value)
    }
  }

  /// Returns a copy of the receiver with its `poundSelector` replaced.
  /// - param newChild: The new `poundSelector` to replace the node's
  ///                   current `poundSelector`, if present.
  public func withPoundSelector(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundSelectorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundSelector)
    return ObjcSelectorExprSyntax(newData)
  }

  public var garbageBetweenPoundSelectorAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPoundSelectorAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPoundSelectorAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPoundSelectorAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenPoundSelectorAndLeftParen` to replace the node's
  ///                   current `garbageBetweenPoundSelectorAndLeftParen`, if present.
  public func withGarbageBetweenPoundSelectorAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPoundSelectorAndLeftParen)
    return ObjcSelectorExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcSelectorExprSyntax(newData)
  }

  public var garbageBetweenLeftParenAndKind: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndKind(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndKind` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndKind` to replace the node's
  ///                   current `garbageBetweenLeftParenAndKind`, if present.
  public func withGarbageBetweenLeftParenAndKind(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndKind)
    return ObjcSelectorExprSyntax(newData)
  }

  public var kind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.kind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withKind(value)
    }
  }

  /// Returns a copy of the receiver with its `kind` replaced.
  /// - param newChild: The new `kind` to replace the node's
  ///                   current `kind`, if present.
  public func withKind(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.kind)
    return ObjcSelectorExprSyntax(newData)
  }

  public var garbageBetweenKindAndColon: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenKindAndColon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenKindAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenKindAndColon` replaced.
  /// - param newChild: The new `garbageBetweenKindAndColon` to replace the node's
  ///                   current `garbageBetweenKindAndColon`, if present.
  public func withGarbageBetweenKindAndColon(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenKindAndColon)
    return ObjcSelectorExprSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
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
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return ObjcSelectorExprSyntax(newData)
  }

  public var garbageBetweenColonAndName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenColonAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenColonAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenColonAndName` replaced.
  /// - param newChild: The new `garbageBetweenColonAndName` to replace the node's
  ///                   current `garbageBetweenColonAndName`, if present.
  public func withGarbageBetweenColonAndName(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenColonAndName)
    return ObjcSelectorExprSyntax(newData)
  }

  public var name: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: ExprSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcSelectorExprSyntax(newData)
  }

  public var garbageBetweenNameAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenNameAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenNameAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenNameAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenNameAndRightParen` to replace the node's
  ///                   current `garbageBetweenNameAndRightParen`, if present.
  public func withGarbageBetweenNameAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenNameAndRightParen)
    return ObjcSelectorExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcSelectorExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 12)
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
    // Check child #5 child is TokenSyntax or missing
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
    // Check child #9 child is ExprSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TokenSyntax 
    assert(rawChildren[11].raw != nil)
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ObjcSelectorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundSelector": garbageBeforePoundSelector.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundSelector": Syntax(poundSelector).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPoundSelectorAndLeftParen": garbageBetweenPoundSelectorAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndKind": garbageBetweenLeftParenAndKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "kind": kind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenKindAndColon": garbageBetweenKindAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenColonAndName": garbageBetweenColonAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "garbageBetweenNameAndRightParen": garbageBetweenNameAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixIfConfigExprSyntax

public struct PostfixIfConfigExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBase
    case base
    case garbageBetweenBaseAndConfig
    case config
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PostfixIfConfigExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .postfixIfConfigExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PostfixIfConfigExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .postfixIfConfigExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBase: GarbageNodesSyntax? = nil,
    base: ExprSyntax?,
    _ garbageBetweenBaseAndConfig: GarbageNodesSyntax? = nil,
    config: IfConfigDeclSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBase?.raw,
      base?.raw,
      garbageBetweenBaseAndConfig?.raw,
      config.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixIfConfigExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBase: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBase,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBase(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBase` replaced.
  /// - param newChild: The new `garbageBeforeBase` to replace the node's
  ///                   current `garbageBeforeBase`, if present.
  public func withGarbageBeforeBase(
    _ newChild: GarbageNodesSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBase)
    return PostfixIfConfigExprSyntax(newData)
  }

  public var base: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.base,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withBase(value)
    }
  }

  /// Returns a copy of the receiver with its `base` replaced.
  /// - param newChild: The new `base` to replace the node's
  ///                   current `base`, if present.
  public func withBase(
    _ newChild: ExprSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.base)
    return PostfixIfConfigExprSyntax(newData)
  }

  public var garbageBetweenBaseAndConfig: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBaseAndConfig,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBaseAndConfig(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBaseAndConfig` replaced.
  /// - param newChild: The new `garbageBetweenBaseAndConfig` to replace the node's
  ///                   current `garbageBetweenBaseAndConfig`, if present.
  public func withGarbageBetweenBaseAndConfig(
    _ newChild: GarbageNodesSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBaseAndConfig)
    return PostfixIfConfigExprSyntax(newData)
  }

  public var config: IfConfigDeclSyntax {
    get {
      let childData = data.child(at: Cursor.config,
                                 parent: Syntax(self))
      return IfConfigDeclSyntax(childData!)
    }
    set(value) {
      self = withConfig(value)
    }
  }

  /// Returns a copy of the receiver with its `config` replaced.
  /// - param newChild: The new `config` to replace the node's
  ///                   current `config`, if present.
  public func withConfig(
    _ newChild: IfConfigDeclSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.ifConfigDecl)
    let newData = data.replacingChild(raw, at: Cursor.config)
    return PostfixIfConfigExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #2 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #3 child is IfConfigDeclSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(IfConfigDeclSyntax.self))
    }
  }
}

extension PostfixIfConfigExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBase": garbageBeforeBase.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenBaseAndConfig": garbageBetweenBaseAndConfig.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "config": Syntax(config).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - EditorPlaceholderExprSyntax

public struct EditorPlaceholderExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIdentifier
    case identifier
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `EditorPlaceholderExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .editorPlaceholderExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `EditorPlaceholderExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .editorPlaceholderExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.editorPlaceholderExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> EditorPlaceholderExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIdentifier)
    return EditorPlaceholderExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> EditorPlaceholderExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EditorPlaceholderExprSyntax(newData)
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

extension EditorPlaceholderExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIdentifier": garbageBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjectLiteralExprSyntax

public struct ObjectLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIdentifier
    case identifier
    case garbageBetweenIdentifierAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndArguments
    case arguments
    case garbageBetweenArgumentsAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ObjectLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .objectLiteralExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ObjectLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objectLiteralExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIdentifier: GarbageNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ garbageBetweenIdentifierAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? = nil,
    arguments: TupleExprElementListSyntax,
    _ garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objectLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
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
    _ newChild: GarbageNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIdentifier)
    return ObjectLiteralExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ObjectLiteralExprSyntax(newData)
  }

  public var garbageBetweenIdentifierAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIdentifierAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIdentifierAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIdentifierAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenIdentifierAndLeftParen` to replace the node's
  ///                   current `garbageBetweenIdentifierAndLeftParen`, if present.
  public func withGarbageBetweenIdentifierAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIdentifierAndLeftParen)
    return ObjectLiteralExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjectLiteralExprSyntax(newData)
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
    _ newChild: GarbageNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndArguments)
    return ObjectLiteralExprSyntax(newData)
  }

  public var arguments: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      return TupleExprElementListSyntax(childData!)
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
  public func addArgument(_ element: TupleExprElementSyntax) -> ObjectLiteralExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.arguments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.arguments)
    return ObjectLiteralExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: TupleExprElementListSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleExprElementList)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return ObjectLiteralExprSyntax(newData)
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
    _ newChild: GarbageNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenArgumentsAndRightParen)
    return ObjectLiteralExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjectLiteralExprSyntax(newData)
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
    // Check child #5 child is TupleExprElementListSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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

extension ObjectLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIdentifier": garbageBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIdentifierAndLeftParen": garbageBetweenIdentifierAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndArguments": garbageBetweenLeftParenAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "garbageBetweenArgumentsAndRightParen": garbageBetweenArgumentsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

