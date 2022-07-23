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
///
/// `Syntax` is a type erased syntax node.
///
/// To cast a `Syntax` to the concrete type, use `init?(_:)` on each concrete
/// type. E.g.:
///
///    let syntax: Syntax = createASyntax()
///    if let funcDeclSyntax = FuncDeclSyntax(syntax) {
///      // Do something on 'funcDeclSyntax'...
///    }
///
public struct Syntax: SyntaxProtocol, Hashable {
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return true
  }

  internal var data: SyntaxData
  internal init(data: SyntaxData) { self.data = data }

  public init(syntax: Syntax) {
    self = syntax
  }

  public var syntax: Syntax { self }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, arena: SyntaxArena) {
    self.init(data: .init(rootRaw: raw, arena: arena))
  }

  public init<T: SyntaxProtocol>(_ other: T) {
    self.init(syntax: other.syntax)
  }
}

extension Syntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(reflecting: self.asProtocol(SyntaxProtocol.self))
  }
}

/// Provide common functionality for specialized syntax nodes. Extend this
/// protocol to provide common functionality for all syntax nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol SyntaxProtocol: TextOutputStreamable, CustomStringConvertible, CustomDebugStringConvertible {
  static func isValid(syntaxKind: SyntaxKind) -> Bool
  var syntax: Syntax { get }
  init?<Node: SyntaxProtocol>(_ other: Node)
}

public extension SyntaxProtocol {
  @usableFromInline
  internal var data: SyntaxData {
    _read { yield syntax.data }
  }

  @_spi(RawSyntax)
  var raw: RawSyntax {
    _read { yield syntax.data.raw }
  }

  var arena: SyntaxArena {
    data.arena
  }

  var syntaxKind: SyntaxKind {
    raw.syntaxKind
  }

  var isToken: Bool {
    raw.isToken
  }

  /// Whether or not this node represents an SyntaxCollection.
  var isCollection: Bool {
    raw.isCollection
  }

  /// Whether or not this node represents an unknown node.
  var isUnknown: Bool {
    raw.isUnknown
  }
  
  var byteLength: Int {
    raw.byteLength
  }

  @available(*, deprecated, renamed: "byteLength")
  var byteSize: Int {
    byteLength
  }

  /// The byte source range of this node including leading and trailing trivia.
  var byteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: byteLength)
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  var contentLength: SourceLength {
    SourceLength(utf8Length: byteLength)
  }

  var root: Syntax {
    Syntax(data: data.root)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: Syntax? {
    data.parent.map(Syntax.init(data:))
  }

  /// The index of this node in the parent's children.
  var indexInParent: Int? {
    data.indexInParent
  }

  /// Whether or not this node has a parent.
  var hasParent: Bool {
    data.parent != nil
  }

  var byteOffset: Int {
    data.byteOffset
  }

  var indexInTree: Int {
    data.indexInTree
  }

  /// Checked-cast this instance to `Node` syntax type.
  func `as`<Node: SyntaxProtocol>(_: Node.Type) -> Node? {
    Node(self)
  }

  /// Check if this instance can be cast to the specified syntax type.
  func `is`<Node: SyntaxProtocol>(_: Node.Type) -> Bool {
    Node.isValid(syntaxKind: self.syntaxKind)
  }

  /// Create a new tree making this node the root.
  func asRoot() -> Self {
    Self(raw: raw, arena: arena)!
  }

  @_spi(RawSyntax)
  init?(raw: RawSyntax, arena: SyntaxArena) {
    self.init(Syntax(data: .init(rootRaw: raw, arena: arena)))
  }

  /// A sequence over the "present" children of this node.
  var children: SyntaxChildren {
    return SyntaxChildren(in: self.syntax)
  }

  var leadingTriviaLength: Int {
    raw.leadingTriviaByteLength
  }

  var trailingTriviaLength: Int {
    raw.trailingTriviaByteLength
  }

  /// The leading trivia of this syntax node. Leading trivia is attached to
  /// the first token syntax contained by this node. Without such token, this
  /// property will return nil.
  var leadingTrivia: Trivia? {
    get { raw.leadingTrivia.map { Trivia.make(arena: raw.arena, raw: $0) } }
    set { self = withLeadingTrivia(newValue ?? []) }
  }

  /// The trailing trivia of this syntax node. Trailing trivia is attached to
  /// the last token syntax contained by this node. Without such token, this
  /// property will return nil.
  var trailingTrivia: Trivia? {
    get { raw.trailingTrivia.map { Trivia.make(arena: raw.arena, raw: $0) } }
    set { self = withTrailingTrivia(newValue ?? []) }
  }

  /// Returns a new syntax node with its leading trivia replaced
  /// by the provided trivia.
  func withLeadingTrivia(_ leadingTrivia: Trivia) -> Self {
    guard let newRaw = raw.withLeadingTrivia(leadingTrivia) else {
      return self
    }
    let data = data.replacingSelf(with: newRaw, arena: newRaw.arena)
    return Self(Syntax(data: data))!
  }

  /// Returns a new syntax node with its trailing trivia replaced
  /// by the provided trivia.
  func withTrailingTrivia(_ trailingTrivia: Trivia) -> Self {
    guard let newRaw = raw.withTrailingTrivia(trailingTrivia) else {
      return self
    }
    let data = data.replacingSelf(with: newRaw, arena: newRaw.arena)
    return Self(Syntax(data: data))!
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
}

extension SyntaxProtocol /*: TextOutputStreamable */ {
  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  public func write<Target: TextOutputStream>(to target: inout Target) {
    raw.write(to: &target)
  }
}
extension SyntaxProtocol /*: CustomStringConvertible */ {
  public var description: String {
    var description = ""
    raw.write(to: &description)
    return description
  }
}
extension SyntaxProtocol /*: CustomDebugStringConvertible */ {
  /// Returns a description used by dump.
  public var debugDescription: String {
    return String(reflecting: type(of: self))
  }
}

extension SyntaxProtocol /*: Hashable */ {
  public func hash(into hasher: inout Hasher) {
    data.hash(into: &hasher)
  }
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.data == rhs.data
  }
}

extension SyntaxProtocol /*: Identifiable */ {
  public var id: SyntaxIdentifier {
    return data.id
  }
}


/// Represents a token syntax node.
///
/// Token syntax is a "leaf" node in the syntax tree. It holds a chunk of the
/// actual source code the syntax tree represents.
public struct TokenSyntax: SyntaxProtocol, Hashable {
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .token
  }
  public let syntax: Syntax
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard other.syntaxKind == .token else { return nil }
    self.init(data: other.data)
  }

  public var isMissing: Bool {
    raw.isMissing
  }

  public var isPresent: Bool {
    !isMissing
  }

  public var presence: SourcePresence {
    return raw.isMissing ? .missing : .present
  }

  public var tokenKind: TokenKind {
    get { raw.tokenKind }
    set { self = withKind(newValue) }
  }

  public func withUnsafeTokenText<T>(_ body: (StringRef) -> T) -> T {
    body(raw.tokenText!)
  }

  public func withUnsafeLeadingTriviaText<T>(_ body: (StringRef) -> T) -> T {
    raw.leadingTrivia!.withUnsafeText(body)
  }

  public func withUnsafeTrailingTriviaText<T>(_ body: (StringRef) -> T) -> T {
    raw.trailingTrivia!.withUnsafeText(body)
  }

  public var text: String {
    get { String(stringRef: raw.tokenText!) }
    set { self = withTokenText(newValue) }
  }

  public var leadingTriviaText: String {
    get { String(describing: raw.leadingTrivia!) }
    set { self = withLeadingTriviaText(newValue) }
  }

  public var trailingTriviaText: String {
    get { String(describing: raw.trailingTrivia!) }
    set { self = withTrailingTriviaText(newValue) }
  }

  public var leadingTriviaLength: Int {
    raw.leadingTriviaByteLength
  }

  public var trailingTriviaLength: Int {
    raw.trailingTriviaByteLength
  }

  public var leadingTrivia: Trivia {
    get { Trivia.make(arena: raw.arena, raw: raw.leadingTrivia!) }
    set { self = withLeadingTrivia(newValue) }
  }

  public var trailingTrivia: Trivia {
    get { Trivia.make(arena: raw.arena, raw: raw.trailingTrivia!) }
    set { self = withTrailingTrivia(newValue) }
  }

  public func withKind(_ newValue: TokenKind) -> TokenSyntax {
    let newRaw = raw.withTokenKind(newValue)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public func withTokenText(_ newValue: String) -> TokenSyntax {
    let newRaw = raw.withTokenText(newValue)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public func withLeadingTriviaText(_ newValue: String) -> TokenSyntax {
    let newRaw = RawSyntax.makeParsedToken(
      arena: arena, kind: tokenKind, text: text,
      leadingTrivia: newValue, trailingTrivia: trailingTriviaText)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public func withTrailingTriviaText(_ newValue: String) -> TokenSyntax {
    let newRaw = RawSyntax.makeParsedToken(
      arena: arena, kind: tokenKind, text: text,
      leadingTrivia: leadingTriviaText, trailingTrivia: newValue)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public func withLeadingTrivia(_ newValue: Trivia) -> TokenSyntax {
    let newRaw = RawSyntax.makeMaterializedToken(
      arena: arena, kind: raw.tokenKind, text: text,
      leadingTrivia: newValue, trailingTrivia: trailingTrivia)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }

  public func withTrailingTrivia(_ newValue: Trivia) -> TokenSyntax {
    let newRaw = RawSyntax.makeMaterializedToken(
      arena: arena, kind: raw.tokenKind, text: text,
      leadingTrivia: leadingTrivia, trailingTrivia: newValue)
    return Self(data: data.replacingSelf(with: newRaw, arena: arena))
  }
}

extension TokenSyntax: CustomReflectable {
  public var customMirror: Mirror {
    Mirror(self, children: [
      "text": text,
      "leadingTrivia": leadingTrivia,
      "trailingTrivia": trailingTrivia,
      "tokenKind": tokenKind,
    ])
  }
}

/// A protocol for "list" syntax nodes.
///
/// This protcol implements most interface of the concrete type.
public protocol SyntaxCollection: SyntaxProtocol, BidirectionalCollection, MutableCollection, CustomReflectable
  where Index == Int, Element: SyntaxProtocol, SubSequence == Slice<Self> {}

public extension SyntaxCollection {
  /// The number of elements in the list.
  var count: Int { return raw.children.count }

  /// Create a new node inserting an element at the specified index.
  func inserting(_ element: Element, at index: Index) -> Self {
    let newRaw = raw.insertingChild(element.raw, at: index, arena: arena)
    return Self(Syntax(data: data.replacingSelf(with: newRaw, arena: arena)))!
  }

  /// Create a new node prepending an element to the existing elements.
  func prepending(_ syntax: Element) -> Self {
    inserting(syntax, at: 0)
  }

  /// Create a new node appending an element to the existing elements.
  func appending(_ syntax: Element) -> Self {
    inserting(syntax, at: count)
  }

  /// Create a new node replacing a an element with the specified value.
  func replacing(childAt index: Index, with element: Element) -> Self {
    let newRaw = raw.replacingChild(at: index, with: element.raw, arena: arena)
    return Self(Syntax(data: data.replacingSelf(with: newRaw, arena: arena)))!
  }

  /// Create a new node replacing the elements in the specified range with the
  /// specified elements.
  func replacingSubrange<C: Collection>(_ subrange: Range<Index>, with elements: C) -> Self where C.Element == Element {
    let rawElements = elements.map { $0.raw }
    let newRaw = raw.replacingChildSubrange(subrange, with: rawElements, arena: arena)
    return Self(Syntax(data: data.replacingSelf(with: newRaw, arena: arena)))!
  }

  /// Creates a new instance by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `Self` instance with the element at the provided index
  ///   removed.
  func removing(childAt index: Int) -> Self {
    let newRaw = raw.removingChild(at: index, arena: arena)
    return Self(Syntax(data: data.replacingSelf(with: newRaw, arena: arena)))!
  }

  /// Creates a new instance by removing the first element.
  ///
  /// - Returns: A new `Self` instance with the first element removed.
  func removingFirst() -> Self {
    return removing(childAt: 0)
  }

  /// Creates a new instance by removing the first element.
  ///
  /// - Returns: A new `Self` instance with the last element removed.
  func removingLast() -> Self {
    return removing(childAt: self.count - 1)
  }
}

public extension SyntaxCollection {
  mutating func insert(_ syntax: Element, at index: Index) {
    self = self.inserting(syntax, at: index)
  }

  mutating func prepend(_ syntax: Element) {
    self = self.prepending(syntax)
  }

  mutating func append(_ syntax: Element) {
    self = self.appending(syntax)
  }

  mutating func replace(childAt index: Index, with syntax: Element) {
    self = self.replacing(childAt: index, with: syntax)
  }

  mutating func replaceSubrange<C: Collection>(_ subrange: Range<Index>, with elements: C) where Element == C.Element {
    self = self.replacingSubrange(subrange, with: elements)
  }
}

public extension SyntaxCollection /*: BidirectionalCollection */ {
  var startIndex: Index { raw.children.startIndex }
  var endIndex: Index { raw.children.endIndex }

  func index(after i: Index) -> Index {
    i + 1
  }
  func index(before i: Index) -> Index {
    i - 1
  }

  subscript(position: Index) -> Element {
    // FIXME: (performance) data.child(at:) is a O(n) operation.
    // SyntaxCollection should provide its own Index to avoid O(n)
    get { Element(Syntax(data: data.child(at: position)!))! }
    set { self = replacing(childAt: position, with: newValue) }
  }

  subscript(bounds: Range<Index>) -> SubSequence {
    get { Slice(base: self, bounds: bounds) }
    set { self = self.replacingSubrange(bounds, with: newValue) }
  }
}

public extension SyntaxCollection /*: CustomReflectable*/ {
  var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self)
  }
}

public struct UnknownSyntax: SyntaxProtocol, Hashable, CustomReflectable {
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    syntaxKind == .unknown
  }
  public let syntax: Syntax
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  public var customMirror: Mirror {
    return Mirror(self, children: [:])
  }
}
