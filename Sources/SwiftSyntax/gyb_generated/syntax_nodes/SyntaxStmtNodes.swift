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


// MARK: - UnknownStmtSyntax

public struct UnknownStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnknownStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnknownStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnknownStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnknownStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

extension UnknownStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - ContinueStmtSyntax

public struct ContinueStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case continueKeyword
    case label
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawContinueStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ContinueStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ContinueStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ContinueStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var continueKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.continueKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withContinueKeyword(value)
    }
  }
  public func withContinueKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .continueKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.continueKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ContinueStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "continueKeyword": Syntax(continueKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WhileStmtSyntax

public struct WhileStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case whileKeyword
    case conditions
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawWhileStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `WhileStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `WhileStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `WhileStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whileKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whileKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWhileKeyword(value)
    }
  }
  public func withWhileKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whileKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.whileKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions.rawValue)
      return ConditionElementListSyntax(data: childData!)
    }
    set(value) {
      self = withConditions(value)
    }
  }

  /// Adds the provided `Condition` to the node's `conditions`
  /// collection.
  /// - param element: The new `Condition` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `Condition`
  ///            appended to its `conditions` collection.
  public func addCondition(_ element: ConditionElementSyntax) -> WhileStmtSyntax {
    var collection: RawSyntax
    if let col = raw.children[Cursor.conditions.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .conditionElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.conditions.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withConditions(_ newChild: ConditionElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawConditionElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.conditions.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension WhileStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whileKeyword": Syntax(whileKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeferStmtSyntax

public struct DeferStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case deferKeyword
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeferStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeferStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeferStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeferStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var deferKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.deferKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDeferKeyword(value)
    }
  }
  public func withDeferKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .deferKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.deferKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeferStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "deferKeyword": Syntax(deferKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionStmtSyntax

public struct ExpressionStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawExpressionStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ExpressionStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ExpressionStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ExpressionStmtSyntax` unsafely assuming `syntax` is valid.
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
}

extension ExpressionStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - RepeatWhileStmtSyntax

public struct RepeatWhileStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case repeatKeyword
    case body
    case whileKeyword
    case condition
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawRepeatWhileStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `RepeatWhileStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `RepeatWhileStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `RepeatWhileStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var repeatKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.repeatKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withRepeatKeyword(value)
    }
  }
  public func withRepeatKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .repeatKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.repeatKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whileKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whileKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withWhileKeyword(value)
    }
  }
  public func withWhileKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whileKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.whileKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var condition: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.condition.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }
  public func withCondition(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.condition.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension RepeatWhileStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "repeatKeyword": Syntax(repeatKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
      "whileKeyword": Syntax(whileKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GuardStmtSyntax

public struct GuardStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case guardKeyword
    case conditions
    case elseKeyword
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGuardStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GuardStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `GuardStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `GuardStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var guardKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.guardKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withGuardKeyword(value)
    }
  }
  public func withGuardKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .guardKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.guardKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions.rawValue)
      return ConditionElementListSyntax(data: childData!)
    }
    set(value) {
      self = withConditions(value)
    }
  }

  /// Adds the provided `Condition` to the node's `conditions`
  /// collection.
  /// - param element: The new `Condition` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `Condition`
  ///            appended to its `conditions` collection.
  public func addCondition(_ element: ConditionElementSyntax) -> GuardStmtSyntax {
    var collection: RawSyntax
    if let col = raw.children[Cursor.conditions.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .conditionElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.conditions.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withConditions(_ newChild: ConditionElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawConditionElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.conditions.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.elseKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withElseKeyword(value)
    }
  }
  public func withElseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .elseKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.elseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension GuardStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "guardKeyword": Syntax(guardKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self) as Any,
      "elseKeyword": Syntax(elseKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ForInStmtSyntax

public struct ForInStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case forKeyword
    case tryKeyword
    case awaitKeyword
    case caseKeyword
    case pattern
    case typeAnnotation
    case inKeyword
    case sequenceExpr
    case whereClause
    case body
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawForInStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ForInStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ForInStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ForInStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var forKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.forKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withForKeyword(value)
    }
  }
  public func withForKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .forKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.forKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var tryKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.tryKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withTryKeyword(value)
    }
  }
  public func withTryKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.tryKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var awaitKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.awaitKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withAwaitKeyword(value)
    }
  }
  public func withAwaitKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.awaitKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var caseKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.caseKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withCaseKeyword(value)
    }
  }
  public func withCaseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.caseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: Cursor.typeAnnotation.rawValue)
      return childData.map { TypeAnnotationSyntax(data: $0) }
    }
    set(value) {
      self = withTypeAnnotation(value)
    }
  }
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.typeAnnotation.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var inKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.inKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withInKeyword(value)
    }
  }
  public func withInKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .inKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.inKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var sequenceExpr: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.sequenceExpr.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withSequenceExpr(value)
    }
  }
  public func withSequenceExpr(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.sequenceExpr.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause.rawValue)
      return childData.map { WhereClauseSyntax(data: $0) }
    }
    set(value) {
      self = withWhereClause(value)
    }
  }
  public func withWhereClause(_ newChild: WhereClauseSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.whereClause.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ForInStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "forKeyword": Syntax(forKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "tryKeyword": tryKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "awaitKeyword": awaitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": caseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inKeyword": Syntax(inKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "sequenceExpr": Syntax(sequenceExpr).asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchStmtSyntax

public struct SwitchStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case switchKeyword
    case expression
    case leftBrace
    case cases
    case rightBrace
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSwitchStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SwitchStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `SwitchStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `SwitchStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var switchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.switchKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withSwitchKeyword(value)
    }
  }
  public func withSwitchKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .switchKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.switchKeyword.rawValue, with: newChildRaw, arena: arena)
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

  public var cases: SwitchCaseListSyntax {
    get {
      let childData = data.child(at: Cursor.cases.rawValue)
      return SwitchCaseListSyntax(data: childData!)
    }
    set(value) {
      self = withCases(value)
    }
  }

  /// Adds the provided `Case` to the node's `cases`
  /// collection.
  /// - param element: The new `Case` to add to the node's
  ///                  `cases` collection.
  /// - returns: A copy of the receiver with the provided `Case`
  ///            appended to its `cases` collection.
  public func addCase(_ element: Syntax) -> SwitchStmtSyntax {
    var collection: RawSyntax
    if let col = raw.children[Cursor.cases.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .switchCaseList)
    }
    let newRaw = raw.replacingChild(at: Cursor.cases.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withCases(_ newChild: SwitchCaseListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSwitchCaseListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.cases.rawValue, with: newChildRaw, arena: arena)
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

extension SwitchStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "switchKeyword": Syntax(switchKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self) as Any,
      "cases": Syntax(cases).asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DoStmtSyntax

public struct DoStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case doKeyword
    case body
    case catchClauses
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDoStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DoStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DoStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DoStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var doKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.doKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withDoKeyword(value)
    }
  }
  public func withDoKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .doKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.doKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var catchClauses: CatchClauseListSyntax? {
    get {
      let childData = data.child(at: Cursor.catchClauses.rawValue)
      return childData.map { CatchClauseListSyntax(data: $0) }
    }
    set(value) {
      self = withCatchClauses(value)
    }
  }

  /// Adds the provided `CatchClause` to the node's `catchClauses`
  /// collection.
  /// - param element: The new `CatchClause` to add to the node's
  ///                  `catchClauses` collection.
  /// - returns: A copy of the receiver with the provided `CatchClause`
  ///            appended to its `catchClauses` collection.
  public func addCatchClause(_ element: CatchClauseSyntax) -> DoStmtSyntax {
    var collection: RawSyntax
    if let col = raw.children[Cursor.catchClauses.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .catchClauseList)
    }
    let newRaw = raw.replacingChild(at: Cursor.catchClauses.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withCatchClauses(_ newChild: CatchClauseListSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.catchClauses.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DoStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "doKeyword": Syntax(doKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
      "catchClauses": catchClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ReturnStmtSyntax

public struct ReturnStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case returnKeyword
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawReturnStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ReturnStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ReturnStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ReturnStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var returnKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.returnKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withReturnKeyword(value)
    }
  }
  public func withReturnKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .returnKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.returnKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var expression: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.expression.rawValue)
      return childData.map { ExprSyntax(data: $0) }
    }
    set(value) {
      self = withExpression(value)
    }
  }
  public func withExpression(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.expression.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ReturnStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "returnKeyword": Syntax(returnKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "expression": expression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - YieldStmtSyntax

public struct YieldStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case yieldKeyword
    case yields
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawYieldStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `YieldStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `YieldStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `YieldStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var yieldKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.yieldKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withYieldKeyword(value)
    }
  }
  public func withYieldKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .yield).raw

    let newRaw = raw.replacingChild(
      at: Cursor.yieldKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var yields: Syntax {
    get {
      let childData = data.child(at: Cursor.yields.rawValue)
      return Syntax(data: childData!)
    }
    set(value) {
      self = withYields(value)
    }
  }
  public func withYields(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.yields.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension YieldStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "yieldKeyword": Syntax(yieldKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "yields": Syntax(yields).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FallthroughStmtSyntax

public struct FallthroughStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case fallthroughKeyword
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFallthroughStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FallthroughStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `FallthroughStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `FallthroughStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var fallthroughKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fallthroughKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withFallthroughKeyword(value)
    }
  }
  public func withFallthroughKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .fallthroughKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.fallthroughKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension FallthroughStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "fallthroughKeyword": Syntax(fallthroughKeyword).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BreakStmtSyntax

public struct BreakStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case breakKeyword
    case label
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBreakStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BreakStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `BreakStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `BreakStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var breakKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.breakKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withBreakKeyword(value)
    }
  }
  public func withBreakKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .breakKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.breakKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabel(value)
    }
  }
  public func withLabel(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.label.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension BreakStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "breakKeyword": Syntax(breakKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclarationStmtSyntax

public struct DeclarationStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case declaration
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclarationStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclarationStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `DeclarationStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `DeclarationStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var declaration: DeclSyntax {
    get {
      let childData = data.child(at: Cursor.declaration.rawValue)
      return DeclSyntax(data: childData!)
    }
    set(value) {
      self = withDeclaration(value)
    }
  }
  public func withDeclaration(_ newChild: DeclSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawDeclSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.declaration.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension DeclarationStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "declaration": Syntax(declaration).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ThrowStmtSyntax

public struct ThrowStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case throwKeyword
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawThrowStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ThrowStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ThrowStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ThrowStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var throwKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.throwKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withThrowKeyword(value)
    }
  }
  public func withThrowKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .throwKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.throwKeyword.rawValue, with: newChildRaw, arena: arena)
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

extension ThrowStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "throwKeyword": Syntax(throwKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfStmtSyntax

public struct IfStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case labelName
    case labelColon
    case ifKeyword
    case conditions
    case body
    case elseKeyword
    case elseBody
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIfStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IfStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IfStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IfStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelName(value)
    }
  }
  public func withLabelName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var labelColon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelColon.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withLabelColon(value)
    }
  }
  public func withLabelColon(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.labelColon.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var ifKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ifKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIfKeyword(value)
    }
  }
  public func withIfKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .ifKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.ifKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions.rawValue)
      return ConditionElementListSyntax(data: childData!)
    }
    set(value) {
      self = withConditions(value)
    }
  }

  /// Adds the provided `Condition` to the node's `conditions`
  /// collection.
  /// - param element: The new `Condition` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `Condition`
  ///            appended to its `conditions` collection.
  public func addCondition(_ element: ConditionElementSyntax) -> IfStmtSyntax {
    var collection: RawSyntax
    if let col = raw.children[Cursor.conditions.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .conditionElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.conditions.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withConditions(_ newChild: ConditionElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawConditionElementListSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.conditions.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body.rawValue)
      return CodeBlockSyntax(data: childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }
  public func withBody(_ newChild: CodeBlockSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawCodeBlockSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.body.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elseKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.elseKeyword.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withElseKeyword(value)
    }
  }
  public func withElseKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.elseKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var elseBody: Syntax? {
    get {
      let childData = data.child(at: Cursor.elseBody.rawValue)
      return childData.map { Syntax(data: $0) }
    }
    set(value) {
      self = withElseBody(value)
    }
  }
  public func withElseBody(_ newChild: Syntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.elseBody.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IfStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ifKeyword": Syntax(ifKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self) as Any,
      "elseKeyword": elseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elseBody": elseBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundAssertStmtSyntax

public struct PoundAssertStmtSyntax: StmtSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case poundAssert
    case leftParen
    case condition
    case comma
    case message
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPoundAssertStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PoundAssertStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `PoundAssertStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `PoundAssertStmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var poundAssert: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundAssert.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withPoundAssert(value)
    }
  }
  public func withPoundAssert(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundAssertKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.poundAssert.rawValue, with: newChildRaw, arena: arena)
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

  /// The assertion condition.
  public var condition: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.condition.rawValue)
      return ExprSyntax(data: childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }
  public func withCondition(_ newChild: ExprSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawExprSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.condition.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The comma after the assertion condition.
  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.comma.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withComma(value)
    }
  }
  public func withComma(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.comma.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  /// The assertion message.
  public var message: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.message.rawValue)
      return childData.map { TokenSyntax(data: $0) }
    }
    set(value) {
      self = withMessage(value)
    }
  }
  public func withMessage(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.message.rawValue, with: newChildRaw, arena: arena)
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

extension PoundAssertStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundAssert": Syntax(poundAssert).asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": message.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}
