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

// MARK: - InOutExprSyntax

public struct InOutExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case ampersand
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return InOutExprSyntax(newData)
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

extension InOutExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ampersand": Syntax(ampersand).asProtocol(SyntaxProtocol.self),
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundColumnExprSyntax

public struct PoundColumnExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundColumnExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundColumn": Syntax(poundColumn).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TryExprSyntax

public struct TryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case tryKeyword
    case questionOrExclamationMark
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TryExprSyntax(newData)
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
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is ExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
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
      "tryKeyword": Syntax(tryKeyword).asProtocol(SyntaxProtocol.self),
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AwaitExprSyntax

public struct AwaitExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case awaitKeyword
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.awaitKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return AwaitExprSyntax(newData)
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

extension AwaitExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "awaitKeyword": Syntax(awaitKeyword).asProtocol(SyntaxProtocol.self),
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IdentifierExprSyntax

public struct IdentifierExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case identifier
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
    _ newChild: TokenSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
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
    // Check child #1 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SuperRefExprSyntax

public struct SuperRefExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension SuperRefExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "superKeyword": Syntax(superKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - NilLiteralExprSyntax

public struct NilLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension NilLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "nilKeyword": Syntax(nilKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DiscardAssignmentExprSyntax

public struct DiscardAssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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
    _ newChild: TokenSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.wildcardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return DiscardAssignmentExprSyntax(newData)
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

extension DiscardAssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AssignmentExprSyntax

public struct AssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension AssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "assignToken": Syntax(assignToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SequenceExprSyntax

public struct SequenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 1)
    // Check child #0 child is ExprListSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
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
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundLineExprSyntax

public struct PoundLineExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundLineExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundLine": Syntax(poundLine).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileExprSyntax

public struct PoundFileExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundFileExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFile": Syntax(poundFile).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileIDExprSyntax

public struct PoundFileIDExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundFileIDExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFileID": Syntax(poundFileID).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFilePathExprSyntax

public struct PoundFilePathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundFilePathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFilePath": Syntax(poundFilePath).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFunctionExprSyntax

public struct PoundFunctionExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundFunctionExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFunction": Syntax(poundFunction).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundDsohandleExprSyntax

public struct PoundDsohandleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension PoundDsohandleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundDsohandle": Syntax(poundDsohandle).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SymbolicReferenceExprSyntax

public struct SymbolicReferenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case identifier
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
    _ newChild: TokenSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
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
    // Check child #1 child is GenericArgumentClauseSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrefixOperatorExprSyntax

public struct PrefixOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case operatorToken
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.postfixExpression)
    return PrefixOperatorExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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

extension PrefixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "operatorToken": operatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "postfixExpression": Syntax(postfixExpression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BinaryOperatorExprSyntax

public struct BinaryOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension BinaryOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrowExprSyntax

public struct ArrowExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case asyncKeyword
    case throwsToken
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
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
  }
}

extension ArrowExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsToken": throwsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrowToken": Syntax(arrowToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FloatLiteralExprSyntax

public struct FloatLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension FloatLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "floatingDigits": Syntax(floatingDigits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TupleExprSyntax

public struct TupleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case elementList
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
    _ newChild: TokenSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
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
    // Check child #1 child is TupleExprElementListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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

extension TupleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrayExprSyntax

public struct ArrayExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftSquare
    case elements
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    // Check child #1 child is ArrayElementListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ArrayElementListSyntax.self))
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

extension ArrayExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DictionaryExprSyntax

public struct DictionaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftSquare
    case content
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    // Check child #1 child is Syntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
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

extension DictionaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "content": Syntax(content).asProtocol(SyntaxProtocol.self),
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IntegerLiteralExprSyntax

public struct IntegerLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension IntegerLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "digits": Syntax(digits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BooleanLiteralExprSyntax

public struct BooleanLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension BooleanLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "booleanLiteral": Syntax(booleanLiteral).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TernaryExprSyntax

public struct TernaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case conditionExpression
    case questionMark
    case firstChoice
    case colonMark
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.conditionExpression)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.firstChoice)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.secondChoice)
    return TernaryExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #2 child is ExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #4 child is ExprSyntax 
    assert(rawChildren[4].raw != nil)
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
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
      "conditionExpression": Syntax(conditionExpression).asProtocol(SyntaxProtocol.self),
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "firstChoice": Syntax(firstChoice).asProtocol(SyntaxProtocol.self),
      "colonMark": Syntax(colonMark).asProtocol(SyntaxProtocol.self),
      "secondChoice": Syntax(secondChoice).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MemberAccessExprSyntax

public struct MemberAccessExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case base
    case dot
    case name
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 4)
    // Check child #0 child is ExprSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension MemberAccessExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": Syntax(dot).asProtocol(SyntaxProtocol.self),
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsExprSyntax

public struct IsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case isTok
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return IsExprSyntax(newData)
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

extension IsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "isTok": Syntax(isTok).asProtocol(SyntaxProtocol.self),
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AsExprSyntax

public struct AsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case asTok
    case questionOrExclamationMark
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return AsExprSyntax(newData)
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
    // Check child #1 child is TokenSyntax or missing
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

extension AsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "asTok": Syntax(asTok).asProtocol(SyntaxProtocol.self),
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TypeExprSyntax

public struct TypeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TypeExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 1)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
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
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ClosureExprSyntax

public struct ClosureExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftBrace
    case signature
    case statements
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ClosureSignatureSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureSignatureSyntax.self))
    }
    // Check child #2 child is CodeBlockItemListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockItemListSyntax.self))
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

extension ClosureExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "signature": signature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - UnresolvedPatternExprSyntax

public struct UnresolvedPatternExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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
    _ newChild: PatternSyntax?) -> UnresolvedPatternExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return UnresolvedPatternExprSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 1)
    // Check child #0 child is PatternSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
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
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionCallExprSyntax

public struct FunctionCallExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case calledExpression
    case leftParen
    case argumentList
    case rightParen
    case trailingClosure
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
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
    assert(rawChildren.count == 6)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TupleExprElementListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is ClosureExprSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureExprSyntax.self))
    }
    // Check child #5 child is MultipleTrailingClosureElementListSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
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
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptExprSyntax

public struct SubscriptExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case calledExpression
    case leftBracket
    case argumentList
    case rightBracket
    case trailingClosure
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
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
    assert(rawChildren.count == 6)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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
    // Check child #2 child is TupleExprElementListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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
    // Check child #4 child is ClosureExprSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureExprSyntax.self))
    }
    // Check child #5 child is MultipleTrailingClosureElementListSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
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
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "leftBracket": Syntax(leftBracket).asProtocol(SyntaxProtocol.self),
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "rightBracket": Syntax(rightBracket).asProtocol(SyntaxProtocol.self),
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalChainingExprSyntax

public struct OptionalChainingExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case expression
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
    _ newChild: ExprSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension OptionalChainingExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ForcedValueExprSyntax

public struct ForcedValueExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case expression
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
    _ newChild: ExprSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension ForcedValueExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixUnaryExprSyntax

public struct PostfixUnaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case expression
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
    _ newChild: ExprSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension PostfixUnaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SpecializeExprSyntax

public struct SpecializeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case expression
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
    _ newChild: ExprSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #1 child is GenericArgumentClauseSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "genericArgumentClause": Syntax(genericArgumentClause).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - StringLiteralExprSyntax

public struct StringLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case openDelimiter
    case openQuote
    case segments
    case closeQuote
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 5)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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
    // Check child #2 child is StringLiteralSegmentsSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(StringLiteralSegmentsSyntax.self))
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
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
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
      "openDelimiter": openDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openQuote": Syntax(openQuote).asProtocol(SyntaxProtocol.self),
      "segments": Syntax(segments).asProtocol(SyntaxProtocol.self),
      "closeQuote": Syntax(closeQuote).asProtocol(SyntaxProtocol.self),
      "closeDelimiter": closeDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - RegexLiteralExprSyntax

public struct RegexLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension RegexLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "regex": Syntax(regex).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathExprSyntax

public struct KeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case backslash
    case rootExpr
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return KeyPathExprSyntax(newData)
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
    // Check child #1 child is ExprSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #2 child is ExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
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
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self),
      "rootExpr": rootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathBaseExprSyntax

public struct KeyPathBaseExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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

extension KeyPathBaseExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcKeyPathExprSyntax

public struct ObjcKeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case keyPath
    case leftParen
    case name
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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
    // Check child #2 child is ObjcNameSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ObjcNameSyntax.self))
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

extension ObjcKeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "keyPath": Syntax(keyPath).asProtocol(SyntaxProtocol.self),
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcSelectorExprSyntax

public struct ObjcSelectorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case poundSelector
    case leftParen
    case kind
    case colon
    case name
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.name)
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
    assert(rawChildren.count == 6)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is ExprSyntax 
    assert(rawChildren[4].raw != nil)
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
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

extension ObjcSelectorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundSelector": Syntax(poundSelector).asProtocol(SyntaxProtocol.self),
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "kind": kind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixIfConfigExprSyntax

public struct PostfixIfConfigExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case base
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

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #1 child is IfConfigDeclSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
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
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "config": Syntax(config).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - EditorPlaceholderExprSyntax

public struct EditorPlaceholderExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
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
    _ newChild: TokenSyntax?) -> EditorPlaceholderExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EditorPlaceholderExprSyntax(newData)
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

extension EditorPlaceholderExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjectLiteralExprSyntax

public struct ObjectLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case identifier
    case leftParen
    case arguments
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
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
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
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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
    // Check child #2 child is TupleExprElementListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
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

extension ObjectLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

