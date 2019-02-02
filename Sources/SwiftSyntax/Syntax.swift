//===-------------------- Syntax.swift - Syntax Protocol ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// A Syntax node represents a tree of nodes with tokens at the leaves.
/// Each node has accessors for its known children, and allows efficient
/// iteration over the children through its `children` property.
public protocol Syntax: 
  CustomStringConvertible, TextOutputStreamable {}

internal protocol _SyntaxBase: Syntax {
  /// The data backing this node.
  var data: SyntaxData { get }
}

extension _SyntaxBase {
  /// Access the raw syntax.
  var raw: RawSyntax {
    return data.raw
  }

  /// A sequence over the `present` children of this node.
  var children: SyntaxBaseChildren {
    return SyntaxBaseChildren(self)
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

  /// Whether or not this node represents an Expression.
  var isExpr: Bool {
    return raw.kind.isExpr
  }

  /// Whether or not this node represents a Declaration.
  var isDecl: Bool {
    return raw.kind.isDecl
  }

  /// Whether or not this node represents a Statement.
  var isStmt: Bool {
    return raw.kind.isStmt
  }

  /// Whether or not this node represents a Type.
  var isType: Bool {
    return raw.kind.isType
  }

  /// Whether or not this node represents a Pattern.
  var isPattern: Bool {
    return raw.kind.isPattern
  }

  /// Whether or not this node represents an unknown node.
  var isUnknown: Bool {
    return raw.kind.isUnknown
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: _SyntaxBase? {
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
    for absoluteRaw in PresentRawSyntaxPreviousSiblings(self) {
      let child = makeSyntax(SyntaxData(absoluteRaw, parent: parent))
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
    for absoluteRaw in PresentRawSyntaxNextSiblings(self) {
      let child = makeSyntax(SyntaxData(absoluteRaw, parent: parent))
      if let token = child.firstToken {
        return token
      }
    }
    return parent.nextToken
  }

  /// Returns the first token node that is part of this syntax node.
  var firstToken: TokenSyntax? {
    if isMissing { return nil }
    if isToken {
      return (self as! TokenSyntax)
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
    if isToken {
      return (self as! TokenSyntax)
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

  /// The absolute position where this node (excluding its trailing trivia)
  /// ends.
  var endPosition: AbsolutePosition {
    return data.endPosition
  }

  /// The absolute position where this node's trailing trivia ends
  var endPositionAfterTrailingTrivia: AbsolutePosition {
    return data.endPositionAfterTrailingTrivia
  }

  /// The textual byte length of this node including leading and trailing trivia.
  var byteSize: Int {
    return totalLength.utf8Length
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
    return raw.leadingTrivia
  }

  /// The trailing trivia of this syntax node. Trailing trivia is attached to
  /// the last token syntax contained by this node. Without such token, this
  /// property will return nil.
  var trailingTrivia: Trivia? {
    return raw.trailingTrivia
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
    return leadingTrivia == nil
  }

  /// The textual byte length of this node exluding leading and trailing trivia.
  var byteSizeAfterTrimmingTrivia: Int {
    return contentLength.utf8Length
  }

  /// The root of the tree in which this node resides.
  var root: _SyntaxBase {
    var this: _SyntaxBase = self
    while let parent = this.parent {
      this = parent
    }
    return this
  }

  /// Sequence of tokens that are part of this Syntax node.
  var tokens: TokenSequence {
    return TokenSequence(self)
  }

  /// Returns a value representing the unique identity of the node.
  var uniqueIdentifier: SyntaxIdentifier {
    return data.nodeId
  }

  /// A source-accurate description of this node.
  public var description: String {
    var s = ""
    self.write(to: &s)
    return s
  }
  
  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  public func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    data.raw.write(to: &target)
  }
}

extension Syntax {
  var base: _SyntaxBase {
    guard let base = self as? _SyntaxBase else {
      fatalError("only first-class syntax nodes can conform to Syntax")
    }
    return base
  }

  /// Access the raw syntax assuming the node is a Syntax.
  var raw: RawSyntax {
    return base.raw
  }

  /// A sequence over the `present` children of this node.
  public var children: SyntaxChildren {
    return SyntaxChildren(base)
  }

  /// Whether or not this node is marked as `present`.
  public var isPresent: Bool {
    return base.isPresent
  }

  /// Whether or not this node is marked as `missing`.
  public var isMissing: Bool {
    return base.isMissing
  }

  /// Whether or not this node is a token one.
  public var isToken: Bool {
    return base.isToken
  }

  /// Whether or not this node represents an Expression.
  public var isExpr: Bool {
    return base.isExpr
  }

  /// Whether or not this node represents a Declaration.
  public var isDecl: Bool {
    return base.isDecl
  }

  /// Whether or not this node represents a Statement.
  public var isStmt: Bool {
    return base.isStmt
  }

  /// Whether or not this node represents a Type.
  public var isType: Bool {
    return base.isType
  }

  /// Whether or not this node represents a Pattern.
  public var isPattern: Bool {
    return base.isPattern
  }

  /// Whether or not this node represents an unknown node.
  public var isUnknown: Bool {
    return base.isUnknown
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  public var parent: Syntax? {
    return base.parent
  }

  /// The index of this node in the parent's children.
  public var indexInParent: Int {
    return base.indexInParent
  }

  /// Whether or not this node has a parent.
  public var hasParent: Bool {
    return base.hasParent
  }

  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  public var previousToken: TokenSyntax? {
    return base.previousToken
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  public var nextToken: TokenSyntax? {
    return base.nextToken
  }

  /// Returns the first token node that is part of this syntax node.
  public var firstToken: TokenSyntax? {
    return base.firstToken
  }

  /// Returns the last token node that is part of this syntax node.
  public var lastToken: TokenSyntax? {
    return base.lastToken
  }

  /// The absolute position of the starting point of this node. If the first token
  /// is with leading trivia, the position points to the start of the leading
  /// trivia.
  public var position: AbsolutePosition {
    return base.position
  }

  /// The absolute position of the starting point of this node, skipping any
  /// leading trivia attached to the first token syntax.
  public var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return base.positionAfterSkippingLeadingTrivia
  }

  /// The absolute position where this node (excluding its trailing trivia)
  /// ends.
  public var endPosition: AbsolutePosition {
    return base.endPosition
  }

  /// The absolute position where this node's trailing trivia ends
  public var endPositionAfterTrailingTrivia: AbsolutePosition {
    return base.endPositionAfterTrailingTrivia
  }

  /// The textual byte length of this node including leading and trailing trivia.
  public var byteSize: Int {
    return base.byteSize
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  public var contentLength: SourceLength {
    return base.contentLength
  }

  /// The leading trivia of this syntax node. Leading trivia is attached to
  /// the first token syntax contained by this node. Without such token, this
  /// property will return nil.
  public var leadingTrivia: Trivia? {
    return base.leadingTrivia
  }

  /// The trailing trivia of this syntax node. Trailing trivia is attached to
  /// the last token syntax contained by this node. Without such token, this
  /// property will return nil.
  public var trailingTrivia: Trivia? {
    return base.trailingTrivia
  }

  /// The length this node's leading trivia takes up spelled out in source.
  public var leadingTriviaLength: SourceLength {
    return base.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  public var trailingTriviaLength: SourceLength {
    return base.trailingTriviaLength
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return base.totalLength
  }

  /// When isImplicit is true, the syntax node doesn't include any
  /// underlying tokens, e.g. an empty CodeBlockItemList.
  public var isImplicit: Bool {
    return base.isImplicit
  }

  /// The textual byte length of this node exluding leading and trailing trivia.
  public var byteSizeAfterTrimmingTrivia: Int {
    return base.byteSizeAfterTrimmingTrivia
  }

  /// The root of the tree in which this node resides.
  public var root: Syntax {
    return base.root
  }

  /// Sequence of tokens that are part of this Syntax node.
  public var tokens: TokenSequence {
    return base.tokens
  }

  /// Returns a value representing the unique identity of the node.
  public var uniqueIdentifier: SyntaxIdentifier {
    return base.uniqueIdentifier
  }

  /// A source-accurate description of this node.
  public var description: String {
    return base.description
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  public func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    return base.write(to: &target)
  }
}

/// Determines if two nodes are equal to each other.
func ==(lhs: _SyntaxBase, rhs: _SyntaxBase) -> Bool {
  return lhs.data.nodeId == rhs.data.nodeId
}

/// Determines if two nodes are equal to each other.
public func ==(lhs: Syntax, rhs: Syntax) -> Bool {
  return lhs.base.data.nodeId == rhs.base.data.nodeId
}

/// MARK: - Nodes

/// A Syntax node representing a single token.
public struct TokenSyntax: _SyntaxBase, Hashable {
  let data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The text of the token as written in the source code.
  public var text: String {
    return tokenKind.text
  }
  
  /// Returns a new TokenSyntax with its kind replaced
  /// by the provided token kind.
  public func withKind(_ tokenKind: TokenKind) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    let newRaw = RawSyntax.createAndCalcLength(kind: tokenKind,
      leadingTrivia: raw.leadingTrivia!, trailingTrivia: raw.trailingTrivia!,
      presence: raw.presence)
    let newData = data.replacingSelf(newRaw)
    return TokenSyntax(newData)
  }

  /// Returns a new TokenSyntax with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    let newRaw = RawSyntax.createAndCalcLength(kind: raw.tokenKind!,
      leadingTrivia: leadingTrivia, trailingTrivia: raw.trailingTrivia!,
      presence: raw.presence)
    let newData = data.replacingSelf(newRaw)
    return TokenSyntax(newData)
  }

  /// Returns a new TokenSyntax with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    let newRaw = RawSyntax.createAndCalcLength(kind: raw.tokenKind!,
                           leadingTrivia: raw.leadingTrivia!,
                           trailingTrivia: trailingTrivia,
                           presence: raw.presence)
    let newData = data.replacingSelf(newRaw)
    return TokenSyntax(newData)
  }

  /// Returns a new TokenSyntax with its leading trivia removed.
  public func withoutLeadingTrivia() -> TokenSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new TokenSyntax with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TokenSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new TokenSyntax with all trivia removed.
  public func withoutTrivia() -> TokenSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this token.
  public var leadingTrivia: Trivia {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    return raw.leadingTrivia!
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this token.
  public var trailingTrivia: Trivia {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    return raw.trailingTrivia!
  }

  /// The kind of token this node represents.
  public var tokenKind: TokenKind {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    return raw.tokenKind!
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  public var contentLength: SourceLength {
    return raw.contentLength
  }
  
  /// The length this node's leading trivia takes up spelled out in source.
  public var leadingTriviaLength: SourceLength {
    return raw.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  public var trailingTriviaLength: SourceLength {
    return raw.trailingTriviaLength
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return raw.totalLength
  }

  public static func ==(lhs: TokenSyntax, rhs: TokenSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
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

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  public init(_ node: Syntax) {
    self.node = node.base
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.firstToken, endPosition: node.endPosition)
  }

  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node)
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

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  public init(_ node: Syntax) {
    self.node = node.base
  }

  public func makeIterator() -> Iterator {
    return Iterator(node.lastToken, startPosition: node.position)
  }

  public func reversed() -> TokenSequence {
    return TokenSequence(node)
  }
}
