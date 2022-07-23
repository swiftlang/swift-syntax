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

public struct UnknownPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawUnknownPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `UnknownPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `UnknownPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `UnknownPatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

extension UnknownPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - EnumCasePatternSyntax

public struct EnumCasePatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case type
    case period
    case caseName
    case associatedTuple
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawEnumCasePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `EnumCasePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `EnumCasePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `EnumCasePatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var type: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.type.rawValue)
      return childData.map { TypeSyntax(data: $0) }
    }
    set(value) {
      self = withType(value)
    }
  }
  public func withType(_ newChild: TypeSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.type.rawValue, with: newChildRaw, arena: arena)
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

  public var caseName: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseName.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withCaseName(value)
    }
  }
  public func withCaseName(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw

    let newRaw = raw.replacingChild(
      at: Cursor.caseName.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var associatedTuple: TuplePatternSyntax? {
    get {
      let childData = data.child(at: Cursor.associatedTuple.rawValue)
      return childData.map { TuplePatternSyntax(data: $0) }
    }
    set(value) {
      self = withAssociatedTuple(value)
    }
  }
  public func withAssociatedTuple(_ newChild: TuplePatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw

    let newRaw = raw.replacingChild(
      at: Cursor.associatedTuple.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension EnumCasePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "period": Syntax(period).asProtocol(SyntaxProtocol.self) as Any,
      "caseName": Syntax(caseName).asProtocol(SyntaxProtocol.self) as Any,
      "associatedTuple": associatedTuple.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IsTypePatternSyntax

public struct IsTypePatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case isKeyword
    case type
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIsTypePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IsTypePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IsTypePatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var isKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.isKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withIsKeyword(value)
    }
  }
  public func withIsKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .isKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.isKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

extension IsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "isKeyword": Syntax(isKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OptionalPatternSyntax

public struct OptionalPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case subPattern
    case questionMark
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawOptionalPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `OptionalPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `OptionalPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `OptionalPatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var subPattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.subPattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withSubPattern(value)
    }
  }
  public func withSubPattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.subPattern.rawValue, with: newChildRaw, arena: arena)
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

extension OptionalPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "subPattern": Syntax(subPattern).asProtocol(SyntaxProtocol.self) as Any,
      "questionMark": Syntax(questionMark).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IdentifierPatternSyntax

public struct IdentifierPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case identifier
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIdentifierPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IdentifierPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `IdentifierPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `IdentifierPatternSyntax` unsafely assuming `syntax` is valid.
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
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .selfKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.identifier.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension IdentifierPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AsTypePatternSyntax

public struct AsTypePatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case pattern
    case asKeyword
    case type
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAsTypePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AsTypePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `AsTypePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `AsTypePatternSyntax` unsafely assuming `syntax` is valid.
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

  public var asKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.asKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withAsKeyword(value)
    }
  }
  public func withAsKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .asKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.asKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
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

extension AsTypePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self) as Any,
      "asKeyword": Syntax(asKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TuplePatternSyntax

public struct TuplePatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case leftParen
    case elements
    case rightParen
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTuplePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TuplePatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `TuplePatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `TuplePatternSyntax` unsafely assuming `syntax` is valid.
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

  public var elements: TuplePatternElementListSyntax {
    get {
      let childData = data.child(at: Cursor.elements.rawValue)
      return TuplePatternElementListSyntax(data: childData!)
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
    if let col = raw.children[Cursor.elements.rawValue] {
      collection = col.appending(element.raw, arena: self.arena)
    } else {
      collection = RawSyntax.makeEmptyLayout(arena: arena, kind: .tuplePatternElementList)
    }
    let newRaw = raw.replacingChild(at: Cursor.elements.rawValue,
                                     with: collection, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
  public func withElements(_ newChild: TuplePatternElementListSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTuplePatternElementListSyntax.makeBlank(arena: arena).raw

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

extension TuplePatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WildcardPatternSyntax

public struct WildcardPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case wildcard
    case typeAnnotation
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawWildcardPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `WildcardPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `WildcardPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `WildcardPatternSyntax` unsafely assuming `syntax` is valid.
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
}

extension WildcardPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wildcard": Syntax(wildcard).asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ExpressionPatternSyntax

public struct ExpressionPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case expression
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawExpressionPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ExpressionPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ExpressionPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ExpressionPatternSyntax` unsafely assuming `syntax` is valid.
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

extension ExpressionPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ValueBindingPatternSyntax

public struct ValueBindingPatternSyntax: PatternSyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  enum Cursor: Int {
    case letOrVarKeyword
    case valuePattern
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawValueBindingPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ValueBindingPatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a `ValueBindingPatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  /// FIXME:
  /// Initialize `ValueBindingPatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.letOrVarKeyword.rawValue)
      return TokenSyntax(data: childData!)
    }
    set(value) {
      self = withLetOrVarKeyword(value)
    }
  }
  public func withLetOrVarKeyword(_ newChild: TokenSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawTokenSyntax.makeBlank(arena: arena, tokenKind: .letKeyword).raw

    let newRaw = raw.replacingChild(
      at: Cursor.letOrVarKeyword.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public var valuePattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.valuePattern.rawValue)
      return PatternSyntax(data: childData!)
    }
    set(value) {
      self = withValuePattern(value)
    }
  }
  public func withValuePattern(_ newChild: PatternSyntax?) -> Self {
    let newChildRaw = newChild?.raw
      ?? RawPatternSyntax.makeBlank(arena: arena).raw

    let newRaw = raw.replacingChild(
      at: Cursor.valuePattern.rawValue, with: newChildRaw, arena: arena)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension ValueBindingPatternSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self) as Any,
      "valuePattern": Syntax(valuePattern).asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}
