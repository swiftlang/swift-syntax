//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Describes the statically allowed structure of a syntax tree node.
public enum SyntaxNodeStructure {
  public enum SyntaxChoice {
    case node(SyntaxProtocol.Type)
    case token(TokenKind)
  }

  /// The node contains a fixed number of children which can be accessed by these key paths.
  case layout([AnyKeyPath])

  /// The node is a `SyntaxCollection` of the given type.
  case collection(SyntaxProtocol.Type)

  /// The node can contain a single node with one of the listed types.
  case choices([SyntaxChoice])

  public var isLayout: Bool {
    switch self {
    case .layout: return true
    default: return false
    }
  }

  public var isCollection: Bool {
    switch self {
    case .collection: return true
    default: return false
    }
  }

  public var isChoices: Bool {
    switch self {
    case .choices: return true
    default: return false
    }
  }
}

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

  public init(fromProtocol syntax: SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  public init?(fromProtocol syntax: SyntaxProtocol?) {
    guard let syntax = syntax else { return nil }
    self = syntax._syntaxNode
  }

  /// Syntax nodes always conform to SyntaxProtocol. This API is just added
  /// for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: SyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: SyntaxProtocol.Protocol) -> SyntaxProtocol {
    return self.raw.kind.syntaxNodeType.init(self)!
  }

  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }

  public static func == (lhs: Syntax, rhs: Syntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
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

  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs._syntaxNode.data.nodeId == rhs._syntaxNode.data.nodeId
  }
}

/// Provide common functionality for specialized syntax nodes. Extend this
/// protocol to provide common functionality for all syntax nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol SyntaxProtocol: CustomStringConvertible,
  CustomDebugStringConvertible, TextOutputStreamable, CustomReflectable
{

  /// Retrieve the generic syntax node that is represented by this node.
  /// Do not retrieve this property directly. Use `Syntax(self)` instead.
  var _syntaxNode: Syntax { get }

  /// Converts the given specialized node to this type. Returns `nil` if the
  /// conversion is not possible.
  init?<S: SyntaxProtocol>(_ node: S)

  /// The statically allowed structure of the syntax node.
  static var structure: SyntaxNodeStructure { get }
}

// Casting functions to specialized syntax nodes.
public extension SyntaxProtocol {
  /// Converts the given specialized node to this type. Returns `nil` if the
  /// conversion is not possible or the given node was `nil`.
  init?<S: SyntaxProtocol>(_ node: S?) {
    guard let node = node else {
      return nil
    }
    self.init(node)
  }

  func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(self)
  }

  func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }
}

public extension SyntaxProtocol {
  /// Returns a new syntax node that has the child at `keyPath` replaced by
  /// `value`.
  func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
    var copy = self
    copy[keyPath: keyPath] = value
    return copy
  }
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

  /// Return this subtree with this node as the root, ie. detach this node
  /// from its parent.
  public func detach() -> Self {
    return Syntax(raw: self.raw).cast(Self.self)
  }

  public var kind: SyntaxKind {
    return raw.kind
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return self.raw.kind.syntaxNodeType
  }
}

public extension SyntaxProtocol {
  /// A sequence over the `present` children of this node.
  func children(viewMode: SyntaxTreeViewMode) -> SyntaxChildren {
    return SyntaxChildren(_syntaxNode, viewMode: viewMode)
  }

  /// The index of this node in a `SyntaxChildren` collection.
  var index: SyntaxChildrenIndex {
    return SyntaxChildrenIndex(self.data.absoluteInfo)
  }

  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a `TokenDiagnostic` of severity `error`
  var hasError: Bool {
    return raw.recursiveFlags.contains(.hasError)
  }

  /// Whether the tree contained by this layout has any tokens with a
  /// `TokenDiagnostic` of severity `warning`.
  var hasWarning: Bool {
    return raw.recursiveFlags.contains(.hasWarning)
  }

  /// Whether this tree contains a missing token or unexpected node.
  var hasSequenceExpr: Bool {
    return raw.recursiveFlags.contains(.hasSequenceExpr)
  }

  var hasMaximumNestingLevelOverflow: Bool {
    return raw.recursiveFlags.contains(.hasMaximumNestingLevelOverflow)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: Syntax? {
    return data.parent.map(Syntax.init(_:))
  }

  /// Whether or not this node has a parent.
  var hasParent: Bool {
    return parent != nil
  }

  var keyPathInParent: AnyKeyPath? {
    guard let parent = self.parent else {
      return nil
    }
    guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
      return nil
    }
    return childrenKeyPaths[data.indexInParent]
  }

  @available(*, deprecated, message: "Use previousToken(viewMode:) instead")
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
    // `self` could be a missing node at index 0 and `viewMode` be `.sourceAccurate`.
    // In that case `siblings` skips over the missing `self` node and has a `startIndex > 0`.
    if self.index >= siblings.startIndex {
      for absoluteRaw in siblings[..<self.index].reversed() {
        let child = Syntax(SyntaxData(absoluteRaw, parent: parent))
        if let token = child.lastToken(viewMode: viewMode) {
          return token
        }
      }
    }
    return parent.previousToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use nextToken(viewMode:) instead")
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

  @available(*, deprecated, message: "Use firstToken(viewMode: .sourceAccurate) instead")
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

  @available(*, deprecated, message: "Use lastToken(viewMode: .sourceAccurate) instead")
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

  /// Find the syntax token at the given absolute position within this
  /// syntax node or any of its children.
  func token(at position: AbsolutePosition) -> TokenSyntax? {
    // If the position isn't within this node at all, return early.
    guard position >= self.position && position < self.endPosition else {
      return nil
    }

    // If we are a token syntax, that's it!
    if let token = Syntax(self).as(TokenSyntax.self) {
      return token
    }

    // Otherwise, it must be one of our children.
    for child in children(viewMode: .sourceAccurate) {
      if let token = child.token(at: position) {
        return token
      }
    }

    fatalError("Children of syntax node do not cover all positions in it")
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
  ///
  /// Note: `Trivia` is not able to represent invalid UTF-8 sequences. To get
  /// the leading trivia text including all invalid UTF-8 sequences, use
  /// ```
  /// node.syntaxTextBytes.prefix(self.leadingTriviaLength.utf8Length)
  /// ```
  var leadingTrivia: Trivia {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = Self(Syntax(data.withLeadingTrivia(newValue, arena: SyntaxArena())))!
    }
  }

  /// The trailing trivia of this syntax node. Trailing trivia is attached to
  /// the last token syntax contained by this node. Without such token, this
  /// property will return nil.
  ///
  /// Note: `Trivia` is not able to represent invalid UTF-8 sequences. To get
  /// the leading trivia text including all invalid UTF-8 sequences, use
  /// ```
  /// node.syntaxTextBytes[(node.byteSize - node.trailingTriviaLength.utf8Length)...]
  /// ```
  var trailingTrivia: Trivia {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = Self(Syntax(data.withTrailingTrivia(newValue, arena: SyntaxArena())))!
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

  /// The length of this node including all of its trivia.
  var totalLength: SourceLength {
    return raw.totalLength
  }

  /// When isImplicit is true, the syntax node doesn't include any
  /// underlying tokens, e.g. an empty CodeBlockItemList.
  var isImplicit: Bool {
    return raw.isEmpty
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
  func tokens(viewMode: SyntaxTreeViewMode) -> TokenSequence {
    return TokenSequence(_syntaxNode, viewMode: viewMode)
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

  /// A copy of this node without the leading trivia of the first token in the
  /// node and the trailing trivia of the last token in the node.
  var trimmed: Self {
    // TODO: Should only need one new node here
    return self.with(\.leadingTrivia, []).with(\.trailingTrivia, [])
  }

  /// The description of this node without the leading trivia of the first token
  /// in the node and the trailing trivia of the last token in the node.
  var trimmedDescription: String {
    // TODO: We shouldn't need to create to copies just to get the description
    // without trivia.
    return self.trimmed.description
  }
}

/// Provides debug descriptions for a node
public extension SyntaxProtocol {
  /// A simple description of this node (ie. its type).
  var debugDescription: String {
    debugDescription()
  }

  var customMirror: Mirror {
    // Suppress printing of children when doing `po node` in the debugger.
    // `debugDescription` already prints them in a nicer way.
    return Mirror(self, children: [:])
  }

  /// Returns a summarized dump of this node.
  /// - Parameters:
  ///   - includeTrivia: Add trivia to each dumped node, which the default
  ///   dump skips.
  ///   - converter: The location converter for the root of the tree. Adds
  ///   `[startLine:startCol...endLine:endCol]` to each node.
  ///   - mark: Adds `***` around the given node, intended to highlight it in
  ///   the dump.
  ///   - indentLevel: The starting indent level, 0 by default. Each level is 2
  ///   spaces.
  func debugDescription(
    includeTrivia: Bool = false,
    converter: SourceLocationConverter? = nil,
    mark: SyntaxProtocol? = nil,
    indentString: String = ""
  ) -> String {
    var str = ""
    debugWrite(
      to: &str,
      includeTrivia: includeTrivia,
      converter: converter,
      mark: mark,
      indentString: indentString
    )
    return str
  }

  private func debugWrite<Target: TextOutputStream>(
    to target: inout Target,
    includeTrivia: Bool,
    converter: SourceLocationConverter? = nil,
    mark: SyntaxProtocol? = nil,
    indentString: String
  ) {
    if let mark = mark, self.id == mark.id {
      target.write("*** ")
    }

    if let token = Syntax(self).as(TokenSyntax.self) {
      target.write(String(describing: token.tokenKind))
      if includeTrivia {
        if !leadingTrivia.isEmpty {
          target.write(" leadingTrivia=\(leadingTrivia.debugDescription)")
        }
        if !trailingTrivia.isEmpty {
          target.write(" trailingTrivia=\(trailingTrivia.debugDescription)")
        }
      }
    } else {
      target.write(String(describing: syntaxNodeType))
    }

    let allChildren = children(viewMode: .all)

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

    for (num, child) in allChildren.enumerated() {
      let isLastChild = num == allChildren.count - 1
      target.write("\n")
      target.write(indentString)
      target.write(isLastChild ? "╰─" : "├─")
      if let keyPath = child.keyPathInParent, let name = childName(keyPath) {
        target.write("\(name): ")
      } else if self.kind.isSyntaxCollection {
        target.write("[\(num)]: ")
      }
      let childIndentString = indentString + (isLastChild ? "  " : "│ ")
      child.debugWrite(
        to: &target,
        includeTrivia: includeTrivia,
        converter: converter,
        mark: mark,
        indentString: childIndentString
      )
    }
  }
}

/// Protocol for the enums nested inside `Syntax` nodes that enumerate all the
/// possible types a child node might have.
public protocol SyntaxChildChoices: SyntaxProtocol {}

/// Sequence of tokens that are part of the provided Syntax node.
public struct TokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    /// The last token to iterate (inclusive).
    let endToken: TokenSyntax?
    let viewMode: SyntaxTreeViewMode

    init(_ token: TokenSyntax?, endToken: TokenSyntax?, viewMode: SyntaxTreeViewMode) {
      self.nextToken = token
      self.endToken = endToken
      self.viewMode = viewMode
    }

    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      if nextToken == endToken {
        self.nextToken = nil
      } else {
        self.nextToken = token.nextToken(viewMode: viewMode)
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
    return Iterator(node.firstToken(viewMode: viewMode), endToken: node.lastToken(viewMode: viewMode), viewMode: viewMode)
  }

  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node, viewMode: viewMode)
  }
}

extension TokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map { $0 })
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
    return Mirror(self, unlabeledChildren: self.map { $0 })
  }
}

@available(*, unavailable, message: "use 'Syntax' instead")
public struct SyntaxNode {}
