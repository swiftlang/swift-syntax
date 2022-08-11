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

public struct UnknownStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnknownStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknownStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnknownStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknownStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unknownStmt,
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

extension UnknownStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - MissingStmtSyntax

public struct MissingStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MissingStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .missingStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MissingStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .missingStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
  ) {
    let layout: [RawSyntax?] = [
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.missingStmt,
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

extension MissingStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
    ])
  }
}

// MARK: - LabeledStmtSyntax

public struct LabeledStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeLabelName
    case labelName
    case garbageBetweenLabelNameAndLabelColon
    case labelColon
    case garbageBetweenLabelColonAndStatement
    case statement
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `LabeledStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .labeledStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `LabeledStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .labeledStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeLabelName: GarbageNodesSyntax? = nil,
    labelName: TokenSyntax,
    _ garbageBetweenLabelNameAndLabelColon: GarbageNodesSyntax? = nil,
    labelColon: TokenSyntax,
    _ garbageBetweenLabelColonAndStatement: GarbageNodesSyntax? = nil,
    statement: StmtSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeLabelName?.raw,
      labelName.raw,
      garbageBetweenLabelNameAndLabelColon?.raw,
      labelColon.raw,
      garbageBetweenLabelColonAndStatement?.raw,
      statement.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.labeledStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeLabelName: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeLabelName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeLabelName(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeLabelName` replaced.
  /// - param newChild: The new `garbageBeforeLabelName` to replace the node's
  ///                   current `garbageBeforeLabelName`, if present.
  public func withGarbageBeforeLabelName(
    _ newChild: GarbageNodesSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeLabelName)
    return LabeledStmtSyntax(newData)
  }

  public var labelName: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.labelName,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabelName(value)
    }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return LabeledStmtSyntax(newData)
  }

  public var garbageBetweenLabelNameAndLabelColon: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLabelNameAndLabelColon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLabelNameAndLabelColon(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLabelNameAndLabelColon` replaced.
  /// - param newChild: The new `garbageBetweenLabelNameAndLabelColon` to replace the node's
  ///                   current `garbageBetweenLabelNameAndLabelColon`, if present.
  public func withGarbageBetweenLabelNameAndLabelColon(
    _ newChild: GarbageNodesSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLabelNameAndLabelColon)
    return LabeledStmtSyntax(newData)
  }

  public var labelColon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.labelColon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabelColon(value)
    }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return LabeledStmtSyntax(newData)
  }

  public var garbageBetweenLabelColonAndStatement: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLabelColonAndStatement,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLabelColonAndStatement(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLabelColonAndStatement` replaced.
  /// - param newChild: The new `garbageBetweenLabelColonAndStatement` to replace the node's
  ///                   current `garbageBetweenLabelColonAndStatement`, if present.
  public func withGarbageBetweenLabelColonAndStatement(
    _ newChild: GarbageNodesSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLabelColonAndStatement)
    return LabeledStmtSyntax(newData)
  }

  public var statement: StmtSyntax {
    get {
      let childData = data.child(at: Cursor.statement,
                                 parent: Syntax(self))
      return StmtSyntax(childData!)
    }
    set(value) {
      self = withStatement(value)
    }
  }

  /// Returns a copy of the receiver with its `statement` replaced.
  /// - param newChild: The new `statement` to replace the node's
  ///                   current `statement`, if present.
  public func withStatement(
    _ newChild: StmtSyntax?) -> LabeledStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingStmt)
    let newData = data.replacingChild(raw, at: Cursor.statement)
    return LabeledStmtSyntax(newData)
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
    // Check child #5 child is StmtSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(StmtSyntax.self))
    }
  }
}

extension LabeledStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeLabelName": garbageBeforeLabelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelName": Syntax(labelName).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLabelNameAndLabelColon": garbageBetweenLabelNameAndLabelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": Syntax(labelColon).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLabelColonAndStatement": garbageBetweenLabelColonAndStatement.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "statement": Syntax(statement).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ContinueStmtSyntax

public struct ContinueStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeContinueKeyword
    case continueKeyword
    case garbageBetweenContinueKeywordAndLabel
    case label
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ContinueStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .continueStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ContinueStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .continueStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeContinueKeyword: GarbageNodesSyntax? = nil,
    continueKeyword: TokenSyntax,
    _ garbageBetweenContinueKeywordAndLabel: GarbageNodesSyntax? = nil,
    label: TokenSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeContinueKeyword?.raw,
      continueKeyword.raw,
      garbageBetweenContinueKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.continueStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeContinueKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeContinueKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeContinueKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeContinueKeyword` replaced.
  /// - param newChild: The new `garbageBeforeContinueKeyword` to replace the node's
  ///                   current `garbageBeforeContinueKeyword`, if present.
  public func withGarbageBeforeContinueKeyword(
    _ newChild: GarbageNodesSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeContinueKeyword)
    return ContinueStmtSyntax(newData)
  }

  public var continueKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.continueKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withContinueKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `continueKeyword` replaced.
  /// - param newChild: The new `continueKeyword` to replace the node's
  ///                   current `continueKeyword`, if present.
  public func withContinueKeyword(
    _ newChild: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.continueKeyword)
    let newData = data.replacingChild(raw, at: Cursor.continueKeyword)
    return ContinueStmtSyntax(newData)
  }

  public var garbageBetweenContinueKeywordAndLabel: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenContinueKeywordAndLabel,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenContinueKeywordAndLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenContinueKeywordAndLabel` replaced.
  /// - param newChild: The new `garbageBetweenContinueKeywordAndLabel` to replace the node's
  ///                   current `garbageBetweenContinueKeywordAndLabel`, if present.
  public func withGarbageBetweenContinueKeywordAndLabel(
    _ newChild: GarbageNodesSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenContinueKeywordAndLabel)
    return ContinueStmtSyntax(newData)
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return ContinueStmtSyntax(newData)
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
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ContinueStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeContinueKeyword": garbageBeforeContinueKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "continueKeyword": Syntax(continueKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenContinueKeywordAndLabel": garbageBetweenContinueKeywordAndLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WhileStmtSyntax

public struct WhileStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeWhileKeyword
    case whileKeyword
    case garbageBetweenWhileKeywordAndConditions
    case conditions
    case garbageBetweenConditionsAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `WhileStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .whileStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `WhileStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .whileStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeWhileKeyword: GarbageNodesSyntax? = nil,
    whileKeyword: TokenSyntax,
    _ garbageBetweenWhileKeywordAndConditions: GarbageNodesSyntax? = nil,
    conditions: ConditionElementListSyntax,
    _ garbageBetweenConditionsAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeWhileKeyword?.raw,
      whileKeyword.raw,
      garbageBetweenWhileKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.whileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeWhileKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeWhileKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeWhileKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeWhileKeyword` replaced.
  /// - param newChild: The new `garbageBeforeWhileKeyword` to replace the node's
  ///                   current `garbageBeforeWhileKeyword`, if present.
  public func withGarbageBeforeWhileKeyword(
    _ newChild: GarbageNodesSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeWhileKeyword)
    return WhileStmtSyntax(newData)
  }

  public var whileKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whileKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWhileKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `whileKeyword` replaced.
  /// - param newChild: The new `whileKeyword` to replace the node's
  ///                   current `whileKeyword`, if present.
  public func withWhileKeyword(
    _ newChild: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whileKeyword)
    return WhileStmtSyntax(newData)
  }

  public var garbageBetweenWhileKeywordAndConditions: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWhileKeywordAndConditions,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWhileKeywordAndConditions(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWhileKeywordAndConditions` replaced.
  /// - param newChild: The new `garbageBetweenWhileKeywordAndConditions` to replace the node's
  ///                   current `garbageBetweenWhileKeywordAndConditions`, if present.
  public func withGarbageBetweenWhileKeywordAndConditions(
    _ newChild: GarbageNodesSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWhileKeywordAndConditions)
    return WhileStmtSyntax(newData)
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions,
                                 parent: Syntax(self))
      return ConditionElementListSyntax(childData!)
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
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return WhileStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return WhileStmtSyntax(newData)
  }

  public var garbageBetweenConditionsAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenConditionsAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenConditionsAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenConditionsAndBody` replaced.
  /// - param newChild: The new `garbageBetweenConditionsAndBody` to replace the node's
  ///                   current `garbageBetweenConditionsAndBody`, if present.
  public func withGarbageBetweenConditionsAndBody(
    _ newChild: GarbageNodesSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenConditionsAndBody)
    return WhileStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return WhileStmtSyntax(newData)
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
    // Check child #3 child is ConditionElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ConditionElementListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is CodeBlockSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension WhileStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeWhileKeyword": garbageBeforeWhileKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whileKeyword": Syntax(whileKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenWhileKeywordAndConditions": garbageBetweenWhileKeywordAndConditions.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self),
      "garbageBetweenConditionsAndBody": garbageBetweenConditionsAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DeferStmtSyntax

public struct DeferStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeDeferKeyword
    case deferKeyword
    case garbageBetweenDeferKeywordAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeferStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .deferStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeferStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .deferStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeDeferKeyword: GarbageNodesSyntax? = nil,
    deferKeyword: TokenSyntax,
    _ garbageBetweenDeferKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeDeferKeyword?.raw,
      deferKeyword.raw,
      garbageBetweenDeferKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deferStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeDeferKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeDeferKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeDeferKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeDeferKeyword` replaced.
  /// - param newChild: The new `garbageBeforeDeferKeyword` to replace the node's
  ///                   current `garbageBeforeDeferKeyword`, if present.
  public func withGarbageBeforeDeferKeyword(
    _ newChild: GarbageNodesSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeDeferKeyword)
    return DeferStmtSyntax(newData)
  }

  public var deferKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.deferKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDeferKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `deferKeyword` replaced.
  /// - param newChild: The new `deferKeyword` to replace the node's
  ///                   current `deferKeyword`, if present.
  public func withDeferKeyword(
    _ newChild: TokenSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.deferKeyword)
    let newData = data.replacingChild(raw, at: Cursor.deferKeyword)
    return DeferStmtSyntax(newData)
  }

  public var garbageBetweenDeferKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenDeferKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenDeferKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenDeferKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenDeferKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenDeferKeywordAndBody`, if present.
  public func withGarbageBetweenDeferKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenDeferKeywordAndBody)
    return DeferStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DeferStmtSyntax(newData)
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
    // Check child #3 child is CodeBlockSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension DeferStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeDeferKeyword": garbageBeforeDeferKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "deferKeyword": Syntax(deferKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenDeferKeywordAndBody": garbageBetweenDeferKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ExpressionStmtSyntax

public struct ExpressionStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ExpressionStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .expressionStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ExpressionStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionStmt,
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
    _ newChild: GarbageNodesSyntax?) -> ExpressionStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeExpression)
    return ExpressionStmtSyntax(newData)
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
    _ newChild: ExprSyntax?) -> ExpressionStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionStmtSyntax(newData)
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

extension ExpressionStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeExpression": garbageBeforeExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - RepeatWhileStmtSyntax

public struct RepeatWhileStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeRepeatKeyword
    case repeatKeyword
    case garbageBetweenRepeatKeywordAndBody
    case body
    case garbageBetweenBodyAndWhileKeyword
    case whileKeyword
    case garbageBetweenWhileKeywordAndCondition
    case condition
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `RepeatWhileStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .repeatWhileStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `RepeatWhileStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .repeatWhileStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeRepeatKeyword: GarbageNodesSyntax? = nil,
    repeatKeyword: TokenSyntax,
    _ garbageBetweenRepeatKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax,
    _ garbageBetweenBodyAndWhileKeyword: GarbageNodesSyntax? = nil,
    whileKeyword: TokenSyntax,
    _ garbageBetweenWhileKeywordAndCondition: GarbageNodesSyntax? = nil,
    condition: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeRepeatKeyword?.raw,
      repeatKeyword.raw,
      garbageBetweenRepeatKeywordAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndWhileKeyword?.raw,
      whileKeyword.raw,
      garbageBetweenWhileKeywordAndCondition?.raw,
      condition.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.repeatWhileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeRepeatKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeRepeatKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeRepeatKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeRepeatKeyword` replaced.
  /// - param newChild: The new `garbageBeforeRepeatKeyword` to replace the node's
  ///                   current `garbageBeforeRepeatKeyword`, if present.
  public func withGarbageBeforeRepeatKeyword(
    _ newChild: GarbageNodesSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeRepeatKeyword)
    return RepeatWhileStmtSyntax(newData)
  }

  public var repeatKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.repeatKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRepeatKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `repeatKeyword` replaced.
  /// - param newChild: The new `repeatKeyword` to replace the node's
  ///                   current `repeatKeyword`, if present.
  public func withRepeatKeyword(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.repeatKeyword)
    let newData = data.replacingChild(raw, at: Cursor.repeatKeyword)
    return RepeatWhileStmtSyntax(newData)
  }

  public var garbageBetweenRepeatKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenRepeatKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenRepeatKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenRepeatKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenRepeatKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenRepeatKeywordAndBody`, if present.
  public func withGarbageBetweenRepeatKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenRepeatKeywordAndBody)
    return RepeatWhileStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return RepeatWhileStmtSyntax(newData)
  }

  public var garbageBetweenBodyAndWhileKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBodyAndWhileKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBodyAndWhileKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBodyAndWhileKeyword` replaced.
  /// - param newChild: The new `garbageBetweenBodyAndWhileKeyword` to replace the node's
  ///                   current `garbageBetweenBodyAndWhileKeyword`, if present.
  public func withGarbageBetweenBodyAndWhileKeyword(
    _ newChild: GarbageNodesSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBodyAndWhileKeyword)
    return RepeatWhileStmtSyntax(newData)
  }

  public var whileKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whileKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWhileKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `whileKeyword` replaced.
  /// - param newChild: The new `whileKeyword` to replace the node's
  ///                   current `whileKeyword`, if present.
  public func withWhileKeyword(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whileKeyword)
    return RepeatWhileStmtSyntax(newData)
  }

  public var garbageBetweenWhileKeywordAndCondition: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWhileKeywordAndCondition,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWhileKeywordAndCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWhileKeywordAndCondition` replaced.
  /// - param newChild: The new `garbageBetweenWhileKeywordAndCondition` to replace the node's
  ///                   current `garbageBetweenWhileKeywordAndCondition`, if present.
  public func withGarbageBetweenWhileKeywordAndCondition(
    _ newChild: GarbageNodesSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWhileKeywordAndCondition)
    return RepeatWhileStmtSyntax(newData)
  }

  public var condition: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.condition,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: ExprSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return RepeatWhileStmtSyntax(newData)
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
    // Check child #3 child is CodeBlockSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
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
    // Check child #7 child is ExprSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension RepeatWhileStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeRepeatKeyword": garbageBeforeRepeatKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "repeatKeyword": Syntax(repeatKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenRepeatKeywordAndBody": garbageBetweenRepeatKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBodyAndWhileKeyword": garbageBetweenBodyAndWhileKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whileKeyword": Syntax(whileKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenWhileKeywordAndCondition": garbageBetweenWhileKeywordAndCondition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - GuardStmtSyntax

public struct GuardStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeGuardKeyword
    case guardKeyword
    case garbageBetweenGuardKeywordAndConditions
    case conditions
    case garbageBetweenConditionsAndElseKeyword
    case elseKeyword
    case garbageBetweenElseKeywordAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GuardStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .guardStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GuardStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .guardStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeGuardKeyword: GarbageNodesSyntax? = nil,
    guardKeyword: TokenSyntax,
    _ garbageBetweenGuardKeywordAndConditions: GarbageNodesSyntax? = nil,
    conditions: ConditionElementListSyntax,
    _ garbageBetweenConditionsAndElseKeyword: GarbageNodesSyntax? = nil,
    elseKeyword: TokenSyntax,
    _ garbageBetweenElseKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeGuardKeyword?.raw,
      guardKeyword.raw,
      garbageBetweenGuardKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndElseKeyword?.raw,
      elseKeyword.raw,
      garbageBetweenElseKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.guardStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeGuardKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeGuardKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeGuardKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeGuardKeyword` replaced.
  /// - param newChild: The new `garbageBeforeGuardKeyword` to replace the node's
  ///                   current `garbageBeforeGuardKeyword`, if present.
  public func withGarbageBeforeGuardKeyword(
    _ newChild: GarbageNodesSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeGuardKeyword)
    return GuardStmtSyntax(newData)
  }

  public var guardKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.guardKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withGuardKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `guardKeyword` replaced.
  /// - param newChild: The new `guardKeyword` to replace the node's
  ///                   current `guardKeyword`, if present.
  public func withGuardKeyword(
    _ newChild: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.guardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.guardKeyword)
    return GuardStmtSyntax(newData)
  }

  public var garbageBetweenGuardKeywordAndConditions: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenGuardKeywordAndConditions,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenGuardKeywordAndConditions(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenGuardKeywordAndConditions` replaced.
  /// - param newChild: The new `garbageBetweenGuardKeywordAndConditions` to replace the node's
  ///                   current `garbageBetweenGuardKeywordAndConditions`, if present.
  public func withGarbageBetweenGuardKeywordAndConditions(
    _ newChild: GarbageNodesSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenGuardKeywordAndConditions)
    return GuardStmtSyntax(newData)
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions,
                                 parent: Syntax(self))
      return ConditionElementListSyntax(childData!)
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
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return GuardStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return GuardStmtSyntax(newData)
  }

  public var garbageBetweenConditionsAndElseKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenConditionsAndElseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenConditionsAndElseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenConditionsAndElseKeyword` replaced.
  /// - param newChild: The new `garbageBetweenConditionsAndElseKeyword` to replace the node's
  ///                   current `garbageBetweenConditionsAndElseKeyword`, if present.
  public func withGarbageBetweenConditionsAndElseKeyword(
    _ newChild: GarbageNodesSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenConditionsAndElseKeyword)
    return GuardStmtSyntax(newData)
  }

  public var elseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.elseKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withElseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `elseKeyword` replaced.
  /// - param newChild: The new `elseKeyword` to replace the node's
  ///                   current `elseKeyword`, if present.
  public func withElseKeyword(
    _ newChild: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.elseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.elseKeyword)
    return GuardStmtSyntax(newData)
  }

  public var garbageBetweenElseKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElseKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElseKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElseKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenElseKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenElseKeywordAndBody`, if present.
  public func withGarbageBetweenElseKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElseKeywordAndBody)
    return GuardStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return GuardStmtSyntax(newData)
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
    // Check child #3 child is ConditionElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ConditionElementListSyntax.self))
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
    // Check child #7 child is CodeBlockSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension GuardStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeGuardKeyword": garbageBeforeGuardKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "guardKeyword": Syntax(guardKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenGuardKeywordAndConditions": garbageBetweenGuardKeywordAndConditions.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self),
      "garbageBetweenConditionsAndElseKeyword": garbageBetweenConditionsAndElseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elseKeyword": Syntax(elseKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenElseKeywordAndBody": garbageBetweenElseKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ForInStmtSyntax

public struct ForInStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeForKeyword
    case forKeyword
    case garbageBetweenForKeywordAndTryKeyword
    case tryKeyword
    case garbageBetweenTryKeywordAndAwaitKeyword
    case awaitKeyword
    case garbageBetweenAwaitKeywordAndCaseKeyword
    case caseKeyword
    case garbageBetweenCaseKeywordAndPattern
    case pattern
    case garbageBetweenPatternAndTypeAnnotation
    case typeAnnotation
    case garbageBetweenTypeAnnotationAndInKeyword
    case inKeyword
    case garbageBetweenInKeywordAndSequenceExpr
    case sequenceExpr
    case garbageBetweenSequenceExprAndWhereClause
    case whereClause
    case garbageBetweenWhereClauseAndBody
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ForInStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .forInStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ForInStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .forInStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeForKeyword: GarbageNodesSyntax? = nil,
    forKeyword: TokenSyntax,
    _ garbageBetweenForKeywordAndTryKeyword: GarbageNodesSyntax? = nil,
    tryKeyword: TokenSyntax?,
    _ garbageBetweenTryKeywordAndAwaitKeyword: GarbageNodesSyntax? = nil,
    awaitKeyword: TokenSyntax?,
    _ garbageBetweenAwaitKeywordAndCaseKeyword: GarbageNodesSyntax? = nil,
    caseKeyword: TokenSyntax?,
    _ garbageBetweenCaseKeywordAndPattern: GarbageNodesSyntax? = nil,
    pattern: PatternSyntax,
    _ garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax?,
    _ garbageBetweenTypeAnnotationAndInKeyword: GarbageNodesSyntax? = nil,
    inKeyword: TokenSyntax,
    _ garbageBetweenInKeywordAndSequenceExpr: GarbageNodesSyntax? = nil,
    sequenceExpr: ExprSyntax,
    _ garbageBetweenSequenceExprAndWhereClause: GarbageNodesSyntax? = nil,
    whereClause: WhereClauseSyntax?,
    _ garbageBetweenWhereClauseAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeForKeyword?.raw,
      forKeyword.raw,
      garbageBetweenForKeywordAndTryKeyword?.raw,
      tryKeyword?.raw,
      garbageBetweenTryKeywordAndAwaitKeyword?.raw,
      awaitKeyword?.raw,
      garbageBetweenAwaitKeywordAndCaseKeyword?.raw,
      caseKeyword?.raw,
      garbageBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      garbageBetweenTypeAnnotationAndInKeyword?.raw,
      inKeyword.raw,
      garbageBetweenInKeywordAndSequenceExpr?.raw,
      sequenceExpr.raw,
      garbageBetweenSequenceExprAndWhereClause?.raw,
      whereClause?.raw,
      garbageBetweenWhereClauseAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forInStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeForKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeForKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeForKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeForKeyword` replaced.
  /// - param newChild: The new `garbageBeforeForKeyword` to replace the node's
  ///                   current `garbageBeforeForKeyword`, if present.
  public func withGarbageBeforeForKeyword(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeForKeyword)
    return ForInStmtSyntax(newData)
  }

  public var forKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.forKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withForKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `forKeyword` replaced.
  /// - param newChild: The new `forKeyword` to replace the node's
  ///                   current `forKeyword`, if present.
  public func withForKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.forKeyword)
    let newData = data.replacingChild(raw, at: Cursor.forKeyword)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenForKeywordAndTryKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenForKeywordAndTryKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenForKeywordAndTryKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenForKeywordAndTryKeyword` replaced.
  /// - param newChild: The new `garbageBetweenForKeywordAndTryKeyword` to replace the node's
  ///                   current `garbageBetweenForKeywordAndTryKeyword`, if present.
  public func withGarbageBetweenForKeywordAndTryKeyword(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenForKeywordAndTryKeyword)
    return ForInStmtSyntax(newData)
  }

  public var tryKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.tryKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
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
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.tryKeyword)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenTryKeywordAndAwaitKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTryKeywordAndAwaitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTryKeywordAndAwaitKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTryKeywordAndAwaitKeyword` replaced.
  /// - param newChild: The new `garbageBetweenTryKeywordAndAwaitKeyword` to replace the node's
  ///                   current `garbageBetweenTryKeywordAndAwaitKeyword`, if present.
  public func withGarbageBetweenTryKeywordAndAwaitKeyword(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTryKeywordAndAwaitKeyword)
    return ForInStmtSyntax(newData)
  }

  public var awaitKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.awaitKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
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
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.awaitKeyword)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenAwaitKeywordAndCaseKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenAwaitKeywordAndCaseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenAwaitKeywordAndCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenAwaitKeywordAndCaseKeyword` replaced.
  /// - param newChild: The new `garbageBetweenAwaitKeywordAndCaseKeyword` to replace the node's
  ///                   current `garbageBetweenAwaitKeywordAndCaseKeyword`, if present.
  public func withGarbageBetweenAwaitKeywordAndCaseKeyword(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenAwaitKeywordAndCaseKeyword)
    return ForInStmtSyntax(newData)
  }

  public var caseKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.caseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withCaseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenCaseKeywordAndPattern: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCaseKeywordAndPattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCaseKeywordAndPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCaseKeywordAndPattern` replaced.
  /// - param newChild: The new `garbageBetweenCaseKeywordAndPattern` to replace the node's
  ///                   current `garbageBetweenCaseKeywordAndPattern`, if present.
  public func withGarbageBetweenCaseKeywordAndPattern(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCaseKeywordAndPattern)
    return ForInStmtSyntax(newData)
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
    _ newChild: PatternSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingPattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPatternAndTypeAnnotation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPatternAndTypeAnnotation(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPatternAndTypeAnnotation` replaced.
  /// - param newChild: The new `garbageBetweenPatternAndTypeAnnotation` to replace the node's
  ///                   current `garbageBetweenPatternAndTypeAnnotation`, if present.
  public func withGarbageBetweenPatternAndTypeAnnotation(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPatternAndTypeAnnotation)
    return ForInStmtSyntax(newData)
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
    _ newChild: TypeAnnotationSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenTypeAnnotationAndInKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenTypeAnnotationAndInKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenTypeAnnotationAndInKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenTypeAnnotationAndInKeyword` replaced.
  /// - param newChild: The new `garbageBetweenTypeAnnotationAndInKeyword` to replace the node's
  ///                   current `garbageBetweenTypeAnnotationAndInKeyword`, if present.
  public func withGarbageBetweenTypeAnnotationAndInKeyword(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenTypeAnnotationAndInKeyword)
    return ForInStmtSyntax(newData)
  }

  public var inKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.inKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withInKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `inKeyword` replaced.
  /// - param newChild: The new `inKeyword` to replace the node's
  ///                   current `inKeyword`, if present.
  public func withInKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.inKeyword)
    let newData = data.replacingChild(raw, at: Cursor.inKeyword)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenInKeywordAndSequenceExpr: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenInKeywordAndSequenceExpr,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenInKeywordAndSequenceExpr(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenInKeywordAndSequenceExpr` replaced.
  /// - param newChild: The new `garbageBetweenInKeywordAndSequenceExpr` to replace the node's
  ///                   current `garbageBetweenInKeywordAndSequenceExpr`, if present.
  public func withGarbageBetweenInKeywordAndSequenceExpr(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenInKeywordAndSequenceExpr)
    return ForInStmtSyntax(newData)
  }

  public var sequenceExpr: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.sequenceExpr,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withSequenceExpr(value)
    }
  }

  /// Returns a copy of the receiver with its `sequenceExpr` replaced.
  /// - param newChild: The new `sequenceExpr` to replace the node's
  ///                   current `sequenceExpr`, if present.
  public func withSequenceExpr(
    _ newChild: ExprSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.sequenceExpr)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenSequenceExprAndWhereClause: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSequenceExprAndWhereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSequenceExprAndWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSequenceExprAndWhereClause` replaced.
  /// - param newChild: The new `garbageBetweenSequenceExprAndWhereClause` to replace the node's
  ///                   current `garbageBetweenSequenceExprAndWhereClause`, if present.
  public func withGarbageBetweenSequenceExprAndWhereClause(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSequenceExprAndWhereClause)
    return ForInStmtSyntax(newData)
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return WhereClauseSyntax(childData!)
    }
    set(value) {
      self = withWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: WhereClauseSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return ForInStmtSyntax(newData)
  }

  public var garbageBetweenWhereClauseAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenWhereClauseAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenWhereClauseAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenWhereClauseAndBody` replaced.
  /// - param newChild: The new `garbageBetweenWhereClauseAndBody` to replace the node's
  ///                   current `garbageBetweenWhereClauseAndBody`, if present.
  public func withGarbageBetweenWhereClauseAndBody(
    _ newChild: GarbageNodesSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenWhereClauseAndBody)
    return ForInStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return ForInStmtSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 20)
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
    // Check child #9 child is PatternSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #10 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[10].raw {
      let info = rawChildren[10].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #11 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[11].raw {
      let info = rawChildren[11].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeAnnotationSyntax.self))
    }
    // Check child #12 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[12].raw {
      let info = rawChildren[12].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #13 child is TokenSyntax 
    assert(rawChildren[13].raw != nil)
    if let raw = rawChildren[13].raw {
      let info = rawChildren[13].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #14 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[14].raw {
      let info = rawChildren[14].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #15 child is ExprSyntax 
    assert(rawChildren[15].raw != nil)
    if let raw = rawChildren[15].raw {
      let info = rawChildren[15].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #16 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[16].raw {
      let info = rawChildren[16].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #17 child is WhereClauseSyntax or missing
    if let raw = rawChildren[17].raw {
      let info = rawChildren[17].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(WhereClauseSyntax.self))
    }
    // Check child #18 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[18].raw {
      let info = rawChildren[18].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #19 child is CodeBlockSyntax 
    assert(rawChildren[19].raw != nil)
    if let raw = rawChildren[19].raw {
      let info = rawChildren[19].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension ForInStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeForKeyword": garbageBeforeForKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "forKeyword": Syntax(forKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenForKeywordAndTryKeyword": garbageBetweenForKeywordAndTryKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "tryKeyword": tryKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenTryKeywordAndAwaitKeyword": garbageBetweenTryKeywordAndAwaitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "awaitKeyword": awaitKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenAwaitKeywordAndCaseKeyword": garbageBetweenAwaitKeywordAndCaseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "caseKeyword": caseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenCaseKeywordAndPattern": garbageBetweenCaseKeywordAndPattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPatternAndTypeAnnotation": garbageBetweenPatternAndTypeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenTypeAnnotationAndInKeyword": garbageBetweenTypeAnnotationAndInKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inKeyword": Syntax(inKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenInKeywordAndSequenceExpr": garbageBetweenInKeywordAndSequenceExpr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "sequenceExpr": Syntax(sequenceExpr).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSequenceExprAndWhereClause": garbageBetweenSequenceExprAndWhereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenWhereClauseAndBody": garbageBetweenWhereClauseAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SwitchStmtSyntax

public struct SwitchStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeSwitchKeyword
    case switchKeyword
    case garbageBetweenSwitchKeywordAndExpression
    case expression
    case garbageBetweenExpressionAndLeftBrace
    case leftBrace
    case garbageBetweenLeftBraceAndCases
    case cases
    case garbageBetweenCasesAndRightBrace
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SwitchStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .switchStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SwitchStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeSwitchKeyword: GarbageNodesSyntax? = nil,
    switchKeyword: TokenSyntax,
    _ garbageBetweenSwitchKeywordAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax,
    _ garbageBetweenExpressionAndLeftBrace: GarbageNodesSyntax? = nil,
    leftBrace: TokenSyntax,
    _ garbageBetweenLeftBraceAndCases: GarbageNodesSyntax? = nil,
    cases: SwitchCaseListSyntax,
    _ garbageBetweenCasesAndRightBrace: GarbageNodesSyntax? = nil,
    rightBrace: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeSwitchKeyword?.raw,
      switchKeyword.raw,
      garbageBetweenSwitchKeywordAndExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndCases?.raw,
      cases.raw,
      garbageBetweenCasesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeSwitchKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeSwitchKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeSwitchKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeSwitchKeyword` replaced.
  /// - param newChild: The new `garbageBeforeSwitchKeyword` to replace the node's
  ///                   current `garbageBeforeSwitchKeyword`, if present.
  public func withGarbageBeforeSwitchKeyword(
    _ newChild: GarbageNodesSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeSwitchKeyword)
    return SwitchStmtSyntax(newData)
  }

  public var switchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.switchKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSwitchKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `switchKeyword` replaced.
  /// - param newChild: The new `switchKeyword` to replace the node's
  ///                   current `switchKeyword`, if present.
  public func withSwitchKeyword(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.switchKeyword)
    let newData = data.replacingChild(raw, at: Cursor.switchKeyword)
    return SwitchStmtSyntax(newData)
  }

  public var garbageBetweenSwitchKeywordAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenSwitchKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenSwitchKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenSwitchKeywordAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenSwitchKeywordAndExpression` to replace the node's
  ///                   current `garbageBetweenSwitchKeywordAndExpression`, if present.
  public func withGarbageBetweenSwitchKeywordAndExpression(
    _ newChild: GarbageNodesSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenSwitchKeywordAndExpression)
    return SwitchStmtSyntax(newData)
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
    _ newChild: ExprSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return SwitchStmtSyntax(newData)
  }

  public var garbageBetweenExpressionAndLeftBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenExpressionAndLeftBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenExpressionAndLeftBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenExpressionAndLeftBrace` replaced.
  /// - param newChild: The new `garbageBetweenExpressionAndLeftBrace` to replace the node's
  ///                   current `garbageBetweenExpressionAndLeftBrace`, if present.
  public func withGarbageBetweenExpressionAndLeftBrace(
    _ newChild: GarbageNodesSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenExpressionAndLeftBrace)
    return SwitchStmtSyntax(newData)
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
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return SwitchStmtSyntax(newData)
  }

  public var garbageBetweenLeftBraceAndCases: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftBraceAndCases,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftBraceAndCases(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftBraceAndCases` replaced.
  /// - param newChild: The new `garbageBetweenLeftBraceAndCases` to replace the node's
  ///                   current `garbageBetweenLeftBraceAndCases`, if present.
  public func withGarbageBetweenLeftBraceAndCases(
    _ newChild: GarbageNodesSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftBraceAndCases)
    return SwitchStmtSyntax(newData)
  }

  public var cases: SwitchCaseListSyntax {
    get {
      let childData = data.child(at: Cursor.cases,
                                 parent: Syntax(self))
      return SwitchCaseListSyntax(childData!)
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
    if let col = raw[Cursor.cases] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.switchCaseList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.cases)
    return SwitchStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `cases` replaced.
  /// - param newChild: The new `cases` to replace the node's
  ///                   current `cases`, if present.
  public func withCases(
    _ newChild: SwitchCaseListSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.switchCaseList)
    let newData = data.replacingChild(raw, at: Cursor.cases)
    return SwitchStmtSyntax(newData)
  }

  public var garbageBetweenCasesAndRightBrace: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCasesAndRightBrace,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCasesAndRightBrace(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCasesAndRightBrace` replaced.
  /// - param newChild: The new `garbageBetweenCasesAndRightBrace` to replace the node's
  ///                   current `garbageBetweenCasesAndRightBrace`, if present.
  public func withGarbageBetweenCasesAndRightBrace(
    _ newChild: GarbageNodesSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCasesAndRightBrace)
    return SwitchStmtSyntax(newData)
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
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return SwitchStmtSyntax(newData)
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
    // Check child #7 child is SwitchCaseListSyntax 
    assert(rawChildren[7].raw != nil)
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(SwitchCaseListSyntax.self))
    }
    // Check child #8 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[8].raw {
      let info = rawChildren[8].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #9 child is TokenSyntax 
    assert(rawChildren[9].raw != nil)
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension SwitchStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeSwitchKeyword": garbageBeforeSwitchKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "switchKeyword": Syntax(switchKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenSwitchKeywordAndExpression": garbageBetweenSwitchKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "garbageBetweenExpressionAndLeftBrace": garbageBetweenExpressionAndLeftBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftBraceAndCases": garbageBetweenLeftBraceAndCases.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "cases": Syntax(cases).asProtocol(SyntaxProtocol.self),
      "garbageBetweenCasesAndRightBrace": garbageBetweenCasesAndRightBrace.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DoStmtSyntax

public struct DoStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeDoKeyword
    case doKeyword
    case garbageBetweenDoKeywordAndBody
    case body
    case garbageBetweenBodyAndCatchClauses
    case catchClauses
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DoStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .doStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DoStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .doStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeDoKeyword: GarbageNodesSyntax? = nil,
    doKeyword: TokenSyntax,
    _ garbageBetweenDoKeywordAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax,
    _ garbageBetweenBodyAndCatchClauses: GarbageNodesSyntax? = nil,
    catchClauses: CatchClauseListSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeDoKeyword?.raw,
      doKeyword.raw,
      garbageBetweenDoKeywordAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndCatchClauses?.raw,
      catchClauses?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.doStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeDoKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeDoKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeDoKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeDoKeyword` replaced.
  /// - param newChild: The new `garbageBeforeDoKeyword` to replace the node's
  ///                   current `garbageBeforeDoKeyword`, if present.
  public func withGarbageBeforeDoKeyword(
    _ newChild: GarbageNodesSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeDoKeyword)
    return DoStmtSyntax(newData)
  }

  public var doKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.doKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDoKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `doKeyword` replaced.
  /// - param newChild: The new `doKeyword` to replace the node's
  ///                   current `doKeyword`, if present.
  public func withDoKeyword(
    _ newChild: TokenSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.doKeyword)
    let newData = data.replacingChild(raw, at: Cursor.doKeyword)
    return DoStmtSyntax(newData)
  }

  public var garbageBetweenDoKeywordAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenDoKeywordAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenDoKeywordAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenDoKeywordAndBody` replaced.
  /// - param newChild: The new `garbageBetweenDoKeywordAndBody` to replace the node's
  ///                   current `garbageBetweenDoKeywordAndBody`, if present.
  public func withGarbageBetweenDoKeywordAndBody(
    _ newChild: GarbageNodesSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenDoKeywordAndBody)
    return DoStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DoStmtSyntax(newData)
  }

  public var garbageBetweenBodyAndCatchClauses: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBodyAndCatchClauses,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBodyAndCatchClauses(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBodyAndCatchClauses` replaced.
  /// - param newChild: The new `garbageBetweenBodyAndCatchClauses` to replace the node's
  ///                   current `garbageBetweenBodyAndCatchClauses`, if present.
  public func withGarbageBetweenBodyAndCatchClauses(
    _ newChild: GarbageNodesSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBodyAndCatchClauses)
    return DoStmtSyntax(newData)
  }

  public var catchClauses: CatchClauseListSyntax? {
    get {
      let childData = data.child(at: Cursor.catchClauses,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return CatchClauseListSyntax(childData!)
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
    if let col = raw[Cursor.catchClauses] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.catchClauseList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.catchClauses)
    return DoStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `catchClauses` replaced.
  /// - param newChild: The new `catchClauses` to replace the node's
  ///                   current `catchClauses`, if present.
  public func withCatchClauses(
    _ newChild: CatchClauseListSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.catchClauses)
    return DoStmtSyntax(newData)
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
    // Check child #3 child is CodeBlockSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is CatchClauseListSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CatchClauseListSyntax.self))
    }
  }
}

extension DoStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeDoKeyword": garbageBeforeDoKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "doKeyword": Syntax(doKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenDoKeywordAndBody": garbageBetweenDoKeywordAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBodyAndCatchClauses": garbageBetweenBodyAndCatchClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "catchClauses": catchClauses.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ReturnStmtSyntax

public struct ReturnStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeReturnKeyword
    case returnKeyword
    case garbageBetweenReturnKeywordAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ReturnStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .returnStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ReturnStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .returnStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeReturnKeyword: GarbageNodesSyntax? = nil,
    returnKeyword: TokenSyntax,
    _ garbageBetweenReturnKeywordAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeReturnKeyword?.raw,
      returnKeyword.raw,
      garbageBetweenReturnKeywordAndExpression?.raw,
      expression?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.returnStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeReturnKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeReturnKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeReturnKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeReturnKeyword` replaced.
  /// - param newChild: The new `garbageBeforeReturnKeyword` to replace the node's
  ///                   current `garbageBeforeReturnKeyword`, if present.
  public func withGarbageBeforeReturnKeyword(
    _ newChild: GarbageNodesSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeReturnKeyword)
    return ReturnStmtSyntax(newData)
  }

  public var returnKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.returnKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withReturnKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `returnKeyword` replaced.
  /// - param newChild: The new `returnKeyword` to replace the node's
  ///                   current `returnKeyword`, if present.
  public func withReturnKeyword(
    _ newChild: TokenSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.returnKeyword)
    let newData = data.replacingChild(raw, at: Cursor.returnKeyword)
    return ReturnStmtSyntax(newData)
  }

  public var garbageBetweenReturnKeywordAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenReturnKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenReturnKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenReturnKeywordAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenReturnKeywordAndExpression` to replace the node's
  ///                   current `garbageBetweenReturnKeywordAndExpression`, if present.
  public func withGarbageBetweenReturnKeywordAndExpression(
    _ newChild: GarbageNodesSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenReturnKeywordAndExpression)
    return ReturnStmtSyntax(newData)
  }

  public var expression: ExprSyntax? {
    get {
      let childData = data.child(at: Cursor.expression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
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
    _ newChild: ExprSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ReturnStmtSyntax(newData)
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
    // Check child #3 child is ExprSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension ReturnStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeReturnKeyword": garbageBeforeReturnKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "returnKeyword": Syntax(returnKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenReturnKeywordAndExpression": garbageBetweenReturnKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": expression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - YieldStmtSyntax

public struct YieldStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeYieldKeyword
    case yieldKeyword
    case garbageBetweenYieldKeywordAndYields
    case yields
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `YieldStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .yieldStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `YieldStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeYieldKeyword: GarbageNodesSyntax? = nil,
    yieldKeyword: TokenSyntax,
    _ garbageBetweenYieldKeywordAndYields: GarbageNodesSyntax? = nil,
    yields: Syntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeYieldKeyword?.raw,
      yieldKeyword.raw,
      garbageBetweenYieldKeywordAndYields?.raw,
      yields.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.yieldStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeYieldKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeYieldKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeYieldKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeYieldKeyword` replaced.
  /// - param newChild: The new `garbageBeforeYieldKeyword` to replace the node's
  ///                   current `garbageBeforeYieldKeyword`, if present.
  public func withGarbageBeforeYieldKeyword(
    _ newChild: GarbageNodesSyntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeYieldKeyword)
    return YieldStmtSyntax(newData)
  }

  public var yieldKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.yieldKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withYieldKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `yieldKeyword` replaced.
  /// - param newChild: The new `yieldKeyword` to replace the node's
  ///                   current `yieldKeyword`, if present.
  public func withYieldKeyword(
    _ newChild: TokenSyntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.yield)
    let newData = data.replacingChild(raw, at: Cursor.yieldKeyword)
    return YieldStmtSyntax(newData)
  }

  public var garbageBetweenYieldKeywordAndYields: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenYieldKeywordAndYields,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenYieldKeywordAndYields(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenYieldKeywordAndYields` replaced.
  /// - param newChild: The new `garbageBetweenYieldKeywordAndYields` to replace the node's
  ///                   current `garbageBetweenYieldKeywordAndYields`, if present.
  public func withGarbageBetweenYieldKeywordAndYields(
    _ newChild: GarbageNodesSyntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenYieldKeywordAndYields)
    return YieldStmtSyntax(newData)
  }

  public var yields: Syntax {
    get {
      let childData = data.child(at: Cursor.yields,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withYields(value)
    }
  }

  /// Returns a copy of the receiver with its `yields` replaced.
  /// - param newChild: The new `yields` to replace the node's
  ///                   current `yields`, if present.
  public func withYields(
    _ newChild: Syntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.yields)
    return YieldStmtSyntax(newData)
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
    // Check child #3 child is Syntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension YieldStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeYieldKeyword": garbageBeforeYieldKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "yieldKeyword": Syntax(yieldKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenYieldKeywordAndYields": garbageBetweenYieldKeywordAndYields.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "yields": Syntax(yields).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FallthroughStmtSyntax

public struct FallthroughStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeFallthroughKeyword
    case fallthroughKeyword
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FallthroughStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .fallthroughStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FallthroughStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .fallthroughStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeFallthroughKeyword: GarbageNodesSyntax? = nil,
    fallthroughKeyword: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeFallthroughKeyword?.raw,
      fallthroughKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.fallthroughStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeFallthroughKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeFallthroughKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeFallthroughKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeFallthroughKeyword` replaced.
  /// - param newChild: The new `garbageBeforeFallthroughKeyword` to replace the node's
  ///                   current `garbageBeforeFallthroughKeyword`, if present.
  public func withGarbageBeforeFallthroughKeyword(
    _ newChild: GarbageNodesSyntax?) -> FallthroughStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeFallthroughKeyword)
    return FallthroughStmtSyntax(newData)
  }

  public var fallthroughKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fallthroughKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withFallthroughKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `fallthroughKeyword` replaced.
  /// - param newChild: The new `fallthroughKeyword` to replace the node's
  ///                   current `fallthroughKeyword`, if present.
  public func withFallthroughKeyword(
    _ newChild: TokenSyntax?) -> FallthroughStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.fallthroughKeyword)
    let newData = data.replacingChild(raw, at: Cursor.fallthroughKeyword)
    return FallthroughStmtSyntax(newData)
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

extension FallthroughStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeFallthroughKeyword": garbageBeforeFallthroughKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "fallthroughKeyword": Syntax(fallthroughKeyword).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BreakStmtSyntax

public struct BreakStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeBreakKeyword
    case breakKeyword
    case garbageBetweenBreakKeywordAndLabel
    case label
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `BreakStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .breakStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `BreakStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .breakStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeBreakKeyword: GarbageNodesSyntax? = nil,
    breakKeyword: TokenSyntax,
    _ garbageBetweenBreakKeywordAndLabel: GarbageNodesSyntax? = nil,
    label: TokenSyntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeBreakKeyword?.raw,
      breakKeyword.raw,
      garbageBetweenBreakKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.breakStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeBreakKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeBreakKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeBreakKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeBreakKeyword` replaced.
  /// - param newChild: The new `garbageBeforeBreakKeyword` to replace the node's
  ///                   current `garbageBeforeBreakKeyword`, if present.
  public func withGarbageBeforeBreakKeyword(
    _ newChild: GarbageNodesSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeBreakKeyword)
    return BreakStmtSyntax(newData)
  }

  public var breakKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.breakKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withBreakKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `breakKeyword` replaced.
  /// - param newChild: The new `breakKeyword` to replace the node's
  ///                   current `breakKeyword`, if present.
  public func withBreakKeyword(
    _ newChild: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.breakKeyword)
    let newData = data.replacingChild(raw, at: Cursor.breakKeyword)
    return BreakStmtSyntax(newData)
  }

  public var garbageBetweenBreakKeywordAndLabel: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBreakKeywordAndLabel,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBreakKeywordAndLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBreakKeywordAndLabel` replaced.
  /// - param newChild: The new `garbageBetweenBreakKeywordAndLabel` to replace the node's
  ///                   current `garbageBetweenBreakKeywordAndLabel`, if present.
  public func withGarbageBetweenBreakKeywordAndLabel(
    _ newChild: GarbageNodesSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBreakKeywordAndLabel)
    return BreakStmtSyntax(newData)
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return BreakStmtSyntax(newData)
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
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension BreakStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeBreakKeyword": garbageBeforeBreakKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "breakKeyword": Syntax(breakKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBreakKeywordAndLabel": garbageBetweenBreakKeywordAndLabel.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DeclarationStmtSyntax

public struct DeclarationStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeDeclaration
    case declaration
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclarationStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declarationStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclarationStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declarationStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeDeclaration: GarbageNodesSyntax? = nil,
    declaration: DeclSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeDeclaration?.raw,
      declaration.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declarationStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeDeclaration: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeDeclaration,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeDeclaration(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeDeclaration` replaced.
  /// - param newChild: The new `garbageBeforeDeclaration` to replace the node's
  ///                   current `garbageBeforeDeclaration`, if present.
  public func withGarbageBeforeDeclaration(
    _ newChild: GarbageNodesSyntax?) -> DeclarationStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeDeclaration)
    return DeclarationStmtSyntax(newData)
  }

  public var declaration: DeclSyntax {
    get {
      let childData = data.child(at: Cursor.declaration,
                                 parent: Syntax(self))
      return DeclSyntax(childData!)
    }
    set(value) {
      self = withDeclaration(value)
    }
  }

  /// Returns a copy of the receiver with its `declaration` replaced.
  /// - param newChild: The new `declaration` to replace the node's
  ///                   current `declaration`, if present.
  public func withDeclaration(
    _ newChild: DeclSyntax?) -> DeclarationStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingDecl)
    let newData = data.replacingChild(raw, at: Cursor.declaration)
    return DeclarationStmtSyntax(newData)
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
    // Check child #1 child is DeclSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclSyntax.self))
    }
  }
}

extension DeclarationStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeDeclaration": garbageBeforeDeclaration.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "declaration": Syntax(declaration).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ThrowStmtSyntax

public struct ThrowStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeThrowKeyword
    case throwKeyword
    case garbageBetweenThrowKeywordAndExpression
    case expression
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ThrowStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .throwStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ThrowStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .throwStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeThrowKeyword: GarbageNodesSyntax? = nil,
    throwKeyword: TokenSyntax,
    _ garbageBetweenThrowKeywordAndExpression: GarbageNodesSyntax? = nil,
    expression: ExprSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeThrowKeyword?.raw,
      throwKeyword.raw,
      garbageBetweenThrowKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.throwStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeThrowKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeThrowKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeThrowKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeThrowKeyword` replaced.
  /// - param newChild: The new `garbageBeforeThrowKeyword` to replace the node's
  ///                   current `garbageBeforeThrowKeyword`, if present.
  public func withGarbageBeforeThrowKeyword(
    _ newChild: GarbageNodesSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeThrowKeyword)
    return ThrowStmtSyntax(newData)
  }

  public var throwKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.throwKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withThrowKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `throwKeyword` replaced.
  /// - param newChild: The new `throwKeyword` to replace the node's
  ///                   current `throwKeyword`, if present.
  public func withThrowKeyword(
    _ newChild: TokenSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.throwKeyword)
    let newData = data.replacingChild(raw, at: Cursor.throwKeyword)
    return ThrowStmtSyntax(newData)
  }

  public var garbageBetweenThrowKeywordAndExpression: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenThrowKeywordAndExpression,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenThrowKeywordAndExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenThrowKeywordAndExpression` replaced.
  /// - param newChild: The new `garbageBetweenThrowKeywordAndExpression` to replace the node's
  ///                   current `garbageBetweenThrowKeywordAndExpression`, if present.
  public func withGarbageBetweenThrowKeywordAndExpression(
    _ newChild: GarbageNodesSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenThrowKeywordAndExpression)
    return ThrowStmtSyntax(newData)
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
    _ newChild: ExprSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ThrowStmtSyntax(newData)
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

extension ThrowStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeThrowKeyword": garbageBeforeThrowKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwKeyword": Syntax(throwKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenThrowKeywordAndExpression": garbageBetweenThrowKeywordAndExpression.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - IfStmtSyntax

public struct IfStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforeIfKeyword
    case ifKeyword
    case garbageBetweenIfKeywordAndConditions
    case conditions
    case garbageBetweenConditionsAndBody
    case body
    case garbageBetweenBodyAndElseKeyword
    case elseKeyword
    case garbageBetweenElseKeywordAndElseBody
    case elseBody
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IfStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .ifStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IfStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforeIfKeyword: GarbageNodesSyntax? = nil,
    ifKeyword: TokenSyntax,
    _ garbageBetweenIfKeywordAndConditions: GarbageNodesSyntax? = nil,
    conditions: ConditionElementListSyntax,
    _ garbageBetweenConditionsAndBody: GarbageNodesSyntax? = nil,
    body: CodeBlockSyntax,
    _ garbageBetweenBodyAndElseKeyword: GarbageNodesSyntax? = nil,
    elseKeyword: TokenSyntax?,
    _ garbageBetweenElseKeywordAndElseBody: GarbageNodesSyntax? = nil,
    elseBody: Syntax?
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforeIfKeyword?.raw,
      ifKeyword.raw,
      garbageBetweenIfKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndElseKeyword?.raw,
      elseKeyword?.raw,
      garbageBetweenElseKeywordAndElseBody?.raw,
      elseBody?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforeIfKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforeIfKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforeIfKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforeIfKeyword` replaced.
  /// - param newChild: The new `garbageBeforeIfKeyword` to replace the node's
  ///                   current `garbageBeforeIfKeyword`, if present.
  public func withGarbageBeforeIfKeyword(
    _ newChild: GarbageNodesSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforeIfKeyword)
    return IfStmtSyntax(newData)
  }

  public var ifKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ifKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withIfKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `ifKeyword` replaced.
  /// - param newChild: The new `ifKeyword` to replace the node's
  ///                   current `ifKeyword`, if present.
  public func withIfKeyword(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.ifKeyword)
    let newData = data.replacingChild(raw, at: Cursor.ifKeyword)
    return IfStmtSyntax(newData)
  }

  public var garbageBetweenIfKeywordAndConditions: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenIfKeywordAndConditions,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenIfKeywordAndConditions(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenIfKeywordAndConditions` replaced.
  /// - param newChild: The new `garbageBetweenIfKeywordAndConditions` to replace the node's
  ///                   current `garbageBetweenIfKeywordAndConditions`, if present.
  public func withGarbageBetweenIfKeywordAndConditions(
    _ newChild: GarbageNodesSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenIfKeywordAndConditions)
    return IfStmtSyntax(newData)
  }

  public var conditions: ConditionElementListSyntax {
    get {
      let childData = data.child(at: Cursor.conditions,
                                 parent: Syntax(self))
      return ConditionElementListSyntax(childData!)
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
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return IfStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return IfStmtSyntax(newData)
  }

  public var garbageBetweenConditionsAndBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenConditionsAndBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenConditionsAndBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenConditionsAndBody` replaced.
  /// - param newChild: The new `garbageBetweenConditionsAndBody` to replace the node's
  ///                   current `garbageBetweenConditionsAndBody`, if present.
  public func withGarbageBetweenConditionsAndBody(
    _ newChild: GarbageNodesSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenConditionsAndBody)
    return IfStmtSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return IfStmtSyntax(newData)
  }

  public var garbageBetweenBodyAndElseKeyword: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenBodyAndElseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenBodyAndElseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenBodyAndElseKeyword` replaced.
  /// - param newChild: The new `garbageBetweenBodyAndElseKeyword` to replace the node's
  ///                   current `garbageBetweenBodyAndElseKeyword`, if present.
  public func withGarbageBetweenBodyAndElseKeyword(
    _ newChild: GarbageNodesSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenBodyAndElseKeyword)
    return IfStmtSyntax(newData)
  }

  public var elseKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.elseKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withElseKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `elseKeyword` replaced.
  /// - param newChild: The new `elseKeyword` to replace the node's
  ///                   current `elseKeyword`, if present.
  public func withElseKeyword(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.elseKeyword)
    return IfStmtSyntax(newData)
  }

  public var garbageBetweenElseKeywordAndElseBody: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenElseKeywordAndElseBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenElseKeywordAndElseBody(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenElseKeywordAndElseBody` replaced.
  /// - param newChild: The new `garbageBetweenElseKeywordAndElseBody` to replace the node's
  ///                   current `garbageBetweenElseKeywordAndElseBody`, if present.
  public func withGarbageBetweenElseKeywordAndElseBody(
    _ newChild: GarbageNodesSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenElseKeywordAndElseBody)
    return IfStmtSyntax(newData)
  }

  public var elseBody: Syntax? {
    get {
      let childData = data.child(at: Cursor.elseBody,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return Syntax(childData!)
    }
    set(value) {
      self = withElseBody(value)
    }
  }

  /// Returns a copy of the receiver with its `elseBody` replaced.
  /// - param newChild: The new `elseBody` to replace the node's
  ///                   current `elseBody`, if present.
  public func withElseBody(
    _ newChild: Syntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.elseBody)
    return IfStmtSyntax(newData)
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
    // Check child #3 child is ConditionElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ConditionElementListSyntax.self))
    }
    // Check child #4 child is GarbageNodesSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GarbageNodesSyntax.self))
    }
    // Check child #5 child is CodeBlockSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
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
    // Check child #9 child is Syntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension IfStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforeIfKeyword": garbageBeforeIfKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ifKeyword": Syntax(ifKeyword).asProtocol(SyntaxProtocol.self),
      "garbageBetweenIfKeywordAndConditions": garbageBetweenIfKeywordAndConditions.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "conditions": Syntax(conditions).asProtocol(SyntaxProtocol.self),
      "garbageBetweenConditionsAndBody": garbageBetweenConditionsAndBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "garbageBetweenBodyAndElseKeyword": garbageBetweenBodyAndElseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elseKeyword": elseKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenElseKeywordAndElseBody": garbageBetweenElseKeywordAndElseBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elseBody": elseBody.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PoundAssertStmtSyntax

public struct PoundAssertStmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case garbageBeforePoundAssert
    case poundAssert
    case garbageBetweenPoundAssertAndLeftParen
    case leftParen
    case garbageBetweenLeftParenAndCondition
    case condition
    case garbageBetweenConditionAndComma
    case comma
    case garbageBetweenCommaAndMessage
    case message
    case garbageBetweenMessageAndRightParen
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundAssertStmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundAssertStmt else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundAssertStmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundAssertStmt)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ garbageBeforePoundAssert: GarbageNodesSyntax? = nil,
    poundAssert: TokenSyntax,
    _ garbageBetweenPoundAssertAndLeftParen: GarbageNodesSyntax? = nil,
    leftParen: TokenSyntax,
    _ garbageBetweenLeftParenAndCondition: GarbageNodesSyntax? = nil,
    condition: ExprSyntax,
    _ garbageBetweenConditionAndComma: GarbageNodesSyntax? = nil,
    comma: TokenSyntax?,
    _ garbageBetweenCommaAndMessage: GarbageNodesSyntax? = nil,
    message: TokenSyntax?,
    _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil,
    rightParen: TokenSyntax
  ) {
    let layout: [RawSyntax?] = [
      garbageBeforePoundAssert?.raw,
      poundAssert.raw,
      garbageBetweenPoundAssertAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndCondition?.raw,
      condition.raw,
      garbageBetweenConditionAndComma?.raw,
      comma?.raw,
      garbageBetweenCommaAndMessage?.raw,
      message?.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundAssertStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    self.init(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var garbageBeforePoundAssert: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBeforePoundAssert,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBeforePoundAssert(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBeforePoundAssert` replaced.
  /// - param newChild: The new `garbageBeforePoundAssert` to replace the node's
  ///                   current `garbageBeforePoundAssert`, if present.
  public func withGarbageBeforePoundAssert(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBeforePoundAssert)
    return PoundAssertStmtSyntax(newData)
  }

  public var poundAssert: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundAssert,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundAssert(value)
    }
  }

  /// Returns a copy of the receiver with its `poundAssert` replaced.
  /// - param newChild: The new `poundAssert` to replace the node's
  ///                   current `poundAssert`, if present.
  public func withPoundAssert(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundAssertKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundAssert)
    return PoundAssertStmtSyntax(newData)
  }

  public var garbageBetweenPoundAssertAndLeftParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenPoundAssertAndLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenPoundAssertAndLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenPoundAssertAndLeftParen` replaced.
  /// - param newChild: The new `garbageBetweenPoundAssertAndLeftParen` to replace the node's
  ///                   current `garbageBetweenPoundAssertAndLeftParen`, if present.
  public func withGarbageBetweenPoundAssertAndLeftParen(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenPoundAssertAndLeftParen)
    return PoundAssertStmtSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundAssertStmtSyntax(newData)
  }

  public var garbageBetweenLeftParenAndCondition: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenLeftParenAndCondition,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenLeftParenAndCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenLeftParenAndCondition` replaced.
  /// - param newChild: The new `garbageBetweenLeftParenAndCondition` to replace the node's
  ///                   current `garbageBetweenLeftParenAndCondition`, if present.
  public func withGarbageBetweenLeftParenAndCondition(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenLeftParenAndCondition)
    return PoundAssertStmtSyntax(newData)
  }

  /// The assertion condition.
  public var condition: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.condition,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withCondition(value)
    }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: ExprSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.missingExpr)
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return PoundAssertStmtSyntax(newData)
  }

  public var garbageBetweenConditionAndComma: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenConditionAndComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenConditionAndComma(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenConditionAndComma` replaced.
  /// - param newChild: The new `garbageBetweenConditionAndComma` to replace the node's
  ///                   current `garbageBetweenConditionAndComma`, if present.
  public func withGarbageBetweenConditionAndComma(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenConditionAndComma)
    return PoundAssertStmtSyntax(newData)
  }

  /// The comma after the assertion condition.
  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.comma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withComma(value)
    }
  }

  /// Returns a copy of the receiver with its `comma` replaced.
  /// - param newChild: The new `comma` to replace the node's
  ///                   current `comma`, if present.
  public func withComma(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.comma)
    return PoundAssertStmtSyntax(newData)
  }

  public var garbageBetweenCommaAndMessage: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenCommaAndMessage,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenCommaAndMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenCommaAndMessage` replaced.
  /// - param newChild: The new `garbageBetweenCommaAndMessage` to replace the node's
  ///                   current `garbageBetweenCommaAndMessage`, if present.
  public func withGarbageBetweenCommaAndMessage(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenCommaAndMessage)
    return PoundAssertStmtSyntax(newData)
  }

  /// The assertion message.
  public var message: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.message,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withMessage(value)
    }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundAssertStmtSyntax(newData)
  }

  public var garbageBetweenMessageAndRightParen: GarbageNodesSyntax? {
    get {
      let childData = data.child(at: Cursor.garbageBetweenMessageAndRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GarbageNodesSyntax(childData!)
    }
    set(value) {
      self = withGarbageBetweenMessageAndRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `garbageBetweenMessageAndRightParen` replaced.
  /// - param newChild: The new `garbageBetweenMessageAndRightParen` to replace the node's
  ///                   current `garbageBetweenMessageAndRightParen`, if present.
  public func withGarbageBetweenMessageAndRightParen(
    _ newChild: GarbageNodesSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.garbageBetweenMessageAndRightParen)
    return PoundAssertStmtSyntax(newData)
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
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundAssertStmtSyntax(newData)
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
    // Check child #9 child is TokenSyntax or missing
    if let raw = rawChildren[9].raw {
      let info = rawChildren[9].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
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

extension PoundAssertStmtSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "garbageBeforePoundAssert": garbageBeforePoundAssert.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "poundAssert": Syntax(poundAssert).asProtocol(SyntaxProtocol.self),
      "garbageBetweenPoundAssertAndLeftParen": garbageBetweenPoundAssertAndLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "garbageBetweenLeftParenAndCondition": garbageBetweenLeftParenAndCondition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self),
      "garbageBetweenConditionAndComma": garbageBetweenConditionAndComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenCommaAndMessage": garbageBetweenCommaAndMessage.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "message": message.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "garbageBetweenMessageAndRightParen": garbageBetweenMessageAndRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

