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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unknownExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.missingExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
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
    case unexpectedBeforeAmpersand
    case ampersand
    case unexpectedBetweenAmpersandAndExpression
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
    _ unexpectedBeforeAmpersand: UnexpectedNodesSyntax? = nil,
    ampersand: TokenSyntax,
    _ unexpectedBetweenAmpersandAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAmpersand?.raw,
      ampersand.raw,
      unexpectedBetweenAmpersandAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.inOutExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAmpersand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAmpersand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAmpersand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAmpersand` replaced.
  /// - param newChild: The new `unexpectedBeforeAmpersand` to replace the node's
  ///                   current `unexpectedBeforeAmpersand`, if present.
  public func withUnexpectedBeforeAmpersand(
    _ newChild: UnexpectedNodesSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAmpersand)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.prefixAmpersand, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.ampersand)
    return InOutExprSyntax(newData)
  }

  public var unexpectedBetweenAmpersandAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAmpersandAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAmpersandAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAmpersandAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenAmpersandAndExpression` to replace the node's
  ///                   current `unexpectedBetweenAmpersandAndExpression`, if present.
  public func withUnexpectedBetweenAmpersandAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAmpersandAndExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return InOutExprSyntax(newData)
  }
}

extension InOutExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAmpersand": unexpectedBeforeAmpersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ampersand": Syntax(ampersand).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAmpersandAndExpression": unexpectedBetweenAmpersandAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundColumnExprSyntax

public struct PoundColumnExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundColumn
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
    _ unexpectedBeforePoundColumn: UnexpectedNodesSyntax? = nil,
    poundColumn: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundColumn?.raw,
      poundColumn.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundColumnExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundColumn: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundColumn,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundColumn(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundColumn` replaced.
  /// - param newChild: The new `unexpectedBeforePoundColumn` to replace the node's
  ///                   current `unexpectedBeforePoundColumn`, if present.
  public func withUnexpectedBeforePoundColumn(
    _ newChild: UnexpectedNodesSyntax?) -> PoundColumnExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundColumn)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundColumnKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundColumn)
    return PoundColumnExprSyntax(newData)
  }
}

extension PoundColumnExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundColumn": unexpectedBeforePoundColumn.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundColumn": Syntax(poundColumn).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TryExprSyntax

public struct TryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeTryKeyword
    case tryKeyword
    case unexpectedBetweenTryKeywordAndQuestionOrExclamationMark
    case questionOrExclamationMark
    case unexpectedBetweenQuestionOrExclamationMarkAndExpression
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
    _ unexpectedBeforeTryKeyword: UnexpectedNodesSyntax? = nil,
    tryKeyword: TokenSyntax,
    _ unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax?,
    _ unexpectedBetweenQuestionOrExclamationMarkAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTryKeyword?.raw,
      tryKeyword.raw,
      unexpectedBetweenTryKeywordAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeTryKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeTryKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeTryKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeTryKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeTryKeyword` to replace the node's
  ///                   current `unexpectedBeforeTryKeyword`, if present.
  public func withUnexpectedBeforeTryKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeTryKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.tryKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.tryKeyword)
    return TryExprSyntax(newData)
  }

  public var unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenTryKeywordAndQuestionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTryKeywordAndQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTryKeywordAndQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `unexpectedBetweenTryKeywordAndQuestionOrExclamationMark` to replace the node's
  ///                   current `unexpectedBetweenTryKeywordAndQuestionOrExclamationMark`, if present.
  public func withUnexpectedBetweenTryKeywordAndQuestionOrExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenTryKeywordAndQuestionOrExclamationMark)
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

  public var unexpectedBetweenQuestionOrExclamationMarkAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenQuestionOrExclamationMarkAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenQuestionOrExclamationMarkAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenQuestionOrExclamationMarkAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenQuestionOrExclamationMarkAndExpression` to replace the node's
  ///                   current `unexpectedBetweenQuestionOrExclamationMarkAndExpression`, if present.
  public func withUnexpectedBetweenQuestionOrExclamationMarkAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenQuestionOrExclamationMarkAndExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TryExprSyntax(newData)
  }
}

extension TryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeTryKeyword": unexpectedBeforeTryKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "tryKeyword": Syntax(tryKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenTryKeywordAndQuestionOrExclamationMark": unexpectedBetweenTryKeywordAndQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenQuestionOrExclamationMarkAndExpression": unexpectedBetweenQuestionOrExclamationMarkAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AwaitExprSyntax

public struct AwaitExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAwaitKeyword
    case awaitKeyword
    case unexpectedBetweenAwaitKeywordAndExpression
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
    _ unexpectedBeforeAwaitKeyword: UnexpectedNodesSyntax? = nil,
    awaitKeyword: TokenSyntax,
    _ unexpectedBetweenAwaitKeywordAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAwaitKeyword?.raw,
      awaitKeyword.raw,
      unexpectedBetweenAwaitKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.awaitExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAwaitKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAwaitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAwaitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAwaitKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeAwaitKeyword` to replace the node's
  ///                   current `unexpectedBeforeAwaitKeyword`, if present.
  public func withUnexpectedBeforeAwaitKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAwaitKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.awaitKeyword)
    return AwaitExprSyntax(newData)
  }

  public var unexpectedBetweenAwaitKeywordAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAwaitKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAwaitKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAwaitKeywordAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenAwaitKeywordAndExpression` to replace the node's
  ///                   current `unexpectedBetweenAwaitKeywordAndExpression`, if present.
  public func withUnexpectedBetweenAwaitKeywordAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> AwaitExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAwaitKeywordAndExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return AwaitExprSyntax(newData)
  }
}

extension AwaitExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAwaitKeyword": unexpectedBeforeAwaitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "awaitKeyword": Syntax(awaitKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAwaitKeywordAndExpression": unexpectedBetweenAwaitKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MoveExprSyntax

public struct MoveExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeMoveKeyword
    case moveKeyword
    case unexpectedBetweenMoveKeywordAndExpression
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
    _ unexpectedBeforeMoveKeyword: UnexpectedNodesSyntax? = nil,
    moveKeyword: TokenSyntax,
    _ unexpectedBetweenMoveKeywordAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMoveKeyword?.raw,
      moveKeyword.raw,
      unexpectedBetweenMoveKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.moveExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeMoveKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeMoveKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeMoveKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeMoveKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeMoveKeyword` to replace the node's
  ///                   current `unexpectedBeforeMoveKeyword`, if present.
  public func withUnexpectedBeforeMoveKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeMoveKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.moveKeyword)
    return MoveExprSyntax(newData)
  }

  public var unexpectedBetweenMoveKeywordAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenMoveKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenMoveKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenMoveKeywordAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenMoveKeywordAndExpression` to replace the node's
  ///                   current `unexpectedBetweenMoveKeywordAndExpression`, if present.
  public func withUnexpectedBetweenMoveKeywordAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> MoveExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenMoveKeywordAndExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return MoveExprSyntax(newData)
  }
}

extension MoveExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeMoveKeyword": unexpectedBeforeMoveKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "moveKeyword": Syntax(moveKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenMoveKeywordAndExpression": unexpectedBetweenMoveKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IdentifierExprSyntax

public struct IdentifierExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndDeclNameArguments
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
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.identifierExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return IdentifierExprSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndDeclNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndDeclNameArguments` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndDeclNameArguments`, if present.
  public func withUnexpectedBetweenIdentifierAndDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndDeclNameArguments)
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
}

extension IdentifierExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndDeclNameArguments": unexpectedBetweenIdentifierAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SuperRefExprSyntax

public struct SuperRefExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeSuperKeyword
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
    _ unexpectedBeforeSuperKeyword: UnexpectedNodesSyntax? = nil,
    superKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSuperKeyword?.raw,
      superKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.superRefExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeSuperKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeSuperKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeSuperKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeSuperKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeSuperKeyword` to replace the node's
  ///                   current `unexpectedBeforeSuperKeyword`, if present.
  public func withUnexpectedBeforeSuperKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> SuperRefExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeSuperKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.superKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.superKeyword)
    return SuperRefExprSyntax(newData)
  }
}

extension SuperRefExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSuperKeyword": unexpectedBeforeSuperKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "superKeyword": Syntax(superKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - NilLiteralExprSyntax

public struct NilLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeNilKeyword
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
    _ unexpectedBeforeNilKeyword: UnexpectedNodesSyntax? = nil,
    nilKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNilKeyword?.raw,
      nilKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.nilLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeNilKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeNilKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeNilKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeNilKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeNilKeyword` to replace the node's
  ///                   current `unexpectedBeforeNilKeyword`, if present.
  public func withUnexpectedBeforeNilKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> NilLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeNilKeyword)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.nilKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.nilKeyword)
    return NilLiteralExprSyntax(newData)
  }
}

extension NilLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeNilKeyword": unexpectedBeforeNilKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "nilKeyword": Syntax(nilKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DiscardAssignmentExprSyntax

public struct DiscardAssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeWildcard
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
    _ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil,
    wildcard: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.discardAssignmentExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeWildcard: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeWildcard,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeWildcard` replaced.
  /// - param newChild: The new `unexpectedBeforeWildcard` to replace the node's
  ///                   current `unexpectedBeforeWildcard`, if present.
  public func withUnexpectedBeforeWildcard(
    _ newChild: UnexpectedNodesSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeWildcard)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return DiscardAssignmentExprSyntax(newData)
  }
}

extension DiscardAssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWildcard": unexpectedBeforeWildcard.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AssignmentExprSyntax

public struct AssignmentExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAssignToken
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
    _ unexpectedBeforeAssignToken: UnexpectedNodesSyntax? = nil,
    assignToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignToken?.raw,
      assignToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.assignmentExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAssignToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAssignToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAssignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAssignToken` replaced.
  /// - param newChild: The new `unexpectedBeforeAssignToken` to replace the node's
  ///                   current `unexpectedBeforeAssignToken`, if present.
  public func withUnexpectedBeforeAssignToken(
    _ newChild: UnexpectedNodesSyntax?) -> AssignmentExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAssignToken)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.assignToken)
    return AssignmentExprSyntax(newData)
  }
}

extension AssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAssignToken": unexpectedBeforeAssignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignToken": Syntax(assignToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SequenceExprSyntax

public struct SequenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeElements
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
    _ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil,
    elements: ExprListSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sequenceExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeElements,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> SequenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeElements)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.exprList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.exprList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return SequenceExprSyntax(newData)
  }
}

extension SequenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeElements": unexpectedBeforeElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundLineExprSyntax

public struct PoundLineExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundLine
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
    _ unexpectedBeforePoundLine: UnexpectedNodesSyntax? = nil,
    poundLine: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundLine?.raw,
      poundLine.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundLineExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundLine: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundLine,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundLine(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundLine` replaced.
  /// - param newChild: The new `unexpectedBeforePoundLine` to replace the node's
  ///                   current `unexpectedBeforePoundLine`, if present.
  public func withUnexpectedBeforePoundLine(
    _ newChild: UnexpectedNodesSyntax?) -> PoundLineExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundLine)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundLineKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundLine)
    return PoundLineExprSyntax(newData)
  }
}

extension PoundLineExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundLine": unexpectedBeforePoundLine.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundLine": Syntax(poundLine).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileExprSyntax

public struct PoundFileExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundFile
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
    _ unexpectedBeforePoundFile: UnexpectedNodesSyntax? = nil,
    poundFile: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFile?.raw,
      poundFile.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFileExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundFile: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundFile,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundFile(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundFile` replaced.
  /// - param newChild: The new `unexpectedBeforePoundFile` to replace the node's
  ///                   current `unexpectedBeforePoundFile`, if present.
  public func withUnexpectedBeforePoundFile(
    _ newChild: UnexpectedNodesSyntax?) -> PoundFileExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundFile)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundFileKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundFile)
    return PoundFileExprSyntax(newData)
  }
}

extension PoundFileExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundFile": unexpectedBeforePoundFile.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFile": Syntax(poundFile).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFileIDExprSyntax

public struct PoundFileIDExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundFileID
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
    _ unexpectedBeforePoundFileID: UnexpectedNodesSyntax? = nil,
    poundFileID: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFileID?.raw,
      poundFileID.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFileIDExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundFileID: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundFileID,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundFileID(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundFileID` replaced.
  /// - param newChild: The new `unexpectedBeforePoundFileID` to replace the node's
  ///                   current `unexpectedBeforePoundFileID`, if present.
  public func withUnexpectedBeforePoundFileID(
    _ newChild: UnexpectedNodesSyntax?) -> PoundFileIDExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundFileID)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundFileIDKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundFileID)
    return PoundFileIDExprSyntax(newData)
  }
}

extension PoundFileIDExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundFileID": unexpectedBeforePoundFileID.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFileID": Syntax(poundFileID).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFilePathExprSyntax

public struct PoundFilePathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundFilePath
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
    _ unexpectedBeforePoundFilePath: UnexpectedNodesSyntax? = nil,
    poundFilePath: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFilePath?.raw,
      poundFilePath.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFilePathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundFilePath: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundFilePath,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundFilePath(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundFilePath` replaced.
  /// - param newChild: The new `unexpectedBeforePoundFilePath` to replace the node's
  ///                   current `unexpectedBeforePoundFilePath`, if present.
  public func withUnexpectedBeforePoundFilePath(
    _ newChild: UnexpectedNodesSyntax?) -> PoundFilePathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundFilePath)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundFilePathKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundFilePath)
    return PoundFilePathExprSyntax(newData)
  }
}

extension PoundFilePathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundFilePath": unexpectedBeforePoundFilePath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFilePath": Syntax(poundFilePath).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundFunctionExprSyntax

public struct PoundFunctionExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundFunction
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
    _ unexpectedBeforePoundFunction: UnexpectedNodesSyntax? = nil,
    poundFunction: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFunction?.raw,
      poundFunction.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFunctionExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundFunction: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundFunction,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundFunction(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundFunction` replaced.
  /// - param newChild: The new `unexpectedBeforePoundFunction` to replace the node's
  ///                   current `unexpectedBeforePoundFunction`, if present.
  public func withUnexpectedBeforePoundFunction(
    _ newChild: UnexpectedNodesSyntax?) -> PoundFunctionExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundFunction)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundFunctionKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundFunction)
    return PoundFunctionExprSyntax(newData)
  }
}

extension PoundFunctionExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundFunction": unexpectedBeforePoundFunction.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundFunction": Syntax(poundFunction).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundDsohandleExprSyntax

public struct PoundDsohandleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundDsohandle
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
    _ unexpectedBeforePoundDsohandle: UnexpectedNodesSyntax? = nil,
    poundDsohandle: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundDsohandle?.raw,
      poundDsohandle.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundDsohandleExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundDsohandle: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundDsohandle,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundDsohandle(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundDsohandle` replaced.
  /// - param newChild: The new `unexpectedBeforePoundDsohandle` to replace the node's
  ///                   current `unexpectedBeforePoundDsohandle`, if present.
  public func withUnexpectedBeforePoundDsohandle(
    _ newChild: UnexpectedNodesSyntax?) -> PoundDsohandleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundDsohandle)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundDsohandleKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundDsohandle)
    return PoundDsohandleExprSyntax(newData)
  }
}

extension PoundDsohandleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundDsohandle": unexpectedBeforePoundDsohandle.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundDsohandle": Syntax(poundDsohandle).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SymbolicReferenceExprSyntax

public struct SymbolicReferenceExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndGenericArgumentClause
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
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.symbolicReferenceExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return SymbolicReferenceExprSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndGenericArgumentClause` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndGenericArgumentClause`, if present.
  public func withUnexpectedBetweenIdentifierAndGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndGenericArgumentClause)
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
}

extension SymbolicReferenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndGenericArgumentClause": unexpectedBetweenIdentifierAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrefixOperatorExprSyntax

public struct PrefixOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeOperatorToken
    case operatorToken
    case unexpectedBetweenOperatorTokenAndPostfixExpression
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
    _ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil,
    operatorToken: TokenSyntax?,
    _ unexpectedBetweenOperatorTokenAndPostfixExpression: UnexpectedNodesSyntax? = nil,
    postfixExpression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken?.raw,
      unexpectedBetweenOperatorTokenAndPostfixExpression?.raw,
      postfixExpression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.prefixOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeOperatorToken` replaced.
  /// - param newChild: The new `unexpectedBeforeOperatorToken` to replace the node's
  ///                   current `unexpectedBeforeOperatorToken`, if present.
  public func withUnexpectedBeforeOperatorToken(
    _ newChild: UnexpectedNodesSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeOperatorToken)
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

  public var unexpectedBetweenOperatorTokenAndPostfixExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOperatorTokenAndPostfixExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOperatorTokenAndPostfixExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOperatorTokenAndPostfixExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenOperatorTokenAndPostfixExpression` to replace the node's
  ///                   current `unexpectedBetweenOperatorTokenAndPostfixExpression`, if present.
  public func withUnexpectedBetweenOperatorTokenAndPostfixExpression(
    _ newChild: UnexpectedNodesSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOperatorTokenAndPostfixExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.postfixExpression)
    return PrefixOperatorExprSyntax(newData)
  }
}

extension PrefixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeOperatorToken": unexpectedBeforeOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": operatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenOperatorTokenAndPostfixExpression": unexpectedBetweenOperatorTokenAndPostfixExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "postfixExpression": Syntax(postfixExpression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BinaryOperatorExprSyntax

public struct BinaryOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeOperatorToken
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
    _ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil,
    operatorToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.binaryOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeOperatorToken` replaced.
  /// - param newChild: The new `unexpectedBeforeOperatorToken` to replace the node's
  ///                   current `unexpectedBeforeOperatorToken`, if present.
  public func withUnexpectedBeforeOperatorToken(
    _ newChild: UnexpectedNodesSyntax?) -> BinaryOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeOperatorToken)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return BinaryOperatorExprSyntax(newData)
  }
}

extension BinaryOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeOperatorToken": unexpectedBeforeOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrowExprSyntax

public struct ArrowExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAsyncKeyword
    case asyncKeyword
    case unexpectedBetweenAsyncKeywordAndThrowsToken
    case throwsToken
    case unexpectedBetweenThrowsTokenAndArrowToken
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
    _ unexpectedBeforeAsyncKeyword: UnexpectedNodesSyntax? = nil,
    asyncKeyword: TokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsToken: UnexpectedNodesSyntax? = nil,
    throwsToken: TokenSyntax?,
    _ unexpectedBetweenThrowsTokenAndArrowToken: UnexpectedNodesSyntax? = nil,
    arrowToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsToken?.raw,
      throwsToken?.raw,
      unexpectedBetweenThrowsTokenAndArrowToken?.raw,
      arrowToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrowExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAsyncKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAsyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAsyncKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeAsyncKeyword` to replace the node's
  ///                   current `unexpectedBeforeAsyncKeyword`, if present.
  public func withUnexpectedBeforeAsyncKeyword(
    _ newChild: UnexpectedNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAsyncKeyword)
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

  public var unexpectedBetweenAsyncKeywordAndThrowsToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAsyncKeywordAndThrowsToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsyncKeywordAndThrowsToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsyncKeywordAndThrowsToken` replaced.
  /// - param newChild: The new `unexpectedBetweenAsyncKeywordAndThrowsToken` to replace the node's
  ///                   current `unexpectedBetweenAsyncKeywordAndThrowsToken`, if present.
  public func withUnexpectedBetweenAsyncKeywordAndThrowsToken(
    _ newChild: UnexpectedNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAsyncKeywordAndThrowsToken)
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

  public var unexpectedBetweenThrowsTokenAndArrowToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenThrowsTokenAndArrowToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenThrowsTokenAndArrowToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenThrowsTokenAndArrowToken` replaced.
  /// - param newChild: The new `unexpectedBetweenThrowsTokenAndArrowToken` to replace the node's
  ///                   current `unexpectedBetweenThrowsTokenAndArrowToken`, if present.
  public func withUnexpectedBetweenThrowsTokenAndArrowToken(
    _ newChild: UnexpectedNodesSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenThrowsTokenAndArrowToken)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.arrowToken)
    return ArrowExprSyntax(newData)
  }
}

extension ArrowExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAsyncKeyword": unexpectedBeforeAsyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenAsyncKeywordAndThrowsToken": unexpectedBetweenAsyncKeywordAndThrowsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsToken": throwsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenThrowsTokenAndArrowToken": unexpectedBetweenThrowsTokenAndArrowToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrowToken": Syntax(arrowToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - InfixOperatorExprSyntax

public struct InfixOperatorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeLeftOperand
    case leftOperand
    case unexpectedBetweenLeftOperandAndOperatorOperand
    case operatorOperand
    case unexpectedBetweenOperatorOperandAndRightOperand
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
    _ unexpectedBeforeLeftOperand: UnexpectedNodesSyntax? = nil,
    leftOperand: ExprSyntax,
    _ unexpectedBetweenLeftOperandAndOperatorOperand: UnexpectedNodesSyntax? = nil,
    operatorOperand: ExprSyntax,
    _ unexpectedBetweenOperatorOperandAndRightOperand: UnexpectedNodesSyntax? = nil,
    rightOperand: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftOperand?.raw,
      leftOperand.raw,
      unexpectedBetweenLeftOperandAndOperatorOperand?.raw,
      operatorOperand.raw,
      unexpectedBetweenOperatorOperandAndRightOperand?.raw,
      rightOperand.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.infixOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeLeftOperand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeLeftOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftOperand` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftOperand` to replace the node's
  ///                   current `unexpectedBeforeLeftOperand`, if present.
  public func withUnexpectedBeforeLeftOperand(
    _ newChild: UnexpectedNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeLeftOperand)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var unexpectedBetweenLeftOperandAndOperatorOperand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftOperandAndOperatorOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftOperandAndOperatorOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftOperandAndOperatorOperand` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftOperandAndOperatorOperand` to replace the node's
  ///                   current `unexpectedBetweenLeftOperandAndOperatorOperand`, if present.
  public func withUnexpectedBetweenLeftOperandAndOperatorOperand(
    _ newChild: UnexpectedNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftOperandAndOperatorOperand)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.operatorOperand)
    return InfixOperatorExprSyntax(newData)
  }

  public var unexpectedBetweenOperatorOperandAndRightOperand: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOperatorOperandAndRightOperand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOperatorOperandAndRightOperand(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOperatorOperandAndRightOperand` replaced.
  /// - param newChild: The new `unexpectedBetweenOperatorOperandAndRightOperand` to replace the node's
  ///                   current `unexpectedBetweenOperatorOperandAndRightOperand`, if present.
  public func withUnexpectedBetweenOperatorOperandAndRightOperand(
    _ newChild: UnexpectedNodesSyntax?) -> InfixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOperatorOperandAndRightOperand)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightOperand)
    return InfixOperatorExprSyntax(newData)
  }
}

extension InfixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftOperand": unexpectedBeforeLeftOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftOperand": Syntax(leftOperand).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftOperandAndOperatorOperand": unexpectedBetweenLeftOperandAndOperatorOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorOperand": Syntax(operatorOperand).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenOperatorOperandAndRightOperand": unexpectedBetweenOperatorOperandAndRightOperand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightOperand": Syntax(rightOperand).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FloatLiteralExprSyntax

public struct FloatLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeFloatingDigits
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
    _ unexpectedBeforeFloatingDigits: UnexpectedNodesSyntax? = nil,
    floatingDigits: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFloatingDigits?.raw,
      floatingDigits.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.floatLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeFloatingDigits: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeFloatingDigits,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeFloatingDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeFloatingDigits` replaced.
  /// - param newChild: The new `unexpectedBeforeFloatingDigits` to replace the node's
  ///                   current `unexpectedBeforeFloatingDigits`, if present.
  public func withUnexpectedBeforeFloatingDigits(
    _ newChild: UnexpectedNodesSyntax?) -> FloatLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeFloatingDigits)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.floatingLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.floatingDigits)
    return FloatLiteralExprSyntax(newData)
  }
}

extension FloatLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeFloatingDigits": unexpectedBeforeFloatingDigits.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "floatingDigits": Syntax(floatingDigits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TupleExprSyntax

public struct TupleExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndElementList
    case elementList
    case unexpectedBetweenElementListAndRightParen
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
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil,
    elementList: TupleExprElementListSyntax,
    _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeLeftParen,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TupleExprSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndElementList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndElementList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndElementList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndElementList` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndElementList`, if present.
  public func withUnexpectedBetweenLeftParenAndElementList(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndElementList)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.elementList)
    return TupleExprSyntax(newData)
  }

  public var unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenElementListAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenElementListAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenElementListAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenElementListAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenElementListAndRightParen`, if present.
  public func withUnexpectedBetweenElementListAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenElementListAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TupleExprSyntax(newData)
  }
}

extension TupleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftParen": unexpectedBeforeLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndElementList": unexpectedBetweenLeftParenAndElementList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenElementListAndRightParen": unexpectedBetweenElementListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ArrayExprSyntax

public struct ArrayExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeLeftSquare
    case leftSquare
    case unexpectedBetweenLeftSquareAndElements
    case elements
    case unexpectedBetweenElementsAndRightSquare
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
    _ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil,
    leftSquare: TokenSyntax,
    _ unexpectedBetweenLeftSquareAndElements: UnexpectedNodesSyntax? = nil,
    elements: ArrayElementListSyntax,
    _ unexpectedBetweenElementsAndRightSquare: UnexpectedNodesSyntax? = nil,
    rightSquare: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeLeftSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftSquare` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftSquare` to replace the node's
  ///                   current `unexpectedBeforeLeftSquare`, if present.
  public func withUnexpectedBeforeLeftSquare(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeLeftSquare)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return ArrayExprSyntax(newData)
  }

  public var unexpectedBetweenLeftSquareAndElements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftSquareAndElements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftSquareAndElements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftSquareAndElements` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftSquareAndElements` to replace the node's
  ///                   current `unexpectedBetweenLeftSquareAndElements`, if present.
  public func withUnexpectedBetweenLeftSquareAndElements(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftSquareAndElements)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.arrayElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.arrayElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return ArrayExprSyntax(newData)
  }

  public var unexpectedBetweenElementsAndRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenElementsAndRightSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenElementsAndRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenElementsAndRightSquare` replaced.
  /// - param newChild: The new `unexpectedBetweenElementsAndRightSquare` to replace the node's
  ///                   current `unexpectedBetweenElementsAndRightSquare`, if present.
  public func withUnexpectedBetweenElementsAndRightSquare(
    _ newChild: UnexpectedNodesSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenElementsAndRightSquare)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return ArrayExprSyntax(newData)
  }
}

extension ArrayExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftSquare": unexpectedBeforeLeftSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftSquareAndElements": unexpectedBetweenLeftSquareAndElements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenElementsAndRightSquare": unexpectedBetweenElementsAndRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DictionaryExprSyntax

public struct DictionaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeLeftSquare
    case leftSquare
    case unexpectedBetweenLeftSquareAndContent
    case content
    case unexpectedBetweenContentAndRightSquare
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
    _ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil,
    leftSquare: TokenSyntax,
    _ unexpectedBetweenLeftSquareAndContent: UnexpectedNodesSyntax? = nil,
    content: Syntax,
    _ unexpectedBetweenContentAndRightSquare: UnexpectedNodesSyntax? = nil,
    rightSquare: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndContent?.raw,
      content.raw,
      unexpectedBetweenContentAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeLeftSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftSquare` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftSquare` to replace the node's
  ///                   current `unexpectedBeforeLeftSquare`, if present.
  public func withUnexpectedBeforeLeftSquare(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeLeftSquare)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return DictionaryExprSyntax(newData)
  }

  public var unexpectedBetweenLeftSquareAndContent: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftSquareAndContent,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftSquareAndContent(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftSquareAndContent` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftSquareAndContent` to replace the node's
  ///                   current `unexpectedBetweenLeftSquareAndContent`, if present.
  public func withUnexpectedBetweenLeftSquareAndContent(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftSquareAndContent)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.content)
    return DictionaryExprSyntax(newData)
  }

  public var unexpectedBetweenContentAndRightSquare: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenContentAndRightSquare,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenContentAndRightSquare(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenContentAndRightSquare` replaced.
  /// - param newChild: The new `unexpectedBetweenContentAndRightSquare` to replace the node's
  ///                   current `unexpectedBetweenContentAndRightSquare`, if present.
  public func withUnexpectedBetweenContentAndRightSquare(
    _ newChild: UnexpectedNodesSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenContentAndRightSquare)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return DictionaryExprSyntax(newData)
  }
}

extension DictionaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftSquare": unexpectedBeforeLeftSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftSquareAndContent": unexpectedBetweenLeftSquareAndContent.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "content": Syntax(content).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenContentAndRightSquare": unexpectedBetweenContentAndRightSquare.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IntegerLiteralExprSyntax

public struct IntegerLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeDigits
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
    _ unexpectedBeforeDigits: UnexpectedNodesSyntax? = nil,
    digits: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDigits?.raw,
      digits.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.integerLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeDigits: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeDigits,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeDigits(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeDigits` replaced.
  /// - param newChild: The new `unexpectedBeforeDigits` to replace the node's
  ///                   current `unexpectedBeforeDigits`, if present.
  public func withUnexpectedBeforeDigits(
    _ newChild: UnexpectedNodesSyntax?) -> IntegerLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeDigits)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.digits)
    return IntegerLiteralExprSyntax(newData)
  }
}

extension IntegerLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeDigits": unexpectedBeforeDigits.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "digits": Syntax(digits).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BooleanLiteralExprSyntax

public struct BooleanLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeBooleanLiteral
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
    _ unexpectedBeforeBooleanLiteral: UnexpectedNodesSyntax? = nil,
    booleanLiteral: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBooleanLiteral?.raw,
      booleanLiteral.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.booleanLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeBooleanLiteral: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeBooleanLiteral,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBooleanLiteral(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBooleanLiteral` replaced.
  /// - param newChild: The new `unexpectedBeforeBooleanLiteral` to replace the node's
  ///                   current `unexpectedBeforeBooleanLiteral`, if present.
  public func withUnexpectedBeforeBooleanLiteral(
    _ newChild: UnexpectedNodesSyntax?) -> BooleanLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeBooleanLiteral)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.booleanLiteral)
    return BooleanLiteralExprSyntax(newData)
  }
}

extension BooleanLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBooleanLiteral": unexpectedBeforeBooleanLiteral.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "booleanLiteral": Syntax(booleanLiteral).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - UnresolvedTernaryExprSyntax

public struct UnresolvedTernaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeQuestionMark
    case questionMark
    case unexpectedBetweenQuestionMarkAndFirstChoice
    case firstChoice
    case unexpectedBetweenFirstChoiceAndColonMark
    case colonMark
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnresolvedTernaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unresolvedTernaryExpr else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnresolvedTernaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unresolvedTernaryExpr)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ unexpectedBeforeQuestionMark: UnexpectedNodesSyntax? = nil,
    questionMark: TokenSyntax,
    _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil,
    firstChoice: ExprSyntax,
    _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil,
    colonMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionMark?.raw,
      questionMark.raw,
      unexpectedBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      unexpectedBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unresolvedTernaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeQuestionMark` replaced.
  /// - param newChild: The new `unexpectedBeforeQuestionMark` to replace the node's
  ///                   current `unexpectedBeforeQuestionMark`, if present.
  public func withUnexpectedBeforeQuestionMark(
    _ newChild: UnexpectedNodesSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeQuestionMark)
    return UnresolvedTernaryExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.infixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return UnresolvedTernaryExprSyntax(newData)
  }

  public var unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenQuestionMarkAndFirstChoice,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenQuestionMarkAndFirstChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenQuestionMarkAndFirstChoice` replaced.
  /// - param newChild: The new `unexpectedBetweenQuestionMarkAndFirstChoice` to replace the node's
  ///                   current `unexpectedBetweenQuestionMarkAndFirstChoice`, if present.
  public func withUnexpectedBetweenQuestionMarkAndFirstChoice(
    _ newChild: UnexpectedNodesSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenQuestionMarkAndFirstChoice)
    return UnresolvedTernaryExprSyntax(newData)
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
    _ newChild: ExprSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.firstChoice)
    return UnresolvedTernaryExprSyntax(newData)
  }

  public var unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenFirstChoiceAndColonMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFirstChoiceAndColonMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFirstChoiceAndColonMark` replaced.
  /// - param newChild: The new `unexpectedBetweenFirstChoiceAndColonMark` to replace the node's
  ///                   current `unexpectedBetweenFirstChoiceAndColonMark`, if present.
  public func withUnexpectedBetweenFirstChoiceAndColonMark(
    _ newChild: UnexpectedNodesSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenFirstChoiceAndColonMark)
    return UnresolvedTernaryExprSyntax(newData)
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
    _ newChild: TokenSyntax?) -> UnresolvedTernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colonMark)
    return UnresolvedTernaryExprSyntax(newData)
  }
}

extension UnresolvedTernaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeQuestionMark": unexpectedBeforeQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenQuestionMarkAndFirstChoice": unexpectedBetweenQuestionMarkAndFirstChoice.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "firstChoice": Syntax(firstChoice).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFirstChoiceAndColonMark": unexpectedBetweenFirstChoiceAndColonMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colonMark": Syntax(colonMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TernaryExprSyntax

public struct TernaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeConditionExpression
    case conditionExpression
    case unexpectedBetweenConditionExpressionAndQuestionMark
    case questionMark
    case unexpectedBetweenQuestionMarkAndFirstChoice
    case firstChoice
    case unexpectedBetweenFirstChoiceAndColonMark
    case colonMark
    case unexpectedBetweenColonMarkAndSecondChoice
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
    _ unexpectedBeforeConditionExpression: UnexpectedNodesSyntax? = nil,
    conditionExpression: ExprSyntax,
    _ unexpectedBetweenConditionExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil,
    questionMark: TokenSyntax,
    _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil,
    firstChoice: ExprSyntax,
    _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil,
    colonMark: TokenSyntax,
    _ unexpectedBetweenColonMarkAndSecondChoice: UnexpectedNodesSyntax? = nil,
    secondChoice: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeConditionExpression?.raw,
      conditionExpression.raw,
      unexpectedBetweenConditionExpressionAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      unexpectedBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
      unexpectedBetweenColonMarkAndSecondChoice?.raw,
      secondChoice.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ternaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeConditionExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeConditionExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeConditionExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeConditionExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeConditionExpression` to replace the node's
  ///                   current `unexpectedBeforeConditionExpression`, if present.
  public func withUnexpectedBeforeConditionExpression(
    _ newChild: UnexpectedNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeConditionExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.conditionExpression)
    return TernaryExprSyntax(newData)
  }

  public var unexpectedBetweenConditionExpressionAndQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenConditionExpressionAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenConditionExpressionAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenConditionExpressionAndQuestionMark` replaced.
  /// - param newChild: The new `unexpectedBetweenConditionExpressionAndQuestionMark` to replace the node's
  ///                   current `unexpectedBetweenConditionExpressionAndQuestionMark`, if present.
  public func withUnexpectedBetweenConditionExpressionAndQuestionMark(
    _ newChild: UnexpectedNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenConditionExpressionAndQuestionMark)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.infixQuestionMark, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return TernaryExprSyntax(newData)
  }

  public var unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenQuestionMarkAndFirstChoice,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenQuestionMarkAndFirstChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenQuestionMarkAndFirstChoice` replaced.
  /// - param newChild: The new `unexpectedBetweenQuestionMarkAndFirstChoice` to replace the node's
  ///                   current `unexpectedBetweenQuestionMarkAndFirstChoice`, if present.
  public func withUnexpectedBetweenQuestionMarkAndFirstChoice(
    _ newChild: UnexpectedNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenQuestionMarkAndFirstChoice)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.firstChoice)
    return TernaryExprSyntax(newData)
  }

  public var unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenFirstChoiceAndColonMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenFirstChoiceAndColonMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenFirstChoiceAndColonMark` replaced.
  /// - param newChild: The new `unexpectedBetweenFirstChoiceAndColonMark` to replace the node's
  ///                   current `unexpectedBetweenFirstChoiceAndColonMark`, if present.
  public func withUnexpectedBetweenFirstChoiceAndColonMark(
    _ newChild: UnexpectedNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenFirstChoiceAndColonMark)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.colonMark)
    return TernaryExprSyntax(newData)
  }

  public var unexpectedBetweenColonMarkAndSecondChoice: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenColonMarkAndSecondChoice,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonMarkAndSecondChoice(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonMarkAndSecondChoice` replaced.
  /// - param newChild: The new `unexpectedBetweenColonMarkAndSecondChoice` to replace the node's
  ///                   current `unexpectedBetweenColonMarkAndSecondChoice`, if present.
  public func withUnexpectedBetweenColonMarkAndSecondChoice(
    _ newChild: UnexpectedNodesSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenColonMarkAndSecondChoice)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.secondChoice)
    return TernaryExprSyntax(newData)
  }
}

extension TernaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeConditionExpression": unexpectedBeforeConditionExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conditionExpression": Syntax(conditionExpression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenConditionExpressionAndQuestionMark": unexpectedBetweenConditionExpressionAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenQuestionMarkAndFirstChoice": unexpectedBetweenQuestionMarkAndFirstChoice.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "firstChoice": Syntax(firstChoice).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenFirstChoiceAndColonMark": unexpectedBetweenFirstChoiceAndColonMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colonMark": Syntax(colonMark).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenColonMarkAndSecondChoice": unexpectedBetweenColonMarkAndSecondChoice.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondChoice": Syntax(secondChoice).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MemberAccessExprSyntax

public struct MemberAccessExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeBase
    case base
    case unexpectedBetweenBaseAndDot
    case dot
    case unexpectedBetweenDotAndName
    case name
    case unexpectedBetweenNameAndDeclNameArguments
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
    _ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil,
    base: ExprSyntax?,
    _ unexpectedBetweenBaseAndDot: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax,
    _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndDot?.raw,
      dot.raw,
      unexpectedBetweenDotAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberAccessExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeBase: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeBase,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBase(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBase` replaced.
  /// - param newChild: The new `unexpectedBeforeBase` to replace the node's
  ///                   current `unexpectedBeforeBase`, if present.
  public func withUnexpectedBeforeBase(
    _ newChild: UnexpectedNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeBase)
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

  public var unexpectedBetweenBaseAndDot: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenBaseAndDot,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBaseAndDot(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBaseAndDot` replaced.
  /// - param newChild: The new `unexpectedBetweenBaseAndDot` to replace the node's
  ///                   current `unexpectedBetweenBaseAndDot`, if present.
  public func withUnexpectedBetweenBaseAndDot(
    _ newChild: UnexpectedNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenBaseAndDot)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.dot)
    return MemberAccessExprSyntax(newData)
  }

  public var unexpectedBetweenDotAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenDotAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenDotAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenDotAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenDotAndName` to replace the node's
  ///                   current `unexpectedBetweenDotAndName`, if present.
  public func withUnexpectedBetweenDotAndName(
    _ newChild: UnexpectedNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenDotAndName)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return MemberAccessExprSyntax(newData)
  }

  public var unexpectedBetweenNameAndDeclNameArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenNameAndDeclNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndDeclNameArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndDeclNameArguments` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndDeclNameArguments` to replace the node's
  ///                   current `unexpectedBetweenNameAndDeclNameArguments`, if present.
  public func withUnexpectedBetweenNameAndDeclNameArguments(
    _ newChild: UnexpectedNodesSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenNameAndDeclNameArguments)
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
}

extension MemberAccessExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBase": unexpectedBeforeBase.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenBaseAndDot": unexpectedBetweenBaseAndDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": Syntax(dot).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenDotAndName": unexpectedBetweenDotAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndDeclNameArguments": unexpectedBetweenNameAndDeclNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsExprSyntax

public struct IsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeIsTok
    case isTok
    case unexpectedBetweenIsTokAndTypeName
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
    _ unexpectedBeforeIsTok: UnexpectedNodesSyntax? = nil,
    isTok: TokenSyntax,
    _ unexpectedBetweenIsTokAndTypeName: UnexpectedNodesSyntax? = nil,
    typeName: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsTok?.raw,
      isTok.raw,
      unexpectedBetweenIsTokAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.isExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeIsTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeIsTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIsTok` replaced.
  /// - param newChild: The new `unexpectedBeforeIsTok` to replace the node's
  ///                   current `unexpectedBeforeIsTok`, if present.
  public func withUnexpectedBeforeIsTok(
    _ newChild: UnexpectedNodesSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeIsTok)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.isTok)
    return IsExprSyntax(newData)
  }

  public var unexpectedBetweenIsTokAndTypeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIsTokAndTypeName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIsTokAndTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIsTokAndTypeName` replaced.
  /// - param newChild: The new `unexpectedBetweenIsTokAndTypeName` to replace the node's
  ///                   current `unexpectedBetweenIsTokAndTypeName`, if present.
  public func withUnexpectedBetweenIsTokAndTypeName(
    _ newChild: UnexpectedNodesSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIsTokAndTypeName)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return IsExprSyntax(newData)
  }
}

extension IsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIsTok": unexpectedBeforeIsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "isTok": Syntax(isTok).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIsTokAndTypeName": unexpectedBetweenIsTokAndTypeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AsExprSyntax

public struct AsExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeAsTok
    case asTok
    case unexpectedBetweenAsTokAndQuestionOrExclamationMark
    case questionOrExclamationMark
    case unexpectedBetweenQuestionOrExclamationMarkAndTypeName
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
    _ unexpectedBeforeAsTok: UnexpectedNodesSyntax? = nil,
    asTok: TokenSyntax,
    _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: TokenSyntax?,
    _ unexpectedBetweenQuestionOrExclamationMarkAndTypeName: UnexpectedNodesSyntax? = nil,
    typeName: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsTok?.raw,
      asTok.raw,
      unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.asExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeAsTok: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeAsTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeAsTok(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeAsTok` replaced.
  /// - param newChild: The new `unexpectedBeforeAsTok` to replace the node's
  ///                   current `unexpectedBeforeAsTok`, if present.
  public func withUnexpectedBeforeAsTok(
    _ newChild: UnexpectedNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeAsTok)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.asTok)
    return AsExprSyntax(newData)
  }

  public var unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenAsTokAndQuestionOrExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsTokAndQuestionOrExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsTokAndQuestionOrExclamationMark` replaced.
  /// - param newChild: The new `unexpectedBetweenAsTokAndQuestionOrExclamationMark` to replace the node's
  ///                   current `unexpectedBetweenAsTokAndQuestionOrExclamationMark`, if present.
  public func withUnexpectedBetweenAsTokAndQuestionOrExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenAsTokAndQuestionOrExclamationMark)
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

  public var unexpectedBetweenQuestionOrExclamationMarkAndTypeName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenQuestionOrExclamationMarkAndTypeName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenQuestionOrExclamationMarkAndTypeName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenQuestionOrExclamationMarkAndTypeName` replaced.
  /// - param newChild: The new `unexpectedBetweenQuestionOrExclamationMarkAndTypeName` to replace the node's
  ///                   current `unexpectedBetweenQuestionOrExclamationMarkAndTypeName`, if present.
  public func withUnexpectedBetweenQuestionOrExclamationMarkAndTypeName(
    _ newChild: UnexpectedNodesSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenQuestionOrExclamationMarkAndTypeName)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return AsExprSyntax(newData)
  }
}

extension AsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeAsTok": unexpectedBeforeAsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asTok": Syntax(asTok).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAsTokAndQuestionOrExclamationMark": unexpectedBetweenAsTokAndQuestionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenQuestionOrExclamationMarkAndTypeName": unexpectedBetweenQuestionOrExclamationMarkAndTypeName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TypeExprSyntax

public struct TypeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeType
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
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: TypeSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeType` replaced.
  /// - param newChild: The new `unexpectedBeforeType` to replace the node's
  ///                   current `unexpectedBeforeType`, if present.
  public func withUnexpectedBeforeType(
    _ newChild: UnexpectedNodesSyntax?) -> TypeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeType)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TypeExprSyntax(newData)
  }
}

extension TypeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeType": unexpectedBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ClosureExprSyntax

public struct ClosureExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeLeftBrace
    case leftBrace
    case unexpectedBetweenLeftBraceAndSignature
    case signature
    case unexpectedBetweenSignatureAndStatements
    case statements
    case unexpectedBetweenStatementsAndRightBrace
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
    _ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ unexpectedBetweenLeftBraceAndSignature: UnexpectedNodesSyntax? = nil,
    signature: ClosureSignatureSyntax?,
    _ unexpectedBetweenSignatureAndStatements: UnexpectedNodesSyntax? = nil,
    statements: CodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil,
    rightBrace: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndSignature?.raw,
      signature?.raw,
      unexpectedBetweenSignatureAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeLeftBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLeftBrace` replaced.
  /// - param newChild: The new `unexpectedBeforeLeftBrace` to replace the node's
  ///                   current `unexpectedBeforeLeftBrace`, if present.
  public func withUnexpectedBeforeLeftBrace(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeLeftBrace)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return ClosureExprSyntax(newData)
  }

  public var unexpectedBetweenLeftBraceAndSignature: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftBraceAndSignature,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBraceAndSignature(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBraceAndSignature` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBraceAndSignature` to replace the node's
  ///                   current `unexpectedBetweenLeftBraceAndSignature`, if present.
  public func withUnexpectedBetweenLeftBraceAndSignature(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftBraceAndSignature)
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

  public var unexpectedBetweenSignatureAndStatements: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenSignatureAndStatements,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSignatureAndStatements(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSignatureAndStatements` replaced.
  /// - param newChild: The new `unexpectedBetweenSignatureAndStatements` to replace the node's
  ///                   current `unexpectedBetweenSignatureAndStatements`, if present.
  public func withUnexpectedBetweenSignatureAndStatements(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenSignatureAndStatements)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return ClosureExprSyntax(newData)
  }

  public var unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenStatementsAndRightBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenStatementsAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenStatementsAndRightBrace` replaced.
  /// - param newChild: The new `unexpectedBetweenStatementsAndRightBrace` to replace the node's
  ///                   current `unexpectedBetweenStatementsAndRightBrace`, if present.
  public func withUnexpectedBetweenStatementsAndRightBrace(
    _ newChild: UnexpectedNodesSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenStatementsAndRightBrace)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return ClosureExprSyntax(newData)
  }
}

extension ClosureExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLeftBrace": unexpectedBeforeLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBraceAndSignature": unexpectedBetweenLeftBraceAndSignature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "signature": signature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenSignatureAndStatements": unexpectedBetweenSignatureAndStatements.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenStatementsAndRightBrace": unexpectedBetweenStatementsAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - UnresolvedPatternExprSyntax

public struct UnresolvedPatternExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePattern
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
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: PatternSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedPatternExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePattern` replaced.
  /// - param newChild: The new `unexpectedBeforePattern` to replace the node's
  ///                   current `unexpectedBeforePattern`, if present.
  public func withUnexpectedBeforePattern(
    _ newChild: UnexpectedNodesSyntax?) -> UnresolvedPatternExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePattern)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return UnresolvedPatternExprSyntax(newData)
  }
}

extension UnresolvedPatternExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePattern": unexpectedBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionCallExprSyntax

public struct FunctionCallExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeCalledExpression
    case calledExpression
    case unexpectedBetweenCalledExpressionAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndArgumentList
    case argumentList
    case unexpectedBetweenArgumentListAndRightParen
    case rightParen
    case unexpectedBetweenRightParenAndTrailingClosure
    case trailingClosure
    case unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures
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
    _ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntax,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax?,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCalledExpression?.raw,
      calledExpression.raw,
      unexpectedBetweenCalledExpressionAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionCallExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeCalledExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCalledExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeCalledExpression` to replace the node's
  ///                   current `unexpectedBeforeCalledExpression`, if present.
  public func withUnexpectedBeforeCalledExpression(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeCalledExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return FunctionCallExprSyntax(newData)
  }

  public var unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenCalledExpressionAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCalledExpressionAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCalledExpressionAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenCalledExpressionAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenCalledExpressionAndLeftParen`, if present.
  public func withUnexpectedBetweenCalledExpressionAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenCalledExpressionAndLeftParen)
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

  public var unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndArgumentList,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenLeftParenAndArgumentList(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndArgumentList)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return FunctionCallExprSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenArgumentListAndRightParen,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenArgumentListAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenArgumentListAndRightParen)
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

  public var unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenRightParenAndTrailingClosure,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenRightParenAndTrailingClosure(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenRightParenAndTrailingClosure)
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

  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenTrailingClosureAndAdditionalTrailingClosures(
    _ newChild: UnexpectedNodesSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
        from: [element.raw], arena: .default)
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
}

extension FunctionCallExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCalledExpression": unexpectedBeforeCalledExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCalledExpressionAndLeftParen": unexpectedBetweenCalledExpressionAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenLeftParenAndArgumentList": unexpectedBetweenLeftParenAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentListAndRightParen": unexpectedBetweenArgumentListAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenRightParenAndTrailingClosure": unexpectedBetweenRightParenAndTrailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures": unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptExprSyntax

public struct SubscriptExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeCalledExpression
    case calledExpression
    case unexpectedBetweenCalledExpressionAndLeftBracket
    case leftBracket
    case unexpectedBetweenLeftBracketAndArgumentList
    case argumentList
    case unexpectedBetweenArgumentListAndRightBracket
    case rightBracket
    case unexpectedBetweenRightBracketAndTrailingClosure
    case trailingClosure
    case unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures
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
    _ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntax,
    _ unexpectedBetweenCalledExpressionAndLeftBracket: UnexpectedNodesSyntax? = nil,
    leftBracket: TokenSyntax,
    _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil,
    rightBracket: TokenSyntax,
    _ unexpectedBetweenRightBracketAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax?,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCalledExpression?.raw,
      calledExpression.raw,
      unexpectedBetweenCalledExpressionAndLeftBracket?.raw,
      leftBracket.raw,
      unexpectedBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      unexpectedBetweenRightBracketAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeCalledExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeCalledExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeCalledExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeCalledExpression` to replace the node's
  ///                   current `unexpectedBeforeCalledExpression`, if present.
  public func withUnexpectedBeforeCalledExpression(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeCalledExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return SubscriptExprSyntax(newData)
  }

  public var unexpectedBetweenCalledExpressionAndLeftBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenCalledExpressionAndLeftBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCalledExpressionAndLeftBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCalledExpressionAndLeftBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenCalledExpressionAndLeftBracket` to replace the node's
  ///                   current `unexpectedBetweenCalledExpressionAndLeftBracket`, if present.
  public func withUnexpectedBetweenCalledExpressionAndLeftBracket(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenCalledExpressionAndLeftBracket)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftBracket)
    return SubscriptExprSyntax(newData)
  }

  public var unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftBracketAndArgumentList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftBracketAndArgumentList(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftBracketAndArgumentList` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftBracketAndArgumentList` to replace the node's
  ///                   current `unexpectedBetweenLeftBracketAndArgumentList`, if present.
  public func withUnexpectedBetweenLeftBracketAndArgumentList(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftBracketAndArgumentList)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return SubscriptExprSyntax(newData)
  }

  public var unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenArgumentListAndRightBracket,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenArgumentListAndRightBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenArgumentListAndRightBracket` replaced.
  /// - param newChild: The new `unexpectedBetweenArgumentListAndRightBracket` to replace the node's
  ///                   current `unexpectedBetweenArgumentListAndRightBracket`, if present.
  public func withUnexpectedBetweenArgumentListAndRightBracket(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenArgumentListAndRightBracket)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightBracket)
    return SubscriptExprSyntax(newData)
  }

  public var unexpectedBetweenRightBracketAndTrailingClosure: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenRightBracketAndTrailingClosure,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRightBracketAndTrailingClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRightBracketAndTrailingClosure` replaced.
  /// - param newChild: The new `unexpectedBetweenRightBracketAndTrailingClosure` to replace the node's
  ///                   current `unexpectedBetweenRightBracketAndTrailingClosure`, if present.
  public func withUnexpectedBetweenRightBracketAndTrailingClosure(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenRightBracketAndTrailingClosure)
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

  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
                                 parent: Syntax(self))
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
  public func withUnexpectedBetweenTrailingClosureAndAdditionalTrailingClosures(
    _ newChild: UnexpectedNodesSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
        from: [element.raw], arena: .default)
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
}

extension SubscriptExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeCalledExpression": unexpectedBeforeCalledExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCalledExpressionAndLeftBracket": unexpectedBetweenCalledExpressionAndLeftBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBracket": Syntax(leftBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftBracketAndArgumentList": unexpectedBetweenLeftBracketAndArgumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentListAndRightBracket": unexpectedBetweenArgumentListAndRightBracket.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBracket": Syntax(rightBracket).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenRightBracketAndTrailingClosure": unexpectedBetweenRightBracketAndTrailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures": unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalChainingExprSyntax

public struct OptionalChainingExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeExpression
    case expression
    case unexpectedBetweenExpressionAndQuestionMark
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
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil,
    questionMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalChainingExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return OptionalChainingExprSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExpressionAndQuestionMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndQuestionMark` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndQuestionMark` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndQuestionMark`, if present.
  public func withUnexpectedBetweenExpressionAndQuestionMark(
    _ newChild: UnexpectedNodesSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExpressionAndQuestionMark)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalChainingExprSyntax(newData)
  }
}

extension OptionalChainingExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndQuestionMark": unexpectedBetweenExpressionAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ForcedValueExprSyntax

public struct ForcedValueExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeExpression
    case expression
    case unexpectedBetweenExpressionAndExclamationMark
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
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndExclamationMark: UnexpectedNodesSyntax? = nil,
    exclamationMark: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.forcedValueExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ForcedValueExprSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndExclamationMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExpressionAndExclamationMark,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndExclamationMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndExclamationMark` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndExclamationMark` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndExclamationMark`, if present.
  public func withUnexpectedBetweenExpressionAndExclamationMark(
    _ newChild: UnexpectedNodesSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExpressionAndExclamationMark)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.exclamationMark)
    return ForcedValueExprSyntax(newData)
  }
}

extension ForcedValueExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndExclamationMark": unexpectedBetweenExpressionAndExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixUnaryExprSyntax

public struct PostfixUnaryExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeExpression
    case expression
    case unexpectedBetweenExpressionAndOperatorToken
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
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndOperatorToken: UnexpectedNodesSyntax? = nil,
    operatorToken: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixUnaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return PostfixUnaryExprSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndOperatorToken: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExpressionAndOperatorToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndOperatorToken(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndOperatorToken` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndOperatorToken` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndOperatorToken`, if present.
  public func withUnexpectedBetweenExpressionAndOperatorToken(
    _ newChild: UnexpectedNodesSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExpressionAndOperatorToken)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.postfixOperator(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return PostfixUnaryExprSyntax(newData)
  }
}

extension PostfixUnaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndOperatorToken": unexpectedBetweenExpressionAndOperatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SpecializeExprSyntax

public struct SpecializeExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeExpression
    case expression
    case unexpectedBetweenExpressionAndGenericArgumentClause
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
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax,
    _ unexpectedBetweenExpressionAndGenericArgumentClause: UnexpectedNodesSyntax? = nil,
    genericArgumentClause: GenericArgumentClauseSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndGenericArgumentClause?.raw,
      genericArgumentClause.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeExpression` replaced.
  /// - param newChild: The new `unexpectedBeforeExpression` to replace the node's
  ///                   current `unexpectedBeforeExpression`, if present.
  public func withUnexpectedBeforeExpression(
    _ newChild: UnexpectedNodesSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return SpecializeExprSyntax(newData)
  }

  public var unexpectedBetweenExpressionAndGenericArgumentClause: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenExpressionAndGenericArgumentClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenExpressionAndGenericArgumentClause(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenExpressionAndGenericArgumentClause` replaced.
  /// - param newChild: The new `unexpectedBetweenExpressionAndGenericArgumentClause` to replace the node's
  ///                   current `unexpectedBetweenExpressionAndGenericArgumentClause`, if present.
  public func withUnexpectedBetweenExpressionAndGenericArgumentClause(
    _ newChild: UnexpectedNodesSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenExpressionAndGenericArgumentClause)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentClause, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SpecializeExprSyntax(newData)
  }
}

extension SpecializeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenExpressionAndGenericArgumentClause": unexpectedBetweenExpressionAndGenericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": Syntax(genericArgumentClause).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - StringLiteralExprSyntax

public struct StringLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeOpenDelimiter
    case openDelimiter
    case unexpectedBetweenOpenDelimiterAndOpenQuote
    case openQuote
    case unexpectedBetweenOpenQuoteAndSegments
    case segments
    case unexpectedBetweenSegmentsAndCloseQuote
    case closeQuote
    case unexpectedBetweenCloseQuoteAndCloseDelimiter
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
    _ unexpectedBeforeOpenDelimiter: UnexpectedNodesSyntax? = nil,
    openDelimiter: TokenSyntax?,
    _ unexpectedBetweenOpenDelimiterAndOpenQuote: UnexpectedNodesSyntax? = nil,
    openQuote: TokenSyntax,
    _ unexpectedBetweenOpenQuoteAndSegments: UnexpectedNodesSyntax? = nil,
    segments: StringLiteralSegmentsSyntax,
    _ unexpectedBetweenSegmentsAndCloseQuote: UnexpectedNodesSyntax? = nil,
    closeQuote: TokenSyntax,
    _ unexpectedBetweenCloseQuoteAndCloseDelimiter: UnexpectedNodesSyntax? = nil,
    closeDelimiter: TokenSyntax?
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOpenDelimiter?.raw,
      openDelimiter?.raw,
      unexpectedBetweenOpenDelimiterAndOpenQuote?.raw,
      openQuote.raw,
      unexpectedBetweenOpenQuoteAndSegments?.raw,
      segments.raw,
      unexpectedBetweenSegmentsAndCloseQuote?.raw,
      closeQuote.raw,
      unexpectedBetweenCloseQuoteAndCloseDelimiter?.raw,
      closeDelimiter?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeOpenDelimiter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeOpenDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeOpenDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeOpenDelimiter` replaced.
  /// - param newChild: The new `unexpectedBeforeOpenDelimiter` to replace the node's
  ///                   current `unexpectedBeforeOpenDelimiter`, if present.
  public func withUnexpectedBeforeOpenDelimiter(
    _ newChild: UnexpectedNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeOpenDelimiter)
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

  public var unexpectedBetweenOpenDelimiterAndOpenQuote: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOpenDelimiterAndOpenQuote,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOpenDelimiterAndOpenQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOpenDelimiterAndOpenQuote` replaced.
  /// - param newChild: The new `unexpectedBetweenOpenDelimiterAndOpenQuote` to replace the node's
  ///                   current `unexpectedBetweenOpenDelimiterAndOpenQuote`, if present.
  public func withUnexpectedBetweenOpenDelimiterAndOpenQuote(
    _ newChild: UnexpectedNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOpenDelimiterAndOpenQuote)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.openQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenOpenQuoteAndSegments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenOpenQuoteAndSegments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenOpenQuoteAndSegments(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenOpenQuoteAndSegments` replaced.
  /// - param newChild: The new `unexpectedBetweenOpenQuoteAndSegments` to replace the node's
  ///                   current `unexpectedBetweenOpenQuoteAndSegments`, if present.
  public func withUnexpectedBetweenOpenQuoteAndSegments(
    _ newChild: UnexpectedNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenOpenQuoteAndSegments)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralSegments,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralSegments, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.segments)
    return StringLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenSegmentsAndCloseQuote: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenSegmentsAndCloseQuote,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSegmentsAndCloseQuote(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSegmentsAndCloseQuote` replaced.
  /// - param newChild: The new `unexpectedBetweenSegmentsAndCloseQuote` to replace the node's
  ///                   current `unexpectedBetweenSegmentsAndCloseQuote`, if present.
  public func withUnexpectedBetweenSegmentsAndCloseQuote(
    _ newChild: UnexpectedNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenSegmentsAndCloseQuote)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.closeQuote)
    return StringLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenCloseQuoteAndCloseDelimiter: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenCloseQuoteAndCloseDelimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCloseQuoteAndCloseDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCloseQuoteAndCloseDelimiter` replaced.
  /// - param newChild: The new `unexpectedBetweenCloseQuoteAndCloseDelimiter` to replace the node's
  ///                   current `unexpectedBetweenCloseQuoteAndCloseDelimiter`, if present.
  public func withUnexpectedBetweenCloseQuoteAndCloseDelimiter(
    _ newChild: UnexpectedNodesSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenCloseQuoteAndCloseDelimiter)
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
}

extension StringLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeOpenDelimiter": unexpectedBeforeOpenDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openDelimiter": openDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenOpenDelimiterAndOpenQuote": unexpectedBetweenOpenDelimiterAndOpenQuote.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openQuote": Syntax(openQuote).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenOpenQuoteAndSegments": unexpectedBetweenOpenQuoteAndSegments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "segments": Syntax(segments).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSegmentsAndCloseQuote": unexpectedBetweenSegmentsAndCloseQuote.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "closeQuote": Syntax(closeQuote).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCloseQuoteAndCloseDelimiter": unexpectedBetweenCloseQuoteAndCloseDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "closeDelimiter": closeDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - RegexLiteralExprSyntax

public struct RegexLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeRegex
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
    _ unexpectedBeforeRegex: UnexpectedNodesSyntax? = nil,
    regex: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeRegex?.raw,
      regex.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.regexLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeRegex: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeRegex,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeRegex(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeRegex` replaced.
  /// - param newChild: The new `unexpectedBeforeRegex` to replace the node's
  ///                   current `unexpectedBeforeRegex`, if present.
  public func withUnexpectedBeforeRegex(
    _ newChild: UnexpectedNodesSyntax?) -> RegexLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeRegex)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.regexLiteral(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.regex)
    return RegexLiteralExprSyntax(newData)
  }
}

extension RegexLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeRegex": unexpectedBeforeRegex.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "regex": Syntax(regex).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathExprSyntax

public struct KeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeBackslash
    case backslash
    case unexpectedBetweenBackslashAndRootExpr
    case rootExpr
    case unexpectedBetweenRootExprAndExpression
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
    _ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil,
    backslash: TokenSyntax,
    _ unexpectedBetweenBackslashAndRootExpr: UnexpectedNodesSyntax? = nil,
    rootExpr: ExprSyntax?,
    _ unexpectedBetweenRootExprAndExpression: UnexpectedNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBackslash?.raw,
      backslash.raw,
      unexpectedBetweenBackslashAndRootExpr?.raw,
      rootExpr?.raw,
      unexpectedBetweenRootExprAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeBackslash: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeBackslash,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBackslash(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBackslash` replaced.
  /// - param newChild: The new `unexpectedBeforeBackslash` to replace the node's
  ///                   current `unexpectedBeforeBackslash`, if present.
  public func withUnexpectedBeforeBackslash(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeBackslash)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.backslash)
    return KeyPathExprSyntax(newData)
  }

  public var unexpectedBetweenBackslashAndRootExpr: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenBackslashAndRootExpr,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBackslashAndRootExpr(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBackslashAndRootExpr` replaced.
  /// - param newChild: The new `unexpectedBetweenBackslashAndRootExpr` to replace the node's
  ///                   current `unexpectedBetweenBackslashAndRootExpr`, if present.
  public func withUnexpectedBetweenBackslashAndRootExpr(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenBackslashAndRootExpr)
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

  public var unexpectedBetweenRootExprAndExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenRootExprAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenRootExprAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenRootExprAndExpression` replaced.
  /// - param newChild: The new `unexpectedBetweenRootExprAndExpression` to replace the node's
  ///                   current `unexpectedBetweenRootExprAndExpression`, if present.
  public func withUnexpectedBetweenRootExprAndExpression(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenRootExprAndExpression)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return KeyPathExprSyntax(newData)
  }
}

extension KeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBackslash": unexpectedBeforeBackslash.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenBackslashAndRootExpr": unexpectedBetweenBackslashAndRootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rootExpr": rootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenRootExprAndExpression": unexpectedBetweenRootExprAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - KeyPathBaseExprSyntax

public struct KeyPathBaseExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePeriod
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
    _ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePeriod?.raw,
      period.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathBaseExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePeriod` replaced.
  /// - param newChild: The new `unexpectedBeforePeriod` to replace the node's
  ///                   current `unexpectedBeforePeriod`, if present.
  public func withUnexpectedBeforePeriod(
    _ newChild: UnexpectedNodesSyntax?) -> KeyPathBaseExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePeriod)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return KeyPathBaseExprSyntax(newData)
  }
}

extension KeyPathBaseExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePeriod": unexpectedBeforePeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcKeyPathExprSyntax

public struct ObjcKeyPathExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeKeyPath
    case keyPath
    case unexpectedBetweenKeyPathAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndName
    case name
    case unexpectedBetweenNameAndRightParen
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
    _ unexpectedBeforeKeyPath: UnexpectedNodesSyntax? = nil,
    keyPath: TokenSyntax,
    _ unexpectedBetweenKeyPathAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil,
    name: ObjcNameSyntax,
    _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeKeyPath?.raw,
      keyPath.raw,
      unexpectedBetweenKeyPathAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcKeyPathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeKeyPath: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeKeyPath,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeKeyPath(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeKeyPath` replaced.
  /// - param newChild: The new `unexpectedBeforeKeyPath` to replace the node's
  ///                   current `unexpectedBeforeKeyPath`, if present.
  public func withUnexpectedBeforeKeyPath(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeKeyPath)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundKeyPathKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.keyPath)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var unexpectedBetweenKeyPathAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenKeyPathAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenKeyPathAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenKeyPathAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenKeyPathAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenKeyPathAndLeftParen`, if present.
  public func withUnexpectedBetweenKeyPathAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenKeyPathAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndName` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndName`, if present.
  public func withUnexpectedBetweenLeftParenAndName(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndName)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.objcName,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.objcName, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcKeyPathExprSyntax(newData)
  }

  public var unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenNameAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenNameAndRightParen`, if present.
  public func withUnexpectedBetweenNameAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenNameAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcKeyPathExprSyntax(newData)
  }
}

extension ObjcKeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeKeyPath": unexpectedBeforeKeyPath.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "keyPath": Syntax(keyPath).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenKeyPathAndLeftParen": unexpectedBetweenKeyPathAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndName": unexpectedBetweenLeftParenAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndRightParen": unexpectedBetweenNameAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcSelectorExprSyntax

public struct ObjcSelectorExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforePoundSelector
    case poundSelector
    case unexpectedBetweenPoundSelectorAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndKind
    case kind
    case unexpectedBetweenKindAndColon
    case colon
    case unexpectedBetweenColonAndName
    case name
    case unexpectedBetweenNameAndRightParen
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
    _ unexpectedBeforePoundSelector: UnexpectedNodesSyntax? = nil,
    poundSelector: TokenSyntax,
    _ unexpectedBetweenPoundSelectorAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndKind: UnexpectedNodesSyntax? = nil,
    kind: TokenSyntax?,
    _ unexpectedBetweenKindAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax?,
    _ unexpectedBetweenColonAndName: UnexpectedNodesSyntax? = nil,
    name: ExprSyntax,
    _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundSelector?.raw,
      poundSelector.raw,
      unexpectedBetweenPoundSelectorAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndKind?.raw,
      kind?.raw,
      unexpectedBetweenKindAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcSelectorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforePoundSelector: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforePoundSelector,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforePoundSelector(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforePoundSelector` replaced.
  /// - param newChild: The new `unexpectedBeforePoundSelector` to replace the node's
  ///                   current `unexpectedBeforePoundSelector`, if present.
  public func withUnexpectedBeforePoundSelector(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforePoundSelector)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundSelectorKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.poundSelector)
    return ObjcSelectorExprSyntax(newData)
  }

  public var unexpectedBetweenPoundSelectorAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenPoundSelectorAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPoundSelectorAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPoundSelectorAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenPoundSelectorAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenPoundSelectorAndLeftParen`, if present.
  public func withUnexpectedBetweenPoundSelectorAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenPoundSelectorAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcSelectorExprSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndKind: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLeftParenAndKind(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLeftParenAndKind` replaced.
  /// - param newChild: The new `unexpectedBetweenLeftParenAndKind` to replace the node's
  ///                   current `unexpectedBetweenLeftParenAndKind`, if present.
  public func withUnexpectedBetweenLeftParenAndKind(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndKind)
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

  public var unexpectedBetweenKindAndColon: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenKindAndColon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenKindAndColon(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenKindAndColon` replaced.
  /// - param newChild: The new `unexpectedBetweenKindAndColon` to replace the node's
  ///                   current `unexpectedBetweenKindAndColon`, if present.
  public func withUnexpectedBetweenKindAndColon(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenKindAndColon)
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

  public var unexpectedBetweenColonAndName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenColonAndName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenColonAndName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenColonAndName` replaced.
  /// - param newChild: The new `unexpectedBetweenColonAndName` to replace the node's
  ///                   current `unexpectedBetweenColonAndName`, if present.
  public func withUnexpectedBetweenColonAndName(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenColonAndName)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcSelectorExprSyntax(newData)
  }

  public var unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenNameAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenNameAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenNameAndRightParen` replaced.
  /// - param newChild: The new `unexpectedBetweenNameAndRightParen` to replace the node's
  ///                   current `unexpectedBetweenNameAndRightParen`, if present.
  public func withUnexpectedBetweenNameAndRightParen(
    _ newChild: UnexpectedNodesSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenNameAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcSelectorExprSyntax(newData)
  }
}

extension ObjcSelectorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePoundSelector": unexpectedBeforePoundSelector.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundSelector": Syntax(poundSelector).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPoundSelectorAndLeftParen": unexpectedBetweenPoundSelectorAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndKind": unexpectedBetweenLeftParenAndKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "kind": kind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenKindAndColon": unexpectedBetweenKindAndColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenColonAndName": unexpectedBetweenColonAndName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenNameAndRightParen": unexpectedBetweenNameAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PostfixIfConfigExprSyntax

public struct PostfixIfConfigExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeBase
    case base
    case unexpectedBetweenBaseAndConfig
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
    _ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil,
    base: ExprSyntax?,
    _ unexpectedBetweenBaseAndConfig: UnexpectedNodesSyntax? = nil,
    config: IfConfigDeclSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndConfig?.raw,
      config.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixIfConfigExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeBase: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeBase,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeBase(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeBase` replaced.
  /// - param newChild: The new `unexpectedBeforeBase` to replace the node's
  ///                   current `unexpectedBeforeBase`, if present.
  public func withUnexpectedBeforeBase(
    _ newChild: UnexpectedNodesSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeBase)
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

  public var unexpectedBetweenBaseAndConfig: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenBaseAndConfig,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenBaseAndConfig(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenBaseAndConfig` replaced.
  /// - param newChild: The new `unexpectedBetweenBaseAndConfig` to replace the node's
  ///                   current `unexpectedBetweenBaseAndConfig`, if present.
  public func withUnexpectedBetweenBaseAndConfig(
    _ newChild: UnexpectedNodesSyntax?) -> PostfixIfConfigExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenBaseAndConfig)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigDecl, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.config)
    return PostfixIfConfigExprSyntax(newData)
  }
}

extension PostfixIfConfigExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeBase": unexpectedBeforeBase.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenBaseAndConfig": unexpectedBetweenBaseAndConfig.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "config": Syntax(config).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - EditorPlaceholderExprSyntax

public struct EditorPlaceholderExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeIdentifier
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
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.editorPlaceholderExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> EditorPlaceholderExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EditorPlaceholderExprSyntax(newData)
  }
}

extension EditorPlaceholderExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjectLiteralExprSyntax

public struct ObjectLiteralExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unexpectedBeforeIdentifier
    case identifier
    case unexpectedBetweenIdentifierAndLeftParen
    case leftParen
    case unexpectedBetweenLeftParenAndArguments
    case arguments
    case unexpectedBetweenArgumentsAndRightParen
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
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: TupleExprElementListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objectLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBeforeIdentifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIdentifier` replaced.
  /// - param newChild: The new `unexpectedBeforeIdentifier` to replace the node's
  ///                   current `unexpectedBeforeIdentifier`, if present.
  public func withUnexpectedBeforeIdentifier(
    _ newChild: UnexpectedNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBeforeIdentifier)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.poundColorLiteralKeyword, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ObjectLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenIdentifierAndLeftParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenIdentifierAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIdentifierAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIdentifierAndLeftParen` replaced.
  /// - param newChild: The new `unexpectedBetweenIdentifierAndLeftParen` to replace the node's
  ///                   current `unexpectedBetweenIdentifierAndLeftParen`, if present.
  public func withUnexpectedBetweenIdentifierAndLeftParen(
    _ newChild: UnexpectedNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenIdentifierAndLeftParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjectLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenLeftParenAndArguments,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenLeftParenAndArguments)
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
      collection = col.layoutView.appending(element.raw, arena: .default)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: [element.raw], arena: .default)
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
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return ObjectLiteralExprSyntax(newData)
  }

  public var unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.unexpectedBetweenArgumentsAndRightParen,
                                 parent: Syntax(self))
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
    _ newChild: UnexpectedNodesSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unexpectedBetweenArgumentsAndRightParen)
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
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjectLiteralExprSyntax(newData)
  }
}

extension ObjectLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIdentifierAndLeftParen": unexpectedBetweenIdentifierAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLeftParenAndArguments": unexpectedBetweenLeftParenAndArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenArgumentsAndRightParen": unexpectedBetweenArgumentsAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

