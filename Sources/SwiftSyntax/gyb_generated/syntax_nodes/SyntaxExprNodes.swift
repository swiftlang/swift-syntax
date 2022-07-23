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

public struct UnknownExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnknownExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnknownExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnknownExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnknownExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

extension UnknownExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - InOutExprSyntax

public struct InOutExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case ampersand
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawInOutExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `InOutExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `InOutExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `InOutExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var ampersand: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ampersand.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAmpersand(value)
    }
  }
  public func withAmpersand(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .prefixAmpersand).raw

    let newRaw = raw.replacingChild(
      at: Cursor.ampersand.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension InOutExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ampersand": Syntax(ampersand).asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundColumnExprSyntax

public struct PoundColumnExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundColumn
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundColumnExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundColumnExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundColumnExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundColumnExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundColumn: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundColumn.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundColumn(value)
    }
  }
  public func withPoundColumn(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundColumnKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundColumn.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundColumnExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundColumn": Syntax(poundColumn).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TryExprSyntax

public struct TryExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case tryKeyword
    case questionOrExclamationMark
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TryExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var tryKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.tryKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withTryKeyword(value)
    }
  }
  public func withTryKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .tryKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.tryKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var questionOrExclamationMark: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.questionOrExclamationMark.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withQuestionOrExclamationMark(value)
    }
  }
  public func withQuestionOrExclamationMark(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.questionOrExclamationMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "tryKeyword": Syntax(tryKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AwaitExprSyntax

public struct AwaitExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case awaitKeyword
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAwaitExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AwaitExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AwaitExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AwaitExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var awaitKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.awaitKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAwaitKeyword(value)
    }
  }
  public func withAwaitKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.awaitKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AwaitExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "awaitKeyword": Syntax(awaitKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IdentifierExprSyntax

public struct IdentifierExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
    case declNameArguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIdentifierExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IdentifierExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IdentifierExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IdentifierExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }
  public func withIdentifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }
  public func withDeclNameArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.declNameArguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IdentifierExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SuperRefExprSyntax

public struct SuperRefExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case superKeyword
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSuperRefExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SuperRefExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SuperRefExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SuperRefExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var superKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.superKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withSuperKeyword(value)
    }
  }
  public func withSuperKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .superKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.superKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SuperRefExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "superKeyword": Syntax(superKeyword).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - NilLiteralExprSyntax

public struct NilLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case nilKeyword
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawNilLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `NilLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `NilLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `NilLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var nilKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.nilKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withNilKeyword(value)
    }
  }
  public func withNilKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .nilKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.nilKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension NilLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "nilKeyword": Syntax(nilKeyword).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DiscardAssignmentExprSyntax

public struct DiscardAssignmentExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case wildcard
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDiscardAssignmentExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DiscardAssignmentExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DiscardAssignmentExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DiscardAssignmentExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var wildcard: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.wildcard.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWildcard(value)
    }
  }
  public func withWildcard(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .wildcardKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.wildcard.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DiscardAssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AssignmentExprSyntax

public struct AssignmentExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case assignToken
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAssignmentExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AssignmentExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AssignmentExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AssignmentExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var assignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.assignToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAssignToken(value)
    }
  }
  public func withAssignToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw

    let newRaw = raw.replacingChild(
      at: Cursor.assignToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AssignmentExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "assignToken": Syntax(assignToken).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SequenceExprSyntax

public struct SequenceExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case elements
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSequenceExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SequenceExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SequenceExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SequenceExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var elements: ExprListSyntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return ExprListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .exprList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElements(_ newChild: ExprListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SequenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundLineExprSyntax

public struct PoundLineExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundLine
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundLineExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundLineExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundLineExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundLineExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundLine: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundLine.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundLine(value)
    }
  }
  public func withPoundLine(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundLineKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundLine.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundLineExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundLine": Syntax(poundLine).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundFileExprSyntax

public struct PoundFileExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundFile
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundFileExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundFileExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundFileExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundFileExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundFile: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFile.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundFile(value)
    }
  }
  public func withPoundFile(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFileKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundFile.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundFileExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFile": Syntax(poundFile).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundFileIDExprSyntax

public struct PoundFileIDExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundFileID
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundFileIDExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundFileIDExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundFileIDExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundFileIDExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundFileID: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFileID.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundFileID(value)
    }
  }
  public func withPoundFileID(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFileIDKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundFileID.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundFileIDExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFileID": Syntax(poundFileID).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundFilePathExprSyntax

public struct PoundFilePathExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundFilePath
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundFilePathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundFilePathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundFilePathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundFilePathExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundFilePath: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFilePath.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundFilePath(value)
    }
  }
  public func withPoundFilePath(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFilePathKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundFilePath.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundFilePathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFilePath": Syntax(poundFilePath).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundFunctionExprSyntax

public struct PoundFunctionExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundFunction
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundFunctionExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundFunctionExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundFunctionExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundFunctionExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundFunction: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundFunction.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundFunction(value)
    }
  }
  public func withPoundFunction(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFunctionKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundFunction.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundFunctionExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundFunction": Syntax(poundFunction).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundDsohandleExprSyntax

public struct PoundDsohandleExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundDsohandle
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundDsohandleExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundDsohandleExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundDsohandleExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundDsohandleExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundDsohandle: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundDsohandle.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundDsohandle(value)
    }
  }
  public func withPoundDsohandle(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundDsohandleKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundDsohandle.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PoundDsohandleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundDsohandle": Syntax(poundDsohandle).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SymbolicReferenceExprSyntax

public struct SymbolicReferenceExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
    case genericArgumentClause
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSymbolicReferenceExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SymbolicReferenceExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SymbolicReferenceExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SymbolicReferenceExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }
  public func withIdentifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
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

extension SymbolicReferenceExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": genericArgumentClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrefixOperatorExprSyntax

public struct PrefixOperatorExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case operatorToken
    case postfixExpression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrefixOperatorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrefixOperatorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PrefixOperatorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PrefixOperatorExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var operatorToken: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.operatorToken.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }
  public func withOperatorToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.operatorToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var postfixExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.postfixExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withPostfixExpression(value)
    }
  }
  public func withPostfixExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.postfixExpression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PrefixOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "operatorToken": operatorToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "postfixExpression": Syntax(postfixExpression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BinaryOperatorExprSyntax

public struct BinaryOperatorExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case operatorToken
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBinaryOperatorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BinaryOperatorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `BinaryOperatorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `BinaryOperatorExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var operatorToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.operatorToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }
  public func withOperatorToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.operatorToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension BinaryOperatorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrowExprSyntax

public struct ArrowExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case asyncKeyword
    case throwsToken
    case arrowToken
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawArrowExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ArrowExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ArrowExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ArrowExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
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

  public var throwsToken: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsToken.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withThrowsToken(value)
    }
  }
  public func withThrowsToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.throwsToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var arrowToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.arrowToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withArrowToken(value)
    }
  }
  public func withArrowToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .arrow).raw

    let newRaw = raw.replacingChild(
      at: Cursor.arrowToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ArrowExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsToken": throwsToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "arrowToken": Syntax(arrowToken).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FloatLiteralExprSyntax

public struct FloatLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case floatingDigits
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFloatLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FloatLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FloatLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FloatLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var floatingDigits: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.floatingDigits.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFloatingDigits(value)
    }
  }
  public func withFloatingDigits(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .floatingLiteral).raw

    let newRaw = raw.replacingChild(
      at: Cursor.floatingDigits.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension FloatLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "floatingDigits": Syntax(floatingDigits).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleExprSyntax

public struct TupleExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case elementList
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TupleExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TupleExprSyntax` unsafely assuming `syntax` is valid.
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

  public var elementList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elementList.rawValue)
      return TupleExprElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elementList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elementList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElementList(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleExprElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elementList.rawValue, with: newChildRaw, arena: arena)
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

extension TupleExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayExprSyntax

public struct ArrayExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftSquare
    case elements
    case rightSquare
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawArrayExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ArrayExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ArrayExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ArrayExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftSquare(value)
    }
  }
  public func withLeftSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elements: ArrayElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return ArrayElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .arrayElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElements(_ newChild: ArrayElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawArrayElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightSquare(value)
    }
  }
  public func withRightSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ArrayExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryExprSyntax

public struct DictionaryExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftSquare
    case content
    case rightSquare
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDictionaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DictionaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DictionaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DictionaryExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftSquare(value)
    }
  }
  public func withLeftSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var content: Syntax {
    get {
      let childData = data.child(at: Cursor.content.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withContent(value)
    }
  }
  public func withContent(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.content.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightSquare.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightSquare(value)
    }
  }
  public func withRightSquare(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightSquare.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DictionaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self) as Any,
      "content": Syntax(content).asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IntegerLiteralExprSyntax

public struct IntegerLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case digits
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIntegerLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IntegerLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IntegerLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IntegerLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var digits: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.digits.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDigits(value)
    }
  }
  public func withDigits(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .integerLiteral).raw

    let newRaw = raw.replacingChild(
      at: Cursor.digits.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IntegerLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "digits": Syntax(digits).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BooleanLiteralExprSyntax

public struct BooleanLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case booleanLiteral
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBooleanLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BooleanLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `BooleanLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `BooleanLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var booleanLiteral: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.booleanLiteral.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withBooleanLiteral(value)
    }
  }
  public func withBooleanLiteral(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .trueKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.booleanLiteral.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension BooleanLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "booleanLiteral": Syntax(booleanLiteral).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TernaryExprSyntax

public struct TernaryExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case conditionExpression
    case questionMark
    case firstChoice
    case colonMark
    case secondChoice
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTernaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TernaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TernaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TernaryExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var conditionExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.conditionExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withConditionExpression(value)
    }
  }
  public func withConditionExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.conditionExpression.rawValue, with: newChildRaw, arena: arena)
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
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .infixQuestionMark).raw

    let newRaw = raw.replacingChild(
      at: Cursor.questionMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var firstChoice: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.firstChoice.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withFirstChoice(value)
    }
  }
  public func withFirstChoice(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.firstChoice.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colonMark: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colonMark.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withColonMark(value)
    }
  }
  public func withColonMark(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw

    let newRaw = raw.replacingChild(
      at: Cursor.colonMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var secondChoice: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.secondChoice.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withSecondChoice(value)
    }
  }
  public func withSecondChoice(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.secondChoice.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TernaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "conditionExpression": Syntax(conditionExpression).asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self) as Any,
      "firstChoice": Syntax(firstChoice).asProtocol(SyntaxProtocol.self) as Any,
      "colonMark": Syntax(colonMark).asProtocol(SyntaxProtocol.self) as Any,
      "secondChoice": Syntax(secondChoice).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - MemberAccessExprSyntax

public struct MemberAccessExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case base
    case dot
    case name
    case declNameArguments
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMemberAccessExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MemberAccessExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `MemberAccessExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `MemberAccessExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var base: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.base.rawValue)
      return childData.map { ExprSyntax(data: $0) }
    }
    set(value) {
      self = withBase(value)
    }
  }
  public func withBase(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.base.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var dot: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.dot.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDot(value)
    }
  }
  public func withDot(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw

    let newRaw = raw.replacingChild(
      at: Cursor.dot.rawValue, with: newChildRaw, arena: arena)
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
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments.rawValue)
      return childData.map { DeclNameArgumentsSyntax(data: $0) }
    }
    set(value) {
      self = withDeclNameArguments(value)
    }
  }
  public func withDeclNameArguments(_ newChild: DeclNameArgumentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.declNameArguments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension MemberAccessExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": Syntax(dot).asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsExprSyntax

public struct IsExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case isTok
    case typeName
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIsExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IsExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IsExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IsExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var isTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.isTok.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIsTok(value)
    }
  }
  public func withIsTok(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .isKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.isTok.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withTypeName(value)
    }
  }
  public func withTypeName(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "isTok": Syntax(isTok).asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AsExprSyntax

public struct AsExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case asTok
    case questionOrExclamationMark
    case typeName
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAsExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AsExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AsExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AsExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var asTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.asTok.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAsTok(value)
    }
  }
  public func withAsTok(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .asKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.asTok.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var questionOrExclamationMark: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.questionOrExclamationMark.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withQuestionOrExclamationMark(value)
    }
  }
  public func withQuestionOrExclamationMark(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.questionOrExclamationMark.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withTypeName(value)
    }
  }
  public func withTypeName(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension AsExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "asTok": Syntax(asTok).asProtocol(SyntaxProtocol.self) as Any,
      "questionOrExclamationMark": questionOrExclamationMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeExprSyntax

public struct TypeExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case type
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTypeExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TypeExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TypeExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TypeExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return TypeSyntax(data: childData!)
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTypeSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TypeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureExprSyntax

public struct ClosureExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftBrace
    case signature
    case statements
    case rightBrace
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ClosureExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ClosureExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftBrace(value)
    }
  }
  public func withLeftBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var signature: ClosureSignatureSyntax? {
    get {
      let childData = data.child(at: Cursor.signature.rawValue)
      return childData.map { ClosureSignatureSyntax(data: $0) }
    }
    set(value) {
      self = withSignature(value)
    }
  }
  public func withSignature(_ newChild: ClosureSignatureSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.signature.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements.rawValue)
      return CodeBlockItemListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.statements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .codeBlockItemList)
    }
    let newRaw = raw.replacingChild(at: Cursor.statements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.statements.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBrace.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightBrace(value)
    }
  }
  public func withRightBrace(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightBrace.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ClosureExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self) as Any,
      "signature": signature.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnresolvedPatternExprSyntax

public struct UnresolvedPatternExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case pattern
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnresolvedPatternExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnresolvedPatternExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnresolvedPatternExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnresolvedPatternExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }
  public func withPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.pattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension UnresolvedPatternExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionCallExprSyntax

public struct FunctionCallExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case calledExpression
    case leftParen
    case argumentList
    case rightParen
    case trailingClosure
    case additionalTrailingClosures
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionCallExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionCallExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FunctionCallExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FunctionCallExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var calledExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.calledExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withCalledExpression(value)
    }
  }
  public func withCalledExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.calledExpression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.leftParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLeftParen(value)
    }
  }
  public func withLeftParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.argumentList.rawValue)
      return TupleExprElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.argumentList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.argumentList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArgumentList(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleExprElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.argumentList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.rightParen.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withRightParen(value)
    }
  }
  public func withRightParen(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightParen.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingClosure: ClosureExprSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingClosure.rawValue)
      return childData.map { ClosureExprSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingClosure(value)
    }
  }
  public func withTrailingClosure(_ newChild: ClosureExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingClosure.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.additionalTrailingClosures.rawValue)
      return childData.map { MultipleTrailingClosureElementListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.additionalTrailingClosures.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .multipleTrailingClosureElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.additionalTrailingClosures.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAdditionalTrailingClosures(_ newChild: MultipleTrailingClosureElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.additionalTrailingClosures.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension FunctionCallExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SubscriptExprSyntax

public struct SubscriptExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case calledExpression
    case leftBracket
    case argumentList
    case rightBracket
    case trailingClosure
    case additionalTrailingClosures
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSubscriptExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SubscriptExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SubscriptExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SubscriptExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var calledExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.calledExpression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withCalledExpression(value)
    }
  }
  public func withCalledExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.calledExpression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var leftBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLeftBracket(value)
    }
  }
  public func withLeftBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.leftBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var argumentList: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.argumentList.rawValue)
      return TupleExprElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.argumentList.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.argumentList.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArgumentList(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleExprElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.argumentList.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rightBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightBracket.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRightBracket(value)
    }
  }
  public func withRightBracket(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw

    let newRaw = raw.replacingChild(
      at: Cursor.rightBracket.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var trailingClosure: ClosureExprSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingClosure.rawValue)
      return childData.map { ClosureExprSyntax(data: $0) }
    }
    set(value) {
      self = withTrailingClosure(value)
    }
  }
  public func withTrailingClosure(_ newChild: ClosureExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.trailingClosure.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.additionalTrailingClosures.rawValue)
      return childData.map { MultipleTrailingClosureElementListSyntax(data: $0) }
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
    if let col = raw.children[Cursor.additionalTrailingClosures.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .multipleTrailingClosureElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.additionalTrailingClosures.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withAdditionalTrailingClosures(_ newChild: MultipleTrailingClosureElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.additionalTrailingClosures.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SubscriptExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "calledExpression": Syntax(calledExpression).asProtocol(SyntaxProtocol.self) as Any,
      "leftBracket": Syntax(leftBracket).asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": Syntax(argumentList).asProtocol(SyntaxProtocol.self) as Any,
      "rightBracket": Syntax(rightBracket).asProtocol(SyntaxProtocol.self) as Any,
      "trailingClosure": trailingClosure.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "additionalTrailingClosures": additionalTrailingClosures.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalChainingExprSyntax

public struct OptionalChainingExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
    case questionMark
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawOptionalChainingExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `OptionalChainingExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `OptionalChainingExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `OptionalChainingExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
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

extension OptionalChainingExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ForcedValueExprSyntax

public struct ForcedValueExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
    case exclamationMark
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawForcedValueExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ForcedValueExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ForcedValueExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ForcedValueExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
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

extension ForcedValueExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "exclamationMark": Syntax(exclamationMark).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PostfixUnaryExprSyntax

public struct PostfixUnaryExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
    case operatorToken
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPostfixUnaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PostfixUnaryExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PostfixUnaryExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PostfixUnaryExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var operatorToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.operatorToken.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withOperatorToken(value)
    }
  }
  public func withOperatorToken(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixOperator).raw

    let newRaw = raw.replacingChild(
      at: Cursor.operatorToken.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PostfixUnaryExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "operatorToken": Syntax(operatorToken).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SpecializeExprSyntax

public struct SpecializeExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
    case genericArgumentClause
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSpecializeExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SpecializeExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SpecializeExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SpecializeExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax {
    get {
      let childData = data.child(at: Cursor.genericArgumentClause.rawValue)
      return GenericArgumentClauseSyntax(data: childData!)
    }
    set(value) {
      self = withGenericArgumentClause(value)
    }
  }
  public func withGenericArgumentClause(_ newChild: GenericArgumentClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawGenericArgumentClauseSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.genericArgumentClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension SpecializeExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "genericArgumentClause": Syntax(genericArgumentClause).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - StringLiteralExprSyntax

public struct StringLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case openDelimiter
    case openQuote
    case segments
    case closeQuote
    case closeDelimiter
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawStringLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `StringLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `StringLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `StringLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var openDelimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.openDelimiter.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withOpenDelimiter(value)
    }
  }
  public func withOpenDelimiter(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.openDelimiter.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var openQuote: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.openQuote.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withOpenQuote(value)
    }
  }
  public func withOpenQuote(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringQuote).raw

    let newRaw = raw.replacingChild(
      at: Cursor.openQuote.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var segments: StringLiteralSegmentsSyntax {
    get {
      let childData = data.child(at: Cursor.segments.rawValue)
      return StringLiteralSegmentsSyntax(data: childData!)
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
    if let col = raw.children[Cursor.segments.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .stringLiteralSegments)
    }
    let newRaw = raw.replacingChild(at: Cursor.segments.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withSegments(_ newChild: StringLiteralSegmentsSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawStringLiteralSegmentsSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.segments.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var closeQuote: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.closeQuote.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withCloseQuote(value)
    }
  }
  public func withCloseQuote(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringQuote).raw

    let newRaw = raw.replacingChild(
      at: Cursor.closeQuote.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var closeDelimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.closeDelimiter.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withCloseDelimiter(value)
    }
  }
  public func withCloseDelimiter(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.closeDelimiter.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension StringLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "openDelimiter": openDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "openQuote": Syntax(openQuote).asProtocol(SyntaxProtocol.self) as Any,
      "segments": Syntax(segments).asProtocol(SyntaxProtocol.self) as Any,
      "closeQuote": Syntax(closeQuote).asProtocol(SyntaxProtocol.self) as Any,
      "closeDelimiter": closeDelimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - RegexLiteralExprSyntax

public struct RegexLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case regex
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawRegexLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `RegexLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `RegexLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `RegexLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var regex: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.regex.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRegex(value)
    }
  }
  public func withRegex(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .regexLiteral).raw

    let newRaw = raw.replacingChild(
      at: Cursor.regex.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension RegexLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "regex": Syntax(regex).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathExprSyntax

public struct KeyPathExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case backslash
    case rootExpr
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawKeyPathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `KeyPathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `KeyPathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `KeyPathExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.backslash.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withBackslash(value)
    }
  }
  public func withBackslash(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .backslash).raw

    let newRaw = raw.replacingChild(
      at: Cursor.backslash.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var rootExpr: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.rootExpr.rawValue)
      return childData.map { ExprSyntax(data: $0) }
    }
    set(value) {
      self = withRootExpr(value)
    }
  }
  public func withRootExpr(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.rootExpr.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension KeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self) as Any,
      "rootExpr": rootExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - KeyPathBaseExprSyntax

public struct KeyPathBaseExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case period
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawKeyPathBaseExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `KeyPathBaseExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `KeyPathBaseExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `KeyPathBaseExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
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
}

extension KeyPathBaseExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "period": Syntax(period).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjcKeyPathExprSyntax

public struct ObjcKeyPathExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case keyPath
    case leftParen
    case name
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjcKeyPathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjcKeyPathExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ObjcKeyPathExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ObjcKeyPathExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var keyPath: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.keyPath.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withKeyPath(value)
    }
  }
  public func withKeyPath(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundKeyPathKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.keyPath.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

  public var name: ObjcNameSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return ObjcNameSyntax(data: childData!)
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
    if let col = raw.children[Cursor.name.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .objcName)
    }
    let newRaw = raw.replacingChild(at: Cursor.name.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withName(_ newChild: ObjcNameSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawObjcNameSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
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

extension ObjcKeyPathExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "keyPath": Syntax(keyPath).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjcSelectorExprSyntax

public struct ObjcSelectorExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundSelector
    case leftParen
    case kind
    case colon
    case name
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjcSelectorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjcSelectorExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ObjcSelectorExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ObjcSelectorExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundSelector: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundSelector.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundSelector(value)
    }
  }
  public func withPoundSelector(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundSelectorKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundSelector.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

  public var kind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.kind.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withKind(value)
    }
  }
  public func withKind(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.kind.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withColon(value)
    }
  }
  public func withColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.colon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var name: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.name.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withName(value)
    }
  }
  public func withName(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.name.rawValue, with: newChildRaw, arena: arena)
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

extension ObjcSelectorExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundSelector": Syntax(poundSelector).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "kind": kind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PostfixIfConfigExprSyntax

public struct PostfixIfConfigExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case base
    case config
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPostfixIfConfigExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PostfixIfConfigExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PostfixIfConfigExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PostfixIfConfigExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var base: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.base.rawValue)
      return childData.map { ExprSyntax(data: $0) }
    }
    set(value) {
      self = withBase(value)
    }
  }
  public func withBase(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.base.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var config: IfConfigDeclSyntax {
    get {
      let childData = data.child(at: Cursor.config.rawValue)
      return IfConfigDeclSyntax(data: childData!)
    }
    set(value) {
      self = withConfig(value)
    }
  }
  public func withConfig(_ newChild: IfConfigDeclSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawIfConfigDeclSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.config.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension PostfixIfConfigExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "base": base.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "config": Syntax(config).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - EditorPlaceholderExprSyntax

public struct EditorPlaceholderExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawEditorPlaceholderExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `EditorPlaceholderExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `EditorPlaceholderExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `EditorPlaceholderExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }
  public func withIdentifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension EditorPlaceholderExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjectLiteralExprSyntax

public struct ObjectLiteralExprSyntax: ExprSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
    case leftParen
    case arguments
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjectLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjectLiteralExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ObjectLiteralExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ObjectLiteralExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }
  public func withIdentifier(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundColorLiteralKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

  public var arguments: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.arguments.rawValue)
      return TupleExprElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.arguments.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tupleExprElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.arguments.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withArguments(_ newChild: TupleExprElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTupleExprElementListSyntax.makeBlank(arena: arena).raw

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
}

extension ObjectLiteralExprSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}
