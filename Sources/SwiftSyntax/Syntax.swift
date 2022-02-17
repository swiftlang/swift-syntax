//===--------------- Syntax.swift - Base Syntax Type eraser  --------------===//
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

/// A Syntax node represents a tree of nodes with tokens at the leaves.
/// Each node has accessors for its known children, and allows efficient
/// iteration over the children through its `children` property.
public struct Syntax: SyntaxProtocol, SyntaxHashable {
  let data: SyntaxData

  public var _syntaxNode: Syntax {
    return self
  }

  init(_ data: SyntaxData) {
    self.data = data
  }

  public func _validateLayout() {
    // Check the layout of the concrete type
    return self.asProtocol(SyntaxProtocol.self)._validateLayout()
  }

  /// Create a `Syntax` node from a specialized syntax node.
  public init<S: SyntaxProtocol>(_ syntax: S) {
    self = syntax._syntaxNode
  }

  /// Create a `Syntax` node from a specialized optional syntax node.
  public init?<S: SyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self = syntax._syntaxNode
  }
  
  public init(fromProtocol syntax: SyntaxProtocol) {
    self = syntax._syntaxNode
  }
  
  public init?(fromProtocol syntax: SyntaxProtocol?) {
    guard let syntax = syntax else { return nil }
    self = syntax._syntaxNode
  }

  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }

  public static func ==(lhs: Syntax, rhs: Syntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }
}

// Casting functions to specialized syntax nodes.
extension Syntax {
  public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(self)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self.asProtocol(SyntaxProtocol.self))
  }
}

extension Syntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: self.asProtocol(SyntaxProtocol.self))
  }
}

/// Protocol that provides a common Hashable implementation for all syntax nodes
public protocol SyntaxHashable: Hashable {
  var _syntaxNode: Syntax { get }
}

public extension SyntaxHashable {
  func hash(into hasher: inout Hasher) {
    return _syntaxNode.data.nodeId.hash(into: &hasher)
  }

  static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs._syntaxNode.data.nodeId == rhs._syntaxNode.data.nodeId
  }
}

/// Provide common functionality for specialized syntax nodes. Extend this
/// protocol to provide common functionality for all syntax nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol SyntaxProtocol: CustomStringConvertible,
    CustomDebugStringConvertible, TextOutputStreamable {

  /// Retrieve the generic syntax node that is represented by this node.
  /// Do not retrieve this property directly. Use `Syntax(self)` instead.
  var _syntaxNode: Syntax { get }

  /// Converts the given `Syntax` node to this type. Returns `nil` if the
  /// conversion is not possible.
  init?(_ syntaxNode: Syntax)

  /// Check that the raw layout of this node is valid. Used to verify a node's
  /// integrity after it has been rewritten by the syntax rewriter.
  /// Results in an assertion failure if the layout is invalid.
  func _validateLayout()

  /// Returns the underlying syntax node type.
  var syntaxNodeType: SyntaxProtocol.Type { get }
}

internal extension SyntaxProtocol {
  var data: SyntaxData {
    return _syntaxNode.data
  }

  /// Access the raw syntax assuming the node is a Syntax.
  var raw: RawSyntax {
    return _syntaxNode.data.raw
  }
}

public extension SyntaxProtocol {
  /// A sequence over the `present` children of this node.
  var children: SyntaxChildren {
    return SyntaxChildren(_syntaxNode)
  }

  /// The index of this node in a `SyntaxChildren` collection.
  var index: SyntaxChildrenIndex {
    return SyntaxChildrenIndex(self.data.absoluteRaw.info)
  }

  /// Whether or not this node is marked as `present`.
  var isPresent: Bool {
    return raw.isPresent
  }

  /// Whether or not this node is marked as `missing`.
  var isMissing: Bool {
    return raw.isMissing
  }

  /// Whether or not this node is a token one.
  var isToken: Bool {
    return raw.isToken
  }

  /// Whether or not this node represents an SyntaxCollection.
  var isCollection: Bool {
    // We need to provide a custom implementation for is(SyntaxCollection.self)
    // since SyntaxCollection has generic or self requirements and can thus
    // not be used as a method argument.
    return raw.kind.isSyntaxCollection
  }

  /// Whether or not this node represents an unknown node.
  var isUnknown: Bool {
    return raw.kind.isUnknown
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: Syntax? {
    return data.parent
  }

  /// The index of this node in the parent's children.
  var indexInParent: Int {
    return data.indexInParent
  }

  /// Whether or not this node has a parent.
  var hasParent: Bool {
    return parent != nil
  }

  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  var previousToken: TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = PresentRawSyntaxChildren(parent)
    for absoluteRaw in siblings[..<self.index].reversed() {
      let child = Syntax(SyntaxData(absoluteRaw, parent: parent))
      if let token = child.lastToken {
        return token
      }
    }
    return parent.previousToken
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  var nextToken: TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = PresentRawSyntaxChildren(parent)
    let nextSiblingIndex = siblings.index(after: self.index)
    for absoluteRaw in siblings[nextSiblingIndex...] {
      let child = Syntax(SyntaxData(absoluteRaw, parent: parent))
      if let token = child.firstToken {
        return token
      }
    }
    return parent.nextToken
  }

  /// Returns the first token node that is part of this syntax node.
  var firstToken: TokenSyntax? {
    if isMissing { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children {
      if let token = child.firstToken {
        return token
      }
    }
    return nil
  }

  /// Returns the last token node that is part of this syntax node.
  var lastToken: TokenSyntax? {
    if isMissing { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children.reversed() {
      if let tok = child.lastToken {
        return tok
      }
    }
    return nil
  }

  /// The absolute position of the starting point of this node. If the first token
  /// is with leading trivia, the position points to the start of the leading
  /// trivia.
  var position: AbsolutePosition {
    return data.position
  }

  /// The absolute position of the starting point of this node, skipping any
  /// leading trivia attached to the first token syntax.
  var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return data.positionAfterSkippingLeadingTrivia
  }

  /// The end position of this node's content, before any trailing trivia.
  var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return data.endPositionBeforeTrailingTrivia
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    return data.endPosition
  }

  /// The textual byte length of this node including leading and trailing trivia.
  var byteSize: Int {
    return totalLength.utf8Length
  }

  /// The byte source range of this node including leading and trailing trivia.
  var byteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: byteSize)
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  var contentLength: SourceLength {
    return raw.contentLength
  }

  /// The leading trivia of this syntax node. Leading trivia is attached to
  /// the first token syntax contained by this node. Without such token, this
  /// property will return nil.
  var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia of this syntax node. Trailing trivia is attached to
  /// the last token syntax contained by this node. Without such token, this
  /// property will return nil.
  var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  /// The length this node's leading trivia takes up spelled out in source.
  var leadingTriviaLength: SourceLength {
    return raw.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  var trailingTriviaLength: SourceLength {
    return raw.trailingTriviaLength
  }

  /// Returns a new syntax node with its leading trivia replaced
  /// by the provided trivia.
  func withLeadingTrivia(_ leadingTrivia: Trivia) -> Self {
    return Self(Syntax(data.withLeadingTrivia(leadingTrivia)))!
  }

  /// Returns a new syntax node with its trailing trivia replaced
  /// by the provided trivia.
  func withTrailingTrivia(_ trailingTrivia: Trivia) -> Self {
    return Self(Syntax(data.withTrailingTrivia(trailingTrivia)))!
  }

  /// Returns a new syntax node with its leading trivia removed.
  func withoutLeadingTrivia() -> Self {
    return withLeadingTrivia([])
  }

  /// Returns a new syntax node with its trailing trivia removed.
  func withoutTrailingTrivia() -> Self {
    return withTrailingTrivia([])
  }

  /// Returns a new syntax node with all trivia removed.
  func withoutTrivia() -> Self {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The length of this node including all of its trivia.
  var totalLength: SourceLength {
    return raw.totalLength
  }

  /// When isImplicit is true, the syntax node doesn't include any
  /// underlying tokens, e.g. an empty CodeBlockItemList.
  var isImplicit: Bool {
    return leadingTrivia == nil
  }

  /// The textual byte length of this node exluding leading and trailing trivia.
  var byteSizeAfterTrimmingTrivia: Int {
    return contentLength.utf8Length
  }

  /// The root of the tree in which this node resides.
  var root: Syntax {
    var this = _syntaxNode
    while let parent = this.parent {
      this = parent
    }
    return this
  }

  /// Sequence of tokens that are part of this Syntax node.
  var tokens: TokenSequence {
    return TokenSequence(_syntaxNode)
  }

  /// Sequence of `SyntaxClassifiedRange`s for this syntax node.
  ///
  /// The provided classified ranges are consecutive and cover the full source
  /// text of the node. The ranges may also span multiple tokens, if multiple
  /// consecutive tokens would have the same classification then a single classified
  /// range is provided for all of them.
  var classifications: SyntaxClassifications {
    let fullRange = ByteSourceRange(offset: 0, length: byteSize)
    return SyntaxClassifications(_syntaxNode, in: fullRange)
  }

  /// Sequence of `SyntaxClassifiedRange`s contained in this syntax node within
  /// a relative range.
  ///
  /// The provided classified ranges may extend beyond the provided `range`.
  /// Active classifications (non-`none`) will extend the range to include the
  /// full classified range (e.g. from the beginning of the comment block), while
  /// `none` classified ranges will extend to the beginning or end of the token
  /// that the `range` touches.
  /// It is guaranteed that no classified range will be provided that doesn't
  /// intersect the provided `range`.
  ///
  /// - Parameters:
  ///   - in: The relative byte range to pull `SyntaxClassifiedRange`s from.
  /// - Returns: Sequence of `SyntaxClassifiedRange`s.
  func classifications(in range: ByteSourceRange) -> SyntaxClassifications {
    return SyntaxClassifications(_syntaxNode, in: range)
  }

  /// The `SyntaxClassifiedRange` for a relative byte offset.
  /// - Parameters:
  ///   - at: The relative to the node byte offset.
  /// - Returns: The `SyntaxClassifiedRange` for the offset or nil if the source text
  ///   at the given offset is unclassified.
  func classification(at offset: Int) -> SyntaxClassifiedRange? {
    let classifications = SyntaxClassifications(_syntaxNode, in: ByteSourceRange(offset: offset, length: 1))
    var iterator = classifications.makeIterator()
    return iterator.next()
  }

  /// The `SyntaxClassifiedRange` for an absolute position.
  /// - Parameters:
  ///   - at: The absolute position.
  /// - Returns: The `SyntaxClassifiedRange` for the position or nil if the source text
  ///   at the given position is unclassified.
  func classification(at position: AbsolutePosition) -> SyntaxClassifiedRange? {
    let relativeOffset = position.utf8Offset - self.position.utf8Offset
    return self.classification(at: relativeOffset)
  }

  /// Returns a value representing the unique identity of the node.
  var id: SyntaxIdentifier {
    return data.nodeId
  }

  /// A source-accurate description of this node.
  var description: String {
    return data.raw.description
  }

  /// Returns a description used by dump.
  var debugDescription: String {
    return String(reflecting: type(of: self))
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    data.raw.write(to: &target)
  }
}

/// Sequence of tokens that are part of the provided Syntax node.
public struct TokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    let endPosition: AbsolutePosition

    init(_ token: TokenSyntax?, endPosition: AbsolutePosition) {
      self.nextToken = token
      self.endPosition = endPosition
    }

    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      self.nextToken = token.nextToken
      // Make sure we stop once we reach the end of the containing node.
      if let nextTok = self.nextToken, nextTok.position >= self.endPosition {
        self.nextToken = nil
      }
      return token
    }
  }

  let node: Syntax

  public init(_ node: Syntax) {
    self.node = node
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.firstToken, endPosition: node.endPosition)
  }

  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node)
  }
}

extension TokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}

/// Reverse sequence of tokens that are part of the provided Syntax node.
public struct ReversedTokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    let startPosition: AbsolutePosition

    init(_ token: TokenSyntax?, startPosition: AbsolutePosition) {
      self.nextToken = token
      self.startPosition = startPosition
    }

    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      self.nextToken = token.previousToken
      // Make sure we stop once we went beyond the start of the containing node.
      if let nextTok = self.nextToken, nextTok.position < self.startPosition {
        self.nextToken = nil
      }
      return token
    }
  }

  let node: Syntax

  public init(_ node: Syntax) {
    self.node = node
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.lastToken, startPosition: node.position)
  }

  public func reversed() -> TokenSequence {
    return TokenSequence(node)
  }
}

extension ReversedTokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}

/// Represents a node from the syntax tree.
///
/// This is a more efficient representation than `Syntax` because it avoids casts
/// to `Syntax` for representing the parent hierarchy.
/// It provides generic information, like the node's position, range, and
/// a unique `id`, while still allowing getting the associated `Syntax`
/// object if necessary.
///
/// `SyntaxParser` uses `SyntaxNode` to efficiently report which syntax nodes
/// got re-used during incremental re-parsing.
public struct SyntaxNode {
  let absoluteRaw: AbsoluteRawSyntax
  let parents: ArraySlice<AbsoluteRawSyntax>

  internal init(node: AbsoluteRawSyntax, parents: ArraySlice<AbsoluteRawSyntax>) {
    self.absoluteRaw = node
    self.parents = parents
  }

  internal var raw: RawSyntax {
    return absoluteRaw.raw
  }

  /// Converts this node to a `SyntaxData` object.
  ///
  /// This operation results in wrapping all of the node's parents into
  /// `SyntaxData` objects. There's a cost associated with it that should be
  /// taken into account before used inside performance critical code.
  internal var asSyntaxData: SyntaxData {
    return SyntaxData(absoluteRaw, parent: parent?.asSyntax)
  }

  /// Converts this node to a `Syntax` object.
  ///
  /// This operation results in wrapping this node and all of its parents into
  /// `Syntax` objects. There's a cost associated with it that should be taken
  /// into account before used inside performance critical code.
  public var asSyntax: Syntax {
    return Syntax(self.asSyntaxData)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  public var parent: SyntaxNode? {
    guard !parents.isEmpty else { return nil }
    return SyntaxNode(node: parents.last!, parents: parents.dropLast())
  }

  /// The absolute position of the starting point of this node.
  public var position: AbsolutePosition {
    return absoluteRaw.position
  }

  /// The end position of this node, including its trivia.
  public var endPosition: AbsolutePosition {
    return absoluteRaw.endPosition
  }

  /// The textual byte length of this node including leading and trailing trivia.
  public var byteSize: Int {
    return totalLength.utf8Length
  }

  /// The byte source range of this node including leading and trailing trivia.
  public var byteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: byteSize)
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return raw.totalLength
  }

  /// Returns a value representing the unique identity of the node.
  public var id: SyntaxIdentifier {
    return absoluteRaw.info.nodeId
  }
}

extension SyntaxNode: CustomStringConvertible, TextOutputStreamable {
  /// A source-accurate description of this node.
  public var description: String {
    return raw.description
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  public func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
      raw.write(to: &target)
  }
}
