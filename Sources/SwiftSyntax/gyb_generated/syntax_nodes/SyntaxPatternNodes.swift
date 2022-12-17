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


// MARK: - MissingPatternSyntax

public struct MissingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .missingPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `MissingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingPattern)
    self._syntaxNode = Syntax(data)
  }

  public init() {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena)
      return SyntaxData.forRoot(raw)
    }
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

extension MissingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - EnumCasePatternSyntax

public struct EnumCasePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .enumCasePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `EnumCasePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCasePattern)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: T? = nil,
    _ unexpectedBetweenTypeAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax = .periodToken(),
    _ unexpectedBetweenPeriodAndCaseName: UnexpectedNodesSyntax? = nil,
    caseName: TokenSyntax,
    _ unexpectedBetweenCaseNameAndAssociatedTuple: UnexpectedNodesSyntax? = nil,
    associatedTuple: TuplePatternSyntax? = nil,
    _ unexpectedAfterAssociatedTuple: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type?.raw,
      unexpectedBetweenTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndCaseName?.raw,
      caseName.raw,
      unexpectedBetweenCaseNameAndAssociatedTuple?.raw,
      associatedTuple?.raw,
      unexpectedAfterAssociatedTuple?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.enumCasePattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// This initializer exists solely because Swift 5.6 does not support
  /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
  /// The above initializer thus defaults to `nil` instead, but that means it
  /// is not actually callable when either not passing the defaulted parameter,
  /// or passing `nil`.
  ///
  /// Hack around that limitation using this initializer, which takes a
  /// `Missing*` syntax node instead. `Missing*` is used over the base type as
  /// the base type would allow implicit conversion from a string literal,
  /// which the above initializer doesn't support.
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeType: UnexpectedNodesSyntax? = nil,
    type: MissingTypeSyntax? = nil,
    _ unexpectedBetweenTypeAndPeriod: UnexpectedNodesSyntax? = nil,
    period: TokenSyntax = .periodToken(),
    _ unexpectedBetweenPeriodAndCaseName: UnexpectedNodesSyntax? = nil,
    caseName: TokenSyntax,
    _ unexpectedBetweenCaseNameAndAssociatedTuple: UnexpectedNodesSyntax? = nil,
    associatedTuple: TuplePatternSyntax? = nil,
    _ unexpectedAfterAssociatedTuple: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeType,
      type: Optional<TypeSyntax>.none,
      unexpectedBetweenTypeAndPeriod,
      period: period,
      unexpectedBetweenPeriodAndCaseName,
      caseName: caseName,
      unexpectedBetweenCaseNameAndAssociatedTuple,
      associatedTuple: associatedTuple,
      unexpectedAfterAssociatedTuple,
      trailingTrivia: trailingTrivia
    )
  }

  public var unexpectedBeforeType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
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
  public func withUnexpectedBeforeType(_ newChild: UnexpectedNodesSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
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
  public func withType(_ newChild: TypeSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var unexpectedBetweenTypeAndPeriod: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenTypeAndPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenTypeAndPeriod` replaced.
  /// - param newChild: The new `unexpectedBetweenTypeAndPeriod` to replace the node's
  ///                   current `unexpectedBetweenTypeAndPeriod`, if present.
  public func withUnexpectedBetweenTypeAndPeriod(_ newChild: UnexpectedNodesSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
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
  public func withPeriod(_ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.period, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var unexpectedBetweenPeriodAndCaseName: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPeriodAndCaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPeriodAndCaseName` replaced.
  /// - param newChild: The new `unexpectedBetweenPeriodAndCaseName` to replace the node's
  ///                   current `unexpectedBetweenPeriodAndCaseName`, if present.
  public func withUnexpectedBetweenPeriodAndCaseName(_ newChild: UnexpectedNodesSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var caseName: TokenSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCaseName(value)
    }
  }

  /// Returns a copy of the receiver with its `caseName` replaced.
  /// - param newChild: The new `caseName` to replace the node's
  ///                   current `caseName`, if present.
  public func withCaseName(_ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var unexpectedBetweenCaseNameAndAssociatedTuple: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenCaseNameAndAssociatedTuple(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenCaseNameAndAssociatedTuple` replaced.
  /// - param newChild: The new `unexpectedBetweenCaseNameAndAssociatedTuple` to replace the node's
  ///                   current `unexpectedBetweenCaseNameAndAssociatedTuple`, if present.
  public func withUnexpectedBetweenCaseNameAndAssociatedTuple(_ newChild: UnexpectedNodesSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var associatedTuple: TuplePatternSyntax? {
    get {
      let childData = data.child(at: 7, parent: Syntax(self))
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
  public func withAssociatedTuple(_ newChild: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 7, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public var unexpectedAfterAssociatedTuple: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 8, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterAssociatedTuple(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterAssociatedTuple` replaced.
  /// - param newChild: The new `unexpectedAfterAssociatedTuple` to replace the node's
  ///                   current `unexpectedAfterAssociatedTuple`, if present.
  public func withUnexpectedAfterAssociatedTuple(_ newChild: UnexpectedNodesSyntax?) -> EnumCasePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 8, with: raw, arena: arena)
    return EnumCasePatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeType,
      \Self.type,
      \Self.unexpectedBetweenTypeAndPeriod,
      \Self.period,
      \Self.unexpectedBetweenPeriodAndCaseName,
      \Self.caseName,
      \Self.unexpectedBetweenCaseNameAndAssociatedTuple,
      \Self.associatedTuple,
      \Self.unexpectedAfterAssociatedTuple,
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
      return "case name"
    case 6:
      return nil
    case 7:
      return "associated values"
    case 8:
      return nil
    default:
      fatalError("Invalid index")
    }
  }
}

extension EnumCasePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeType": unexpectedBeforeType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedBetweenTypeAndPeriod": unexpectedBetweenTypeAndPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPeriodAndCaseName": unexpectedBetweenPeriodAndCaseName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseName": Syntax(caseName).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenCaseNameAndAssociatedTuple": unexpectedBetweenCaseNameAndAssociatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "associatedTuple": associatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterAssociatedTuple": unexpectedAfterAssociatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsTypePatternSyntax

public struct IsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .isTypePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .isTypePattern)
    self._syntaxNode = Syntax(data)
  }

  public init<T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? = nil,
    isKeyword: TokenSyntax = .isKeyword(),
    _ unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedAfterType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsKeyword?.raw,
      isKeyword.raw,
      unexpectedBetweenIsKeywordAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.isTypePattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeIsKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeIsKeyword` to replace the node's
  ///                   current `unexpectedBeforeIsKeyword`, if present.
  public func withUnexpectedBeforeIsKeyword(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var isKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `isKeyword` replaced.
  /// - param newChild: The new `isKeyword` to replace the node's
  ///                   current `isKeyword`, if present.
  public func withIsKeyword(_ newChild: TokenSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenIsKeywordAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenIsKeywordAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenIsKeywordAndType` to replace the node's
  ///                   current `unexpectedBetweenIsKeywordAndType`, if present.
  public func withUnexpectedBetweenIsKeywordAndType(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withType(value)
    }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(_ newChild: TypeSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public var unexpectedAfterType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterType` replaced.
  /// - param newChild: The new `unexpectedAfterType` to replace the node's
  ///                   current `unexpectedAfterType`, if present.
  public func withUnexpectedAfterType(_ newChild: UnexpectedNodesSyntax?) -> IsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return IsTypePatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIsKeyword,
      \Self.isKeyword,
      \Self.unexpectedBetweenIsKeywordAndType,
      \Self.type,
      \Self.unexpectedAfterType,
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

extension IsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIsKeyword": unexpectedBeforeIsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "isKeyword": Syntax(isKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenIsKeywordAndType": unexpectedBetweenIsKeywordAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterType": unexpectedAfterType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalPatternSyntax

public struct OptionalPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .optionalPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `OptionalPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalPattern)
    self._syntaxNode = Syntax(data)
  }

  public init<S: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSubPattern: UnexpectedNodesSyntax? = nil,
    subPattern: S,
    _ unexpectedBetweenSubPatternAndQuestionMark: UnexpectedNodesSyntax? = nil,
    questionMark: TokenSyntax = .postfixQuestionMarkToken(),
    _ unexpectedAfterQuestionMark: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSubPattern?.raw,
      subPattern.raw,
      unexpectedBetweenSubPatternAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedAfterQuestionMark?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.optionalPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeSubPattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeSubPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeSubPattern` replaced.
  /// - param newChild: The new `unexpectedBeforeSubPattern` to replace the node's
  ///                   current `unexpectedBeforeSubPattern`, if present.
  public func withUnexpectedBeforeSubPattern(_ newChild: UnexpectedNodesSyntax?) -> OptionalPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return OptionalPatternSyntax(newData)
  }

  public var subPattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withSubPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `subPattern` replaced.
  /// - param newChild: The new `subPattern` to replace the node's
  ///                   current `subPattern`, if present.
  public func withSubPattern(_ newChild: PatternSyntax?) -> OptionalPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return OptionalPatternSyntax(newData)
  }

  public var unexpectedBetweenSubPatternAndQuestionMark: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenSubPatternAndQuestionMark(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenSubPatternAndQuestionMark` replaced.
  /// - param newChild: The new `unexpectedBetweenSubPatternAndQuestionMark` to replace the node's
  ///                   current `unexpectedBetweenSubPatternAndQuestionMark`, if present.
  public func withUnexpectedBetweenSubPatternAndQuestionMark(_ newChild: UnexpectedNodesSyntax?) -> OptionalPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return OptionalPatternSyntax(newData)
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
  public func withQuestionMark(_ newChild: TokenSyntax?) -> OptionalPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return OptionalPatternSyntax(newData)
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
  public func withUnexpectedAfterQuestionMark(_ newChild: UnexpectedNodesSyntax?) -> OptionalPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return OptionalPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeSubPattern,
      \Self.subPattern,
      \Self.unexpectedBetweenSubPatternAndQuestionMark,
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

extension OptionalPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeSubPattern": unexpectedBeforeSubPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "subPattern": Syntax(subPattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenSubPatternAndQuestionMark": unexpectedBetweenSubPatternAndQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterQuestionMark": unexpectedAfterQuestionMark.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IdentifierPatternSyntax

public struct IdentifierPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .identifierPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `IdentifierPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .identifierPattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedAfterIdentifier?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.identifierPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
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
  public func withUnexpectedBeforeIdentifier(_ newChild: UnexpectedNodesSyntax?) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
  }

  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(_ newChild: TokenSyntax?) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.selfKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
  }

  public var unexpectedAfterIdentifier: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterIdentifier(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterIdentifier` replaced.
  /// - param newChild: The new `unexpectedAfterIdentifier` to replace the node's
  ///                   current `unexpectedAfterIdentifier`, if present.
  public func withUnexpectedAfterIdentifier(_ newChild: UnexpectedNodesSyntax?) -> IdentifierPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return IdentifierPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeIdentifier,
      \Self.identifier,
      \Self.unexpectedAfterIdentifier,
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

extension IdentifierPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeIdentifier": unexpectedBeforeIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterIdentifier": unexpectedAfterIdentifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AsTypePatternSyntax

public struct AsTypePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .asTypePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `AsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .asTypePattern)
    self._syntaxNode = Syntax(data)
  }

  public init<P: PatternSyntaxProtocol, T: TypeSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil,
    pattern: P,
    _ unexpectedBetweenPatternAndAsKeyword: UnexpectedNodesSyntax? = nil,
    asKeyword: TokenSyntax = .asKeyword(),
    _ unexpectedBetweenAsKeywordAndType: UnexpectedNodesSyntax? = nil,
    type: T,
    _ unexpectedAfterType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndAsKeyword?.raw,
      asKeyword.raw,
      unexpectedBetweenAsKeywordAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.asTypePattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
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
  public func withUnexpectedBeforePattern(_ newChild: UnexpectedNodesSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(_ newChild: PatternSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var unexpectedBetweenPatternAndAsKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenPatternAndAsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenPatternAndAsKeyword` replaced.
  /// - param newChild: The new `unexpectedBetweenPatternAndAsKeyword` to replace the node's
  ///                   current `unexpectedBetweenPatternAndAsKeyword`, if present.
  public func withUnexpectedBetweenPatternAndAsKeyword(_ newChild: UnexpectedNodesSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var asKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAsKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `asKeyword` replaced.
  /// - param newChild: The new `asKeyword` to replace the node's
  ///                   current `asKeyword`, if present.
  public func withAsKeyword(_ newChild: TokenSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var unexpectedBetweenAsKeywordAndType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenAsKeywordAndType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenAsKeywordAndType` replaced.
  /// - param newChild: The new `unexpectedBetweenAsKeywordAndType` to replace the node's
  ///                   current `unexpectedBetweenAsKeywordAndType`, if present.
  public func withUnexpectedBetweenAsKeywordAndType(_ newChild: UnexpectedNodesSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: 5, parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withType(value)
    }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(_ newChild: TypeSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public var unexpectedAfterType: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 6, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterType(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterType` replaced.
  /// - param newChild: The new `unexpectedAfterType` to replace the node's
  ///                   current `unexpectedAfterType`, if present.
  public func withUnexpectedAfterType(_ newChild: UnexpectedNodesSyntax?) -> AsTypePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return AsTypePatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforePattern,
      \Self.pattern,
      \Self.unexpectedBetweenPatternAndAsKeyword,
      \Self.asKeyword,
      \Self.unexpectedBetweenAsKeywordAndType,
      \Self.type,
      \Self.unexpectedAfterType,
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

extension AsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforePattern": unexpectedBeforePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenPatternAndAsKeyword": unexpectedBetweenPatternAndAsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asKeyword": Syntax(asKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenAsKeywordAndType": unexpectedBetweenAsKeywordAndType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterType": unexpectedAfterType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TuplePatternSyntax

public struct TuplePatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tuplePattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `TuplePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil,
    elements: TuplePatternElementListSyntax,
    _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
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
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.tuplePattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
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
  public func withUnexpectedBeforeLeftParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withLeftParen(_ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withUnexpectedBetweenLeftParenAndElements(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
  }

  public var elements: TuplePatternElementListSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
    let arena = SyntaxArena()
    if let col = raw.layoutView!.children[3] {
      collection = col.layoutView!.appending(element.raw, arena: arena)
    } else {
      collection = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElementList,
        from: [element.raw], arena: arena)
    }
    let newData = data.replacingChild(at: 3, with: collection, arena: arena)
    return TuplePatternSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(_ newChild: TuplePatternElementListSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.tuplePatternElementList, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withUnexpectedBetweenElementsAndRightParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withRightParen(_ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena)
    let newData = data.replacingChild(at: 5, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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
  public func withUnexpectedAfterRightParen(_ newChild: UnexpectedNodesSyntax?) -> TuplePatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 6, with: raw, arena: arena)
    return TuplePatternSyntax(newData)
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

extension TuplePatternSyntax: CustomReflectable {
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

// MARK: - WildcardPatternSyntax

public struct WildcardPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .wildcardPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `WildcardPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .wildcardPattern)
    self._syntaxNode = Syntax(data)
  }

  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil,
    wildcard: TokenSyntax = .wildcardKeyword(),
    _ unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
      unexpectedBetweenWildcardAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedAfterTypeAnnotation?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.wildcardPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeWildcard: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
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
  public func withUnexpectedBeforeWildcard(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var wildcard: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWildcard(value)
    }
  }

  /// Returns a copy of the receiver with its `wildcard` replaced.
  /// - param newChild: The new `wildcard` to replace the node's
  ///                   current `wildcard`, if present.
  public func withWildcard(_ newChild: TokenSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenWildcardAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenWildcardAndTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedBetweenWildcardAndTypeAnnotation` to replace the node's
  ///                   current `unexpectedBetweenWildcardAndTypeAnnotation`, if present.
  public func withUnexpectedBetweenWildcardAndTypeAnnotation(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
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
  public func withTypeAnnotation(_ newChild: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public var unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterTypeAnnotation` replaced.
  /// - param newChild: The new `unexpectedAfterTypeAnnotation` to replace the node's
  ///                   current `unexpectedAfterTypeAnnotation`, if present.
  public func withUnexpectedAfterTypeAnnotation(_ newChild: UnexpectedNodesSyntax?) -> WildcardPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return WildcardPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeWildcard,
      \Self.wildcard,
      \Self.unexpectedBetweenWildcardAndTypeAnnotation,
      \Self.typeAnnotation,
      \Self.unexpectedAfterTypeAnnotation,
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

extension WildcardPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeWildcard": unexpectedBeforeWildcard.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenWildcardAndTypeAnnotation": unexpectedBetweenWildcardAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "unexpectedAfterTypeAnnotation": unexpectedAfterTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionPatternSyntax

public struct ExpressionPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .expressionPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ExpressionPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionPattern)
    self._syntaxNode = Syntax(data)
  }

  public init<E: ExprSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil,
    expression: E,
    _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.expressionPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
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
  public func withUnexpectedBeforeExpression(_ newChild: UnexpectedNodesSyntax?) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(_ newChild: ExprSyntax?) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
  }

  public var unexpectedAfterExpression: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterExpression` replaced.
  /// - param newChild: The new `unexpectedAfterExpression` to replace the node's
  ///                   current `unexpectedAfterExpression`, if present.
  public func withUnexpectedAfterExpression(_ newChild: UnexpectedNodesSyntax?) -> ExpressionPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ExpressionPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeExpression,
      \Self.expression,
      \Self.unexpectedAfterExpression,
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

extension ExpressionPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeExpression": unexpectedBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterExpression": unexpectedAfterExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ValueBindingPatternSyntax

public struct ValueBindingPatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .valueBindingPattern else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a `ValueBindingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .valueBindingPattern)
    self._syntaxNode = Syntax(data)
  }

  public init<V: PatternSyntaxProtocol>(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil,
    letOrVarKeyword: TokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? = nil,
    valuePattern: V,
    _ unexpectedAfterValuePattern: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndValuePattern?.raw,
      valuePattern.raw,
      unexpectedAfterValuePattern?.raw,
    ]
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(
        kind: SyntaxKind.valueBindingPattern, from: layout, arena: arena,
        leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 0, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBeforeLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBeforeLetOrVarKeyword` replaced.
  /// - param newChild: The new `unexpectedBeforeLetOrVarKeyword` to replace the node's
  ///                   current `unexpectedBeforeLetOrVarKeyword`, if present.
  public func withUnexpectedBeforeLetOrVarKeyword(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 0, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: 1, parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLetOrVarKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `letOrVarKeyword` replaced.
  /// - param newChild: The new `letOrVarKeyword` to replace the node's
  ///                   current `letOrVarKeyword`, if present.
  public func withLetOrVarKeyword(_ newChild: TokenSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: arena)
    let newData = data.replacingChild(at: 1, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 2, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedBetweenLetOrVarKeywordAndValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedBetweenLetOrVarKeywordAndValuePattern` replaced.
  /// - param newChild: The new `unexpectedBetweenLetOrVarKeywordAndValuePattern` to replace the node's
  ///                   current `unexpectedBetweenLetOrVarKeywordAndValuePattern`, if present.
  public func withUnexpectedBetweenLetOrVarKeywordAndValuePattern(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 2, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var valuePattern: PatternSyntax {
    get {
      let childData = data.child(at: 3, parent: Syntax(self))
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `valuePattern` replaced.
  /// - param newChild: The new `valuePattern` to replace the node's
  ///                   current `valuePattern`, if present.
  public func withValuePattern(_ newChild: PatternSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw ?? RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena)
    let newData = data.replacingChild(at: 3, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public var unexpectedAfterValuePattern: UnexpectedNodesSyntax? {
    get {
      let childData = data.child(at: 4, parent: Syntax(self))
      if childData == nil { return nil }
      return UnexpectedNodesSyntax(childData!)
    }
    set(value) {
      self = withUnexpectedAfterValuePattern(value)
    }
  }

  /// Returns a copy of the receiver with its `unexpectedAfterValuePattern` replaced.
  /// - param newChild: The new `unexpectedAfterValuePattern` to replace the node's
  ///                   current `unexpectedAfterValuePattern`, if present.
  public func withUnexpectedAfterValuePattern(_ newChild: UnexpectedNodesSyntax?) -> ValueBindingPatternSyntax {
    let arena = SyntaxArena()
    let raw = newChild?.raw
    let newData = data.replacingChild(at: 4, with: raw, arena: arena)
    return ValueBindingPatternSyntax(newData)
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([
      \Self.unexpectedBeforeLetOrVarKeyword,
      \Self.letOrVarKeyword,
      \Self.unexpectedBetweenLetOrVarKeywordAndValuePattern,
      \Self.valuePattern,
      \Self.unexpectedAfterValuePattern,
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

extension ValueBindingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unexpectedBeforeLetOrVarKeyword": unexpectedBeforeLetOrVarKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "unexpectedBetweenLetOrVarKeywordAndValuePattern": unexpectedBetweenLetOrVarKeywordAndValuePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "valuePattern": Syntax(valuePattern).asProtocol(SyntaxProtocol.self),
      "unexpectedAfterValuePattern": unexpectedAfterValuePattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

