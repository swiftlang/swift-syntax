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

  @_spi(RawSyntax)
  public init(raw: RawSyntax) {
    self.init(.forRoot(raw))
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
}

extension Syntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: self.asProtocol(SyntaxProtocol.self))
  }
}

extension Syntax: Identifiable {
  public typealias ID = SyntaxIdentifier
}

extension Syntax {
  /// Enumerate all of the syntax text present in this node, and all
  /// of its children, to give a source-accurate view of the bytes.
  ///
  /// Unlike `description`, this provides a source-accurate representation
  /// even in the presence of malformed UTF-8 in the input source.
  ///
  /// The `SyntaxText` arguments passed to the visitor are only guaranteed
  /// to be valid within that call. It is unsafe to escape the `SyntaxValue`
  /// values outside of the closure.
  @_spi(RawSyntax)
  public func withEachSyntaxText(body: (SyntaxText) throws -> Void) rethrows {
    try raw.withEachSyntaxText(body: body)
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    return raw.syntaxTextBytes
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

  /// Return a name with which the child at the given `index` can be referred to
  /// in diagnostics.
  func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String?
}

extension SyntaxProtocol {
  var data: SyntaxData {
    return _syntaxNode.data
  }

  /// Access the raw syntax assuming the node is a Syntax.
  @_spi(RawSyntax)
  public var raw: RawSyntax {
    return _syntaxNode.data.raw
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return self.raw.kind.syntaxNodeType
  }
}

public extension SyntaxProtocol {
  @available(*, deprecated, message: "Use children(viewMode:) instead")
  var children: SyntaxChildren {
    return children(viewMode: .sourceAccurate)
  }

  /// A sequence over the `present` children of this node.
  func children(viewMode: SyntaxTreeViewMode) -> SyntaxChildren {
    return SyntaxChildren(_syntaxNode, viewMode: viewMode)
  }

  /// The index of this node in a `SyntaxChildren` collection.
  var index: SyntaxChildrenIndex {
    return SyntaxChildrenIndex(self.data.absoluteInfo)
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

  /// Whether this tree contains a missing token or unexpected node.
  var hasError: Bool {
    return raw.recursiveFlags.contains(.hasError)
  }

  /// Whether this tree contains a missing token or unexpected node.
  var hasSequenceExpr: Bool {
    return raw.recursiveFlags.contains(.hasSequenceExpr)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: Syntax? {
    return data.parent.map(Syntax.init(_:))
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
    return self.previousToken(viewMode: .sourceAccurate)
  }

  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  func previousToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = NonNilRawSyntaxChildren(parent, viewMode: viewMode)
    for absoluteRaw in siblings[..<self.index].reversed() {
      let child = Syntax(SyntaxData(absoluteRaw, parent: parent))
      if let token = child.lastToken(viewMode: viewMode) {
        return token
      }
    }
    return parent.previousToken(viewMode: viewMode)
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  var nextToken: TokenSyntax? {
    return self.nextToken(viewMode: .sourceAccurate)
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  func nextToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = NonNilRawSyntaxChildren(parent, viewMode: viewMode)
    let nextSiblingIndex = siblings.index(after: self.index)
    for absoluteRaw in siblings[nextSiblingIndex...] {
      let child = Syntax(SyntaxData(absoluteRaw, parent: parent))
      if let token = child.firstToken(viewMode: viewMode) {
        return token
      }
    }
    return parent.nextToken(viewMode: viewMode)
  }

  /// Returns the first token in this syntax node in the source accurate view of
  /// the syntax tree.
  var firstToken: TokenSyntax? {
    return self.firstToken(viewMode: .sourceAccurate)
  }

  /// Returns the first token node that is part of this syntax node.
  func firstToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children(viewMode: viewMode) {
      if let token = child.firstToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }

  /// Returns the last token node that is part of this syntax node.
  var lastToken: TokenSyntax? {
    return self.lastToken(viewMode: .sourceAccurate)
  }

  /// Returns the last token node that is part of this syntax node.
  func lastToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children(viewMode: viewMode).reversed() {
      if let tok = child.lastToken(viewMode: viewMode) {
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
  @available(*, deprecated, message: "Use tokens(viewMode:) instead")
  var tokens: TokenSequence {
    return tokens(viewMode: .sourceAccurate)
  }

  /// Sequence of tokens that are part of this Syntax node.
  func tokens(viewMode: SyntaxTreeViewMode) -> TokenSequence {
    return TokenSequence(_syntaxNode, viewMode: viewMode)
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
}

/// Provides the source-accurate text for a node
public extension SyntaxProtocol {
  /// A source-accurate description of this node.
  ///
  /// Note that the resulting String cannot represent invalid UTF-8 that
  /// occurs within the syntax nodes. Use `syntaxTextBytes` for a
  /// byte-accurate representation of this node in the presence of
  /// invalid UTF-8.
  var description: String {
    return data.raw.description
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  var syntaxTextBytes: [UInt8] {
    return data.raw.syntaxTextBytes
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    data.raw.write(to: &target)
  }
}

/// Provides debug descriptions for a node
public extension SyntaxProtocol {
  /// A simple description of this node (ie. its type).
  var debugDescription: String {
    debugDescription()
  }

  /// Same as `debugDescription` but includes all children.
  var recursiveDescription: String {
    debugDescription(includeChildren: true)
  }

  /// Returns a summarized dump of this node.
  /// - Parameters:
  ///   - includeChildren: Whether to also dump children, false by default.
  ///   - includeTrivia: Add trivia to each dumped node, which the default
  ///   dump skips.
  ///   - converter: The location converter for the root of the tree. Adds
  ///   `[startLine:startCol...endLine:endCol]` to each node.
  ///   - mark: Adds `***` around the given node, intended to highlight it in
  ///   the dump.
  ///   - indentLevel: The starting indent level, 0 by default. Each level is 2
  ///   spaces.
  func debugDescription(includeChildren: Bool = false, includeTrivia: Bool = false,
                        converter: SourceLocationConverter? = nil, mark: SyntaxProtocol? = nil,
                        indentLevel: Int = 0) -> String {
    var str = ""
    debugWrite(to: &str, includeChildren: includeChildren, includeTrivia: includeTrivia,
               converter: converter, mark: mark, indentLevel: indentLevel)
    return str
  }

  private func debugWrite<Target: TextOutputStream>(to target: inout Target,
                                                    includeChildren: Bool, includeTrivia: Bool,
                                                    converter: SourceLocationConverter? = nil, mark: SyntaxProtocol? = nil,
                                                    indentLevel: Int) {
    if let mark = mark, self.id == mark.id {
      target.write("*** ")
    }

    if let token = Syntax(self).as(TokenSyntax.self) {
      target.write(String(describing: token.tokenKind))
      if includeTrivia {
        if let leadingTrivia = leadingTrivia, !leadingTrivia.isEmpty {
          target.write(" leadingTrivia=\(leadingTrivia.debugDescription)")
        }
        if let trailingTrivia = trailingTrivia, !trailingTrivia.isEmpty {
          target.write(" trailingTrivia=\(trailingTrivia.debugDescription)")
        }
      }
    } else {
      target.write(String(describing: syntaxNodeType))
    }

    let allChildren = children(viewMode: .all)
    if includeChildren {
      if !allChildren.isEmpty {
        target.write(" children=\(allChildren.count)")
      }
    }

    if let converter = converter {
      let range = sourceRange(converter: converter)
      target.write(" [\(range.start)...\(range.end)]")
    }

    if let tokenView = raw.tokenView, tokenView.presence == .missing {
      target.write(" MISSING")
    }

    if let mark = mark, self.id == mark.id {
      target.write(" ***")
    }

    if includeChildren {
      let childIndentLevel = indentLevel + 1
      for (num, child) in allChildren.enumerated() {
        target.write("\n")
        target.write(String(repeating: " ", count: childIndentLevel * 2))
        target.write("\(num): ")
        child.debugWrite(to: &target, includeChildren: includeChildren, includeTrivia: includeTrivia,
                         converter: converter, mark: mark, indentLevel: childIndentLevel)
      }
    }
  }
}

/// Sequence of tokens that are part of the provided Syntax node.
public struct TokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    let endPosition: AbsolutePosition
    let viewMode: SyntaxTreeViewMode

    init(_ token: TokenSyntax?, endPosition: AbsolutePosition, viewMode: SyntaxTreeViewMode) {
      self.nextToken = token
      self.endPosition = endPosition
      self.viewMode = viewMode
    }

    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      self.nextToken = token.nextToken(viewMode: viewMode)
      // Make sure we stop once we reach the end of the containing node.
      if let nextTok = self.nextToken, nextTok.position >= self.endPosition {
        self.nextToken = nil
      }
      return token
    }
  }

  let node: Syntax
  let viewMode: SyntaxTreeViewMode

  public init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.node = node
    self.viewMode = viewMode
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.firstToken(viewMode: viewMode), endPosition: node.endPosition, viewMode: viewMode)
  }

  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node, viewMode: viewMode)
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
    let viewMode: SyntaxTreeViewMode

    init(_ token: TokenSyntax?, startPosition: AbsolutePosition, viewMode: SyntaxTreeViewMode) {
      self.nextToken = token
      self.startPosition = startPosition
      self.viewMode = viewMode
    }

    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      self.nextToken = token.previousToken(viewMode: viewMode)
      // Make sure we stop once we went beyond the start of the containing node.
      if let nextTok = self.nextToken, nextTok.position < self.startPosition {
        self.nextToken = nil
      }
      return token
    }
  }

  let node: Syntax
  let viewMode: SyntaxTreeViewMode

  public init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.node = node
    self.viewMode = viewMode
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.lastToken(viewMode: viewMode), startPosition: node.position, viewMode: viewMode)
  }

  public func reversed() -> TokenSequence {
    return TokenSequence(node, viewMode: viewMode)
  }
}

extension ReversedTokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}

/// Expose `recursiveDescription` on raw nodes for debugging purposes.
extension RawSyntaxNodeProtocol {
  /// Print this raw syntax node including all of its children.
  /// Intended for debugging purposes only.
  var recursiveDescription: String {
    return Syntax(raw: raw).recursiveDescription
  }
}

@available(*, unavailable, message: "use 'Syntax' instead")
public struct SyntaxNode {}
