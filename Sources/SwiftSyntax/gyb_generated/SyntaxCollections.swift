//// Automatically Generated From SyntaxCollections.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxCollections.swift.gyb - Syntax Collection ---------===//
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

public protocol SyntaxCollection: SyntaxProtocol, Sequence where Element: SyntaxProtocol {
  /// The number of elements, `present` or `missing`, in this collection.
  var count: Int { get }
}

public extension SyntaxCollection {
  static var structure: SyntaxNodeStructure {
    return .collection(Element.self)
  }
}


/// `CodeBlockItemListSyntax` represents a collection of one or more
/// `CodeBlockItemSyntax` nodes. CodeBlockItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CodeBlockItemListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = CodeBlockItemSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .codeBlockItemList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .codeBlockItemList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `CodeBlockItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CodeBlockItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CodeBlockItemListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return CodeBlockItemListSyntax(newData)
  }

  /// Creates a new `CodeBlockItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CodeBlockItemListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CodeBlockItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> CodeBlockItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CodeBlockItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CodeBlockItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the first element removed.
  public func removingFirst() -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the last element removed.
  public func removingLast() -> CodeBlockItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `CodeBlockItemListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> CodeBlockItemListSyntax {
    return CodeBlockItemListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CodeBlockItemListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> CodeBlockItemListSyntax {
    return CodeBlockItemListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CodeBlockItemListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> CodeBlockItemListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `CodeBlockItemListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> CodeBlockItemListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `CodeBlockItemListSyntax` with all trivia removed.
  public func withoutTrivia() -> CodeBlockItemListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `CodeBlockItemListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `CodeBlockItemListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `CodeBlockItemListSyntax` to the `BidirectionalCollection` protocol.
extension CodeBlockItemListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// 
/// A collection of syntax nodes that occurred in the source code but
/// could not be used to form a valid syntax tree.
/// 
public struct UnexpectedNodesSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = Syntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .unexpectedNodes else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unexpectedNodes)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unexpectedNodes,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `UnexpectedNodesSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `UnexpectedNodesSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> UnexpectedNodesSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return UnexpectedNodesSyntax(newData)
  }

  /// Creates a new `UnexpectedNodesSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `UnexpectedNodesSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `UnexpectedNodesSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `UnexpectedNodesSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> UnexpectedNodesSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `UnexpectedNodesSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `UnexpectedNodesSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `UnexpectedNodesSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `UnexpectedNodesSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `UnexpectedNodesSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `UnexpectedNodesSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `UnexpectedNodesSyntax` by removing the first element.
  ///
  /// - Returns: A new `UnexpectedNodesSyntax` with the first element removed.
  public func removingFirst() -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `UnexpectedNodesSyntax` by removing the last element.
  ///
  /// - Returns: A new `UnexpectedNodesSyntax` with the last element removed.
  public func removingLast() -> UnexpectedNodesSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `UnexpectedNodesSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> UnexpectedNodesSyntax {
    return UnexpectedNodesSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `UnexpectedNodesSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> UnexpectedNodesSyntax {
    return UnexpectedNodesSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `UnexpectedNodesSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> UnexpectedNodesSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `UnexpectedNodesSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> UnexpectedNodesSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `UnexpectedNodesSyntax` with all trivia removed.
  public func withoutTrivia() -> UnexpectedNodesSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `UnexpectedNodesSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `UnexpectedNodesSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `UnexpectedNodesSyntax` to the `BidirectionalCollection` protocol.
extension UnexpectedNodesSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `TupleExprElementListSyntax` represents a collection of one or more
/// `TupleExprElementSyntax` nodes. TupleExprElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleExprElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = TupleExprElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tupleExprElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleExprElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `TupleExprElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TupleExprElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TupleExprElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return TupleExprElementListSyntax(newData)
  }

  /// Creates a new `TupleExprElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TupleExprElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleExprElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TupleExprElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> TupleExprElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TupleExprElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TupleExprElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleExprElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TupleExprElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleExprElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TupleExprElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleExprElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TupleExprElementListSyntax` with the first element removed.
  public func removingFirst() -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleExprElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TupleExprElementListSyntax` with the last element removed.
  public func removingLast() -> TupleExprElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `TupleExprElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TupleExprElementListSyntax {
    return TupleExprElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TupleExprElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TupleExprElementListSyntax {
    return TupleExprElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TupleExprElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> TupleExprElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `TupleExprElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TupleExprElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `TupleExprElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> TupleExprElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `TupleExprElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `TupleExprElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `TupleExprElementListSyntax` to the `BidirectionalCollection` protocol.
extension TupleExprElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ArrayElementListSyntax` represents a collection of one or more
/// `ArrayElementSyntax` nodes. ArrayElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ArrayElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ArrayElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .arrayElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrayElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ArrayElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ArrayElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ArrayElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ArrayElementListSyntax(newData)
  }

  /// Creates a new `ArrayElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ArrayElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ArrayElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ArrayElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ArrayElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ArrayElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the first element removed.
  public func removingFirst() -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the last element removed.
  public func removingLast() -> ArrayElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ArrayElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ArrayElementListSyntax {
    return ArrayElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ArrayElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ArrayElementListSyntax {
    return ArrayElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ArrayElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ArrayElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ArrayElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ArrayElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ArrayElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> ArrayElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ArrayElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ArrayElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ArrayElementListSyntax` to the `BidirectionalCollection` protocol.
extension ArrayElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `DictionaryElementListSyntax` represents a collection of one or more
/// `DictionaryElementSyntax` nodes. DictionaryElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DictionaryElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = DictionaryElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .dictionaryElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dictionaryElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `DictionaryElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DictionaryElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DictionaryElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return DictionaryElementListSyntax(newData)
  }

  /// Creates a new `DictionaryElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DictionaryElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DictionaryElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> DictionaryElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DictionaryElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DictionaryElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the first element removed.
  public func removingFirst() -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the last element removed.
  public func removingLast() -> DictionaryElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `DictionaryElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> DictionaryElementListSyntax {
    return DictionaryElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DictionaryElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> DictionaryElementListSyntax {
    return DictionaryElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DictionaryElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> DictionaryElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `DictionaryElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> DictionaryElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `DictionaryElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> DictionaryElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `DictionaryElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `DictionaryElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `DictionaryElementListSyntax` to the `BidirectionalCollection` protocol.
extension DictionaryElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `StringLiteralSegmentsSyntax` represents a collection of one or more
/// `Syntax` nodes. StringLiteralSegmentsSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct StringLiteralSegmentsSyntax: SyntaxCollection, SyntaxHashable {
  @frozen // FIXME: Not actually stable, works around a miscompile
  public enum Element: SyntaxChildChoices {
    case `stringSegment`(StringSegmentSyntax)
    case `expressionSegment`(ExpressionSegmentSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .stringSegment(let node): return node._syntaxNode
      case .expressionSegment(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: StringSegmentSyntax) {
      self = .stringSegment(node)
    }
    public init(_ node: ExpressionSegmentSyntax) {
      self = .expressionSegment(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(StringSegmentSyntax.self) {
        self = .stringSegment(node)
        return
      }
      if let node = node.as(ExpressionSegmentSyntax.self) {
        self = .expressionSegment(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(StringSegmentSyntax.self),
        .node(ExpressionSegmentSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .stringLiteralSegments else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .stringLiteralSegments)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralSegments,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `StringLiteralSegmentsSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `StringLiteralSegmentsSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> StringLiteralSegmentsSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return StringLiteralSegmentsSyntax(newData)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `StringLiteralSegmentsSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `StringLiteralSegmentsSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> StringLiteralSegmentsSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `StringLiteralSegmentsSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `StringLiteralSegmentsSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `StringLiteralSegmentsSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by removing the first element.
  ///
  /// - Returns: A new `StringLiteralSegmentsSyntax` with the first element removed.
  public func removingFirst() -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringLiteralSegmentsSyntax` by removing the last element.
  ///
  /// - Returns: A new `StringLiteralSegmentsSyntax` with the last element removed.
  public func removingLast() -> StringLiteralSegmentsSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `StringLiteralSegmentsSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> StringLiteralSegmentsSyntax {
    return StringLiteralSegmentsSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `StringLiteralSegmentsSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> StringLiteralSegmentsSyntax {
    return StringLiteralSegmentsSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `StringLiteralSegmentsSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> StringLiteralSegmentsSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `StringLiteralSegmentsSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> StringLiteralSegmentsSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `StringLiteralSegmentsSyntax` with all trivia removed.
  public func withoutTrivia() -> StringLiteralSegmentsSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `StringLiteralSegmentsSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `StringLiteralSegmentsSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `StringLiteralSegmentsSyntax` to the `BidirectionalCollection` protocol.
extension StringLiteralSegmentsSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `DeclNameArgumentListSyntax` represents a collection of one or more
/// `DeclNameArgumentSyntax` nodes. DeclNameArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DeclNameArgumentListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = DeclNameArgumentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .declNameArgumentList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declNameArgumentList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgumentList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `DeclNameArgumentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DeclNameArgumentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DeclNameArgumentListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return DeclNameArgumentListSyntax(newData)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> DeclNameArgumentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DeclNameArgumentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the first element removed.
  public func removingFirst() -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the last element removed.
  public func removingLast() -> DeclNameArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `DeclNameArgumentListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> DeclNameArgumentListSyntax {
    return DeclNameArgumentListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DeclNameArgumentListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> DeclNameArgumentListSyntax {
    return DeclNameArgumentListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DeclNameArgumentListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> DeclNameArgumentListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `DeclNameArgumentListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> DeclNameArgumentListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `DeclNameArgumentListSyntax` with all trivia removed.
  public func withoutTrivia() -> DeclNameArgumentListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `DeclNameArgumentListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `DeclNameArgumentListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `DeclNameArgumentListSyntax` to the `BidirectionalCollection` protocol.
extension DeclNameArgumentListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// 
/// A list of expressions connected by operators. This list is contained
/// by a `SequenceExprSyntax`.
/// 
public struct ExprListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ExprSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .exprList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .exprList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.exprList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ExprListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ExprListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ExprListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ExprListSyntax(newData)
  }

  /// Creates a new `ExprListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ExprListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ExprListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ExprListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ExprListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ExprListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ExprListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ExprListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ExprListSyntax` with the first element removed.
  public func removingFirst() -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ExprListSyntax` with the last element removed.
  public func removingLast() -> ExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ExprListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ExprListSyntax {
    return ExprListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ExprListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ExprListSyntax {
    return ExprListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ExprListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ExprListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ExprListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ExprListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ExprListSyntax` with all trivia removed.
  public func withoutTrivia() -> ExprListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ExprListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ExprListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ExprListSyntax` to the `BidirectionalCollection` protocol.
extension ExprListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ClosureCaptureItemListSyntax` represents a collection of one or more
/// `ClosureCaptureItemSyntax` nodes. ClosureCaptureItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureCaptureItemListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ClosureCaptureItemSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureCaptureItemList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureItemList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItemList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ClosureCaptureItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ClosureCaptureItemListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ClosureCaptureItemListSyntax(newData)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ClosureCaptureItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the first element removed.
  public func removingFirst() -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the last element removed.
  public func removingLast() -> ClosureCaptureItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ClosureCaptureItemListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ClosureCaptureItemListSyntax {
    return ClosureCaptureItemListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ClosureCaptureItemListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ClosureCaptureItemListSyntax {
    return ClosureCaptureItemListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ClosureCaptureItemListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ClosureCaptureItemListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ClosureCaptureItemListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ClosureCaptureItemListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ClosureCaptureItemListSyntax` with all trivia removed.
  public func withoutTrivia() -> ClosureCaptureItemListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ClosureCaptureItemListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ClosureCaptureItemListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ClosureCaptureItemListSyntax` to the `BidirectionalCollection` protocol.
extension ClosureCaptureItemListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ClosureParamListSyntax` represents a collection of one or more
/// `ClosureParamSyntax` nodes. ClosureParamListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureParamListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ClosureParamSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .closureParamList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureParamList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParamList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ClosureParamListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ClosureParamListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ClosureParamListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ClosureParamListSyntax(newData)
  }

  /// Creates a new `ClosureParamListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ClosureParamListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ClosureParamListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ClosureParamListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ClosureParamListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ClosureParamListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the first element removed.
  public func removingFirst() -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the last element removed.
  public func removingLast() -> ClosureParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ClosureParamListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ClosureParamListSyntax {
    return ClosureParamListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ClosureParamListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ClosureParamListSyntax {
    return ClosureParamListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ClosureParamListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ClosureParamListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ClosureParamListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ClosureParamListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ClosureParamListSyntax` with all trivia removed.
  public func withoutTrivia() -> ClosureParamListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ClosureParamListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ClosureParamListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ClosureParamListSyntax` to the `BidirectionalCollection` protocol.
extension ClosureParamListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `MultipleTrailingClosureElementListSyntax` represents a collection of one or more
/// `MultipleTrailingClosureElementSyntax` nodes. MultipleTrailingClosureElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct MultipleTrailingClosureElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = MultipleTrailingClosureElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .multipleTrailingClosureElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .multipleTrailingClosureElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> MultipleTrailingClosureElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return MultipleTrailingClosureElementListSyntax(newData)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> MultipleTrailingClosureElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with the first element removed.
  public func removingFirst() -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `MultipleTrailingClosureElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `MultipleTrailingClosureElementListSyntax` with the last element removed.
  public func removingLast() -> MultipleTrailingClosureElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `MultipleTrailingClosureElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> MultipleTrailingClosureElementListSyntax {
    return MultipleTrailingClosureElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `MultipleTrailingClosureElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> MultipleTrailingClosureElementListSyntax {
    return MultipleTrailingClosureElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `MultipleTrailingClosureElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> MultipleTrailingClosureElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `MultipleTrailingClosureElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> MultipleTrailingClosureElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `MultipleTrailingClosureElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> MultipleTrailingClosureElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `MultipleTrailingClosureElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `MultipleTrailingClosureElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `MultipleTrailingClosureElementListSyntax` to the `BidirectionalCollection` protocol.
extension MultipleTrailingClosureElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `KeyPathComponentListSyntax` represents a collection of one or more
/// `KeyPathComponentSyntax` nodes. KeyPathComponentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct KeyPathComponentListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = KeyPathComponentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .keyPathComponentList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .keyPathComponentList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponentList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `KeyPathComponentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `KeyPathComponentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> KeyPathComponentListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return KeyPathComponentListSyntax(newData)
  }

  /// Creates a new `KeyPathComponentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `KeyPathComponentListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `KeyPathComponentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `KeyPathComponentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> KeyPathComponentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `KeyPathComponentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `KeyPathComponentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `KeyPathComponentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `KeyPathComponentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `KeyPathComponentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `KeyPathComponentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `KeyPathComponentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `KeyPathComponentListSyntax` with the first element removed.
  public func removingFirst() -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `KeyPathComponentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `KeyPathComponentListSyntax` with the last element removed.
  public func removingLast() -> KeyPathComponentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `KeyPathComponentListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> KeyPathComponentListSyntax {
    return KeyPathComponentListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `KeyPathComponentListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> KeyPathComponentListSyntax {
    return KeyPathComponentListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `KeyPathComponentListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> KeyPathComponentListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `KeyPathComponentListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> KeyPathComponentListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `KeyPathComponentListSyntax` with all trivia removed.
  public func withoutTrivia() -> KeyPathComponentListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `KeyPathComponentListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `KeyPathComponentListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `KeyPathComponentListSyntax` to the `BidirectionalCollection` protocol.
extension KeyPathComponentListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `YieldExprListSyntax` represents a collection of one or more
/// `YieldExprListElementSyntax` nodes. YieldExprListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct YieldExprListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = YieldExprListElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .yieldExprList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldExprList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `YieldExprListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `YieldExprListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> YieldExprListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return YieldExprListSyntax(newData)
  }

  /// Creates a new `YieldExprListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `YieldExprListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `YieldExprListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `YieldExprListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> YieldExprListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `YieldExprListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `YieldExprListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `YieldExprListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `YieldExprListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `YieldExprListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `YieldExprListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `YieldExprListSyntax` by removing the first element.
  ///
  /// - Returns: A new `YieldExprListSyntax` with the first element removed.
  public func removingFirst() -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `YieldExprListSyntax` by removing the last element.
  ///
  /// - Returns: A new `YieldExprListSyntax` with the last element removed.
  public func removingLast() -> YieldExprListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `YieldExprListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> YieldExprListSyntax {
    return YieldExprListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `YieldExprListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> YieldExprListSyntax {
    return YieldExprListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `YieldExprListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> YieldExprListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `YieldExprListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> YieldExprListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `YieldExprListSyntax` with all trivia removed.
  public func withoutTrivia() -> YieldExprListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `YieldExprListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `YieldExprListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `YieldExprListSyntax` to the `BidirectionalCollection` protocol.
extension YieldExprListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `FunctionParameterListSyntax` represents a collection of one or more
/// `FunctionParameterSyntax` nodes. FunctionParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct FunctionParameterListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = FunctionParameterSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .functionParameterList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionParameterList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameterList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `FunctionParameterListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `FunctionParameterListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> FunctionParameterListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return FunctionParameterListSyntax(newData)
  }

  /// Creates a new `FunctionParameterListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `FunctionParameterListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `FunctionParameterListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> FunctionParameterListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `FunctionParameterListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `FunctionParameterListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the first element.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the first element removed.
  public func removingFirst() -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the last element.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the last element removed.
  public func removingLast() -> FunctionParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `FunctionParameterListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> FunctionParameterListSyntax {
    return FunctionParameterListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `FunctionParameterListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> FunctionParameterListSyntax {
    return FunctionParameterListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `FunctionParameterListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> FunctionParameterListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `FunctionParameterListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> FunctionParameterListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `FunctionParameterListSyntax` with all trivia removed.
  public func withoutTrivia() -> FunctionParameterListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `FunctionParameterListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `FunctionParameterListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `FunctionParameterListSyntax` to the `BidirectionalCollection` protocol.
extension FunctionParameterListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `IfConfigClauseListSyntax` represents a collection of one or more
/// `IfConfigClauseSyntax` nodes. IfConfigClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct IfConfigClauseListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = IfConfigClauseSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .ifConfigClauseList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifConfigClauseList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClauseList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `IfConfigClauseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `IfConfigClauseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> IfConfigClauseListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return IfConfigClauseListSyntax(newData)
  }

  /// Creates a new `IfConfigClauseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `IfConfigClauseListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `IfConfigClauseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> IfConfigClauseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `IfConfigClauseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `IfConfigClauseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the first element removed.
  public func removingFirst() -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the last element removed.
  public func removingLast() -> IfConfigClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `IfConfigClauseListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> IfConfigClauseListSyntax {
    return IfConfigClauseListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `IfConfigClauseListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> IfConfigClauseListSyntax {
    return IfConfigClauseListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `IfConfigClauseListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> IfConfigClauseListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `IfConfigClauseListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> IfConfigClauseListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `IfConfigClauseListSyntax` with all trivia removed.
  public func withoutTrivia() -> IfConfigClauseListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `IfConfigClauseListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `IfConfigClauseListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `IfConfigClauseListSyntax` to the `BidirectionalCollection` protocol.
extension IfConfigClauseListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `InheritedTypeListSyntax` represents a collection of one or more
/// `InheritedTypeSyntax` nodes. InheritedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct InheritedTypeListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = InheritedTypeSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .inheritedTypeList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .inheritedTypeList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedTypeList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `InheritedTypeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `InheritedTypeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> InheritedTypeListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return InheritedTypeListSyntax(newData)
  }

  /// Creates a new `InheritedTypeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `InheritedTypeListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `InheritedTypeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> InheritedTypeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `InheritedTypeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `InheritedTypeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the first element removed.
  public func removingFirst() -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the last element removed.
  public func removingLast() -> InheritedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `InheritedTypeListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> InheritedTypeListSyntax {
    return InheritedTypeListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `InheritedTypeListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> InheritedTypeListSyntax {
    return InheritedTypeListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `InheritedTypeListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> InheritedTypeListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `InheritedTypeListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> InheritedTypeListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `InheritedTypeListSyntax` with all trivia removed.
  public func withoutTrivia() -> InheritedTypeListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `InheritedTypeListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `InheritedTypeListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `InheritedTypeListSyntax` to the `BidirectionalCollection` protocol.
extension InheritedTypeListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `MemberDeclListSyntax` represents a collection of one or more
/// `MemberDeclListItemSyntax` nodes. MemberDeclListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct MemberDeclListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = MemberDeclListItemSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .memberDeclList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberDeclList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `MemberDeclListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `MemberDeclListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> MemberDeclListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return MemberDeclListSyntax(newData)
  }

  /// Creates a new `MemberDeclListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `MemberDeclListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MemberDeclListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `MemberDeclListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> MemberDeclListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `MemberDeclListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `MemberDeclListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MemberDeclListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `MemberDeclListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `MemberDeclListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `MemberDeclListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `MemberDeclListSyntax` by removing the first element.
  ///
  /// - Returns: A new `MemberDeclListSyntax` with the first element removed.
  public func removingFirst() -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `MemberDeclListSyntax` by removing the last element.
  ///
  /// - Returns: A new `MemberDeclListSyntax` with the last element removed.
  public func removingLast() -> MemberDeclListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `MemberDeclListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> MemberDeclListSyntax {
    return MemberDeclListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `MemberDeclListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> MemberDeclListSyntax {
    return MemberDeclListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `MemberDeclListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> MemberDeclListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `MemberDeclListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> MemberDeclListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `MemberDeclListSyntax` with all trivia removed.
  public func withoutTrivia() -> MemberDeclListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `MemberDeclListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `MemberDeclListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `MemberDeclListSyntax` to the `BidirectionalCollection` protocol.
extension MemberDeclListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ModifierListSyntax` represents a collection of one or more
/// `DeclModifierSyntax` nodes. ModifierListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ModifierListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = DeclModifierSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .modifierList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .modifierList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ModifierListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ModifierListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ModifierListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ModifierListSyntax(newData)
  }

  /// Creates a new `ModifierListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ModifierListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ModifierListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ModifierListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ModifierListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ModifierListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ModifierListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ModifierListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ModifierListSyntax` with the first element removed.
  public func removingFirst() -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ModifierListSyntax` with the last element removed.
  public func removingLast() -> ModifierListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ModifierListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ModifierListSyntax {
    return ModifierListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ModifierListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ModifierListSyntax {
    return ModifierListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ModifierListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ModifierListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ModifierListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ModifierListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ModifierListSyntax` with all trivia removed.
  public func withoutTrivia() -> ModifierListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ModifierListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ModifierListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ModifierListSyntax` to the `BidirectionalCollection` protocol.
extension ModifierListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `AccessPathSyntax` represents a collection of one or more
/// `AccessPathComponentSyntax` nodes. AccessPathSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessPathSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = AccessPathComponentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessPath else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessPath)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPath,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `AccessPathSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AccessPathSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AccessPathSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return AccessPathSyntax(newData)
  }

  /// Creates a new `AccessPathSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AccessPathSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AccessPathSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> AccessPathSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AccessPathSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AccessPathSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AccessPathSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AccessPathSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the first element.
  ///
  /// - Returns: A new `AccessPathSyntax` with the first element removed.
  public func removingFirst() -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the last element.
  ///
  /// - Returns: A new `AccessPathSyntax` with the last element removed.
  public func removingLast() -> AccessPathSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `AccessPathSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> AccessPathSyntax {
    return AccessPathSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AccessPathSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> AccessPathSyntax {
    return AccessPathSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AccessPathSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> AccessPathSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `AccessPathSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> AccessPathSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `AccessPathSyntax` with all trivia removed.
  public func withoutTrivia() -> AccessPathSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `AccessPathSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `AccessPathSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `AccessPathSyntax` to the `BidirectionalCollection` protocol.
extension AccessPathSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `AccessorListSyntax` represents a collection of one or more
/// `AccessorDeclSyntax` nodes. AccessorListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessorListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = AccessorDeclSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .accessorList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `AccessorListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AccessorListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AccessorListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return AccessorListSyntax(newData)
  }

  /// Creates a new `AccessorListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AccessorListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AccessorListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> AccessorListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AccessorListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AccessorListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AccessorListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AccessorListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the first element.
  ///
  /// - Returns: A new `AccessorListSyntax` with the first element removed.
  public func removingFirst() -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the last element.
  ///
  /// - Returns: A new `AccessorListSyntax` with the last element removed.
  public func removingLast() -> AccessorListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `AccessorListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> AccessorListSyntax {
    return AccessorListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AccessorListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> AccessorListSyntax {
    return AccessorListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AccessorListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> AccessorListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `AccessorListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> AccessorListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `AccessorListSyntax` with all trivia removed.
  public func withoutTrivia() -> AccessorListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `AccessorListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `AccessorListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `AccessorListSyntax` to the `BidirectionalCollection` protocol.
extension AccessorListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `PatternBindingListSyntax` represents a collection of one or more
/// `PatternBindingSyntax` nodes. PatternBindingListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PatternBindingListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = PatternBindingSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .patternBindingList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .patternBindingList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBindingList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `PatternBindingListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PatternBindingListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PatternBindingListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return PatternBindingListSyntax(newData)
  }

  /// Creates a new `PatternBindingListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PatternBindingListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PatternBindingListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> PatternBindingListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PatternBindingListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PatternBindingListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the first element removed.
  public func removingFirst() -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the last element removed.
  public func removingLast() -> PatternBindingListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `PatternBindingListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> PatternBindingListSyntax {
    return PatternBindingListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PatternBindingListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> PatternBindingListSyntax {
    return PatternBindingListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PatternBindingListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> PatternBindingListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `PatternBindingListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> PatternBindingListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `PatternBindingListSyntax` with all trivia removed.
  public func withoutTrivia() -> PatternBindingListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `PatternBindingListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `PatternBindingListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `PatternBindingListSyntax` to the `BidirectionalCollection` protocol.
extension PatternBindingListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// A collection of 0 or more `EnumCaseElement`s.
public struct EnumCaseElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = EnumCaseElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .enumCaseElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCaseElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `EnumCaseElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `EnumCaseElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> EnumCaseElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return EnumCaseElementListSyntax(newData)
  }

  /// Creates a new `EnumCaseElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `EnumCaseElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `EnumCaseElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> EnumCaseElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `EnumCaseElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `EnumCaseElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the first element removed.
  public func removingFirst() -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the last element removed.
  public func removingLast() -> EnumCaseElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `EnumCaseElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> EnumCaseElementListSyntax {
    return EnumCaseElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `EnumCaseElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> EnumCaseElementListSyntax {
    return EnumCaseElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `EnumCaseElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> EnumCaseElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `EnumCaseElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> EnumCaseElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `EnumCaseElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> EnumCaseElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `EnumCaseElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `EnumCaseElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `EnumCaseElementListSyntax` to the `BidirectionalCollection` protocol.
extension EnumCaseElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `DesignatedTypeListSyntax` represents a collection of one or more
/// `DesignatedTypeElementSyntax` nodes. DesignatedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DesignatedTypeListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = DesignatedTypeElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .designatedTypeList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .designatedTypeList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `DesignatedTypeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DesignatedTypeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DesignatedTypeListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return DesignatedTypeListSyntax(newData)
  }

  /// Creates a new `DesignatedTypeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DesignatedTypeListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DesignatedTypeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DesignatedTypeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> DesignatedTypeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DesignatedTypeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DesignatedTypeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DesignatedTypeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DesignatedTypeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DesignatedTypeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DesignatedTypeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DesignatedTypeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DesignatedTypeListSyntax` with the first element removed.
  public func removingFirst() -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DesignatedTypeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DesignatedTypeListSyntax` with the last element removed.
  public func removingLast() -> DesignatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `DesignatedTypeListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> DesignatedTypeListSyntax {
    return DesignatedTypeListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DesignatedTypeListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> DesignatedTypeListSyntax {
    return DesignatedTypeListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DesignatedTypeListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> DesignatedTypeListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `DesignatedTypeListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> DesignatedTypeListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `DesignatedTypeListSyntax` with all trivia removed.
  public func withoutTrivia() -> DesignatedTypeListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `DesignatedTypeListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `DesignatedTypeListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `DesignatedTypeListSyntax` to the `BidirectionalCollection` protocol.
extension DesignatedTypeListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `PrecedenceGroupAttributeListSyntax` represents a collection of one or more
/// `Syntax` nodes. PrecedenceGroupAttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupAttributeListSyntax: SyntaxCollection, SyntaxHashable {
  @frozen // FIXME: Not actually stable, works around a miscompile
  public enum Element: SyntaxChildChoices {
    case `precedenceGroupRelation`(PrecedenceGroupRelationSyntax)
    case `precedenceGroupAssignment`(PrecedenceGroupAssignmentSyntax)
    case `precedenceGroupAssociativity`(PrecedenceGroupAssociativitySyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .precedenceGroupRelation(let node): return node._syntaxNode
      case .precedenceGroupAssignment(let node): return node._syntaxNode
      case .precedenceGroupAssociativity(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: PrecedenceGroupRelationSyntax) {
      self = .precedenceGroupRelation(node)
    }
    public init(_ node: PrecedenceGroupAssignmentSyntax) {
      self = .precedenceGroupAssignment(node)
    }
    public init(_ node: PrecedenceGroupAssociativitySyntax) {
      self = .precedenceGroupAssociativity(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(PrecedenceGroupRelationSyntax.self) {
        self = .precedenceGroupRelation(node)
        return
      }
      if let node = node.as(PrecedenceGroupAssignmentSyntax.self) {
        self = .precedenceGroupAssignment(node)
        return
      }
      if let node = node.as(PrecedenceGroupAssociativitySyntax.self) {
        self = .precedenceGroupAssociativity(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(PrecedenceGroupRelationSyntax.self),
        .node(PrecedenceGroupAssignmentSyntax.self),
        .node(PrecedenceGroupAssociativitySyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupAttributeList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupAttributeList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAttributeList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PrecedenceGroupAttributeListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return PrecedenceGroupAttributeListSyntax(newData)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> PrecedenceGroupAttributeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the first element removed.
  public func removingFirst() -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the last element removed.
  public func removingLast() -> PrecedenceGroupAttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `PrecedenceGroupAttributeListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> PrecedenceGroupAttributeListSyntax {
    return PrecedenceGroupAttributeListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrecedenceGroupAttributeListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> PrecedenceGroupAttributeListSyntax {
    return PrecedenceGroupAttributeListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrecedenceGroupAttributeListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> PrecedenceGroupAttributeListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `PrecedenceGroupAttributeListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> PrecedenceGroupAttributeListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `PrecedenceGroupAttributeListSyntax` with all trivia removed.
  public func withoutTrivia() -> PrecedenceGroupAttributeListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `PrecedenceGroupAttributeListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `PrecedenceGroupAttributeListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `PrecedenceGroupAttributeListSyntax` to the `BidirectionalCollection` protocol.
extension PrecedenceGroupAttributeListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `PrecedenceGroupNameListSyntax` represents a collection of one or more
/// `PrecedenceGroupNameElementSyntax` nodes. PrecedenceGroupNameListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupNameListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = PrecedenceGroupNameElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .precedenceGroupNameList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupNameList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `PrecedenceGroupNameListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PrecedenceGroupNameListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return PrecedenceGroupNameListSyntax(newData)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> PrecedenceGroupNameListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the first element removed.
  public func removingFirst() -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the last element removed.
  public func removingLast() -> PrecedenceGroupNameListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `PrecedenceGroupNameListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> PrecedenceGroupNameListSyntax {
    return PrecedenceGroupNameListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrecedenceGroupNameListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> PrecedenceGroupNameListSyntax {
    return PrecedenceGroupNameListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrecedenceGroupNameListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> PrecedenceGroupNameListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `PrecedenceGroupNameListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> PrecedenceGroupNameListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `PrecedenceGroupNameListSyntax` with all trivia removed.
  public func withoutTrivia() -> PrecedenceGroupNameListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `PrecedenceGroupNameListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `PrecedenceGroupNameListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `PrecedenceGroupNameListSyntax` to the `BidirectionalCollection` protocol.
extension PrecedenceGroupNameListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `TokenListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. TokenListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TokenListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = TokenSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tokenList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tokenList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tokenList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `TokenListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TokenListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TokenListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return TokenListSyntax(newData)
  }

  /// Creates a new `TokenListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TokenListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TokenListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> TokenListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TokenListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TokenListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TokenListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TokenListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TokenListSyntax` with the first element removed.
  public func removingFirst() -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TokenListSyntax` with the last element removed.
  public func removingLast() -> TokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `TokenListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TokenListSyntax {
    return TokenListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TokenListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TokenListSyntax {
    return TokenListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TokenListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> TokenListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `TokenListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TokenListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `TokenListSyntax` with all trivia removed.
  public func withoutTrivia() -> TokenListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `TokenListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `TokenListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `TokenListSyntax` to the `BidirectionalCollection` protocol.
extension TokenListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `NonEmptyTokenListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. NonEmptyTokenListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct NonEmptyTokenListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = TokenSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .nonEmptyTokenList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .nonEmptyTokenList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.nonEmptyTokenList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `NonEmptyTokenListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `NonEmptyTokenListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> NonEmptyTokenListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return NonEmptyTokenListSyntax(newData)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `NonEmptyTokenListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `NonEmptyTokenListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> NonEmptyTokenListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `NonEmptyTokenListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `NonEmptyTokenListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `NonEmptyTokenListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by removing the first element.
  ///
  /// - Returns: A new `NonEmptyTokenListSyntax` with the first element removed.
  public func removingFirst() -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `NonEmptyTokenListSyntax` by removing the last element.
  ///
  /// - Returns: A new `NonEmptyTokenListSyntax` with the last element removed.
  public func removingLast() -> NonEmptyTokenListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `NonEmptyTokenListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> NonEmptyTokenListSyntax {
    return NonEmptyTokenListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `NonEmptyTokenListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> NonEmptyTokenListSyntax {
    return NonEmptyTokenListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `NonEmptyTokenListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> NonEmptyTokenListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `NonEmptyTokenListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> NonEmptyTokenListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `NonEmptyTokenListSyntax` with all trivia removed.
  public func withoutTrivia() -> NonEmptyTokenListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `NonEmptyTokenListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `NonEmptyTokenListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `NonEmptyTokenListSyntax` to the `BidirectionalCollection` protocol.
extension NonEmptyTokenListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `AttributeListSyntax` represents a collection of one or more
/// `Syntax` nodes. AttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AttributeListSyntax: SyntaxCollection, SyntaxHashable {
  @frozen // FIXME: Not actually stable, works around a miscompile
  public enum Element: SyntaxChildChoices {
    case `attribute`(AttributeSyntax)
    case `customAttribute`(CustomAttributeSyntax)
    case `ifConfigDecl`(IfConfigDeclSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .attribute(let node): return node._syntaxNode
      case .customAttribute(let node): return node._syntaxNode
      case .ifConfigDecl(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: AttributeSyntax) {
      self = .attribute(node)
    }
    public init(_ node: CustomAttributeSyntax) {
      self = .customAttribute(node)
    }
    public init(_ node: IfConfigDeclSyntax) {
      self = .ifConfigDecl(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(AttributeSyntax.self) {
        self = .attribute(node)
        return
      }
      if let node = node.as(CustomAttributeSyntax.self) {
        self = .customAttribute(node)
        return
      }
      if let node = node.as(IfConfigDeclSyntax.self) {
        self = .ifConfigDecl(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(AttributeSyntax.self),
        .node(CustomAttributeSyntax.self),
        .node(IfConfigDeclSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .attributeList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .attributeList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `AttributeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AttributeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AttributeListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return AttributeListSyntax(newData)
  }

  /// Creates a new `AttributeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AttributeListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AttributeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> AttributeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AttributeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AttributeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AttributeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AttributeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `AttributeListSyntax` with the first element removed.
  public func removingFirst() -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `AttributeListSyntax` with the last element removed.
  public func removingLast() -> AttributeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `AttributeListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> AttributeListSyntax {
    return AttributeListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AttributeListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> AttributeListSyntax {
    return AttributeListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AttributeListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> AttributeListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `AttributeListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> AttributeListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `AttributeListSyntax` with all trivia removed.
  public func withoutTrivia() -> AttributeListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `AttributeListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `AttributeListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `AttributeListSyntax` to the `BidirectionalCollection` protocol.
extension AttributeListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// 
/// A collection of arguments for the `@_specialize` attribute
/// 
public struct SpecializeAttributeSpecListSyntax: SyntaxCollection, SyntaxHashable {
  @frozen // FIXME: Not actually stable, works around a miscompile
  public enum Element: SyntaxChildChoices {
    case `labeledSpecializeEntry`(LabeledSpecializeEntrySyntax)
    case `availabilityEntry`(AvailabilityEntrySyntax)
    case `targetFunctionEntry`(TargetFunctionEntrySyntax)
    case `genericWhereClause`(GenericWhereClauseSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .labeledSpecializeEntry(let node): return node._syntaxNode
      case .availabilityEntry(let node): return node._syntaxNode
      case .targetFunctionEntry(let node): return node._syntaxNode
      case .genericWhereClause(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: LabeledSpecializeEntrySyntax) {
      self = .labeledSpecializeEntry(node)
    }
    public init(_ node: AvailabilityEntrySyntax) {
      self = .availabilityEntry(node)
    }
    public init(_ node: TargetFunctionEntrySyntax) {
      self = .targetFunctionEntry(node)
    }
    public init(_ node: GenericWhereClauseSyntax) {
      self = .genericWhereClause(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(LabeledSpecializeEntrySyntax.self) {
        self = .labeledSpecializeEntry(node)
        return
      }
      if let node = node.as(AvailabilityEntrySyntax.self) {
        self = .availabilityEntry(node)
        return
      }
      if let node = node.as(TargetFunctionEntrySyntax.self) {
        self = .targetFunctionEntry(node)
        return
      }
      if let node = node.as(GenericWhereClauseSyntax.self) {
        self = .genericWhereClause(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(LabeledSpecializeEntrySyntax.self),
        .node(AvailabilityEntrySyntax.self),
        .node(TargetFunctionEntrySyntax.self),
        .node(GenericWhereClauseSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .specializeAttributeSpecList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .specializeAttributeSpecList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeAttributeSpecList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> SpecializeAttributeSpecListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return SpecializeAttributeSpecListSyntax(newData)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> SpecializeAttributeSpecListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by removing the first element.
  ///
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with the first element removed.
  public func removingFirst() -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `SpecializeAttributeSpecListSyntax` by removing the last element.
  ///
  /// - Returns: A new `SpecializeAttributeSpecListSyntax` with the last element removed.
  public func removingLast() -> SpecializeAttributeSpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `SpecializeAttributeSpecListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> SpecializeAttributeSpecListSyntax {
    return SpecializeAttributeSpecListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `SpecializeAttributeSpecListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> SpecializeAttributeSpecListSyntax {
    return SpecializeAttributeSpecListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `SpecializeAttributeSpecListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> SpecializeAttributeSpecListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `SpecializeAttributeSpecListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> SpecializeAttributeSpecListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `SpecializeAttributeSpecListSyntax` with all trivia removed.
  public func withoutTrivia() -> SpecializeAttributeSpecListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `SpecializeAttributeSpecListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `SpecializeAttributeSpecListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `SpecializeAttributeSpecListSyntax` to the `BidirectionalCollection` protocol.
extension SpecializeAttributeSpecListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ObjCSelectorSyntax` represents a collection of one or more
/// `ObjCSelectorPieceSyntax` nodes. ObjCSelectorSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ObjCSelectorSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ObjCSelectorPieceSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .objCSelector else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objCSelector)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelector,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ObjCSelectorSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ObjCSelectorSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ObjCSelectorSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ObjCSelectorSyntax(newData)
  }

  /// Creates a new `ObjCSelectorSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ObjCSelectorSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjCSelectorSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ObjCSelectorSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ObjCSelectorSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ObjCSelectorSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ObjCSelectorSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjCSelectorSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ObjCSelectorSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjCSelectorSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ObjCSelectorSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjCSelectorSyntax` by removing the first element.
  ///
  /// - Returns: A new `ObjCSelectorSyntax` with the first element removed.
  public func removingFirst() -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjCSelectorSyntax` by removing the last element.
  ///
  /// - Returns: A new `ObjCSelectorSyntax` with the last element removed.
  public func removingLast() -> ObjCSelectorSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ObjCSelectorSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ObjCSelectorSyntax {
    return ObjCSelectorSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ObjCSelectorSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ObjCSelectorSyntax {
    return ObjCSelectorSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ObjCSelectorSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ObjCSelectorSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ObjCSelectorSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ObjCSelectorSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ObjCSelectorSyntax` with all trivia removed.
  public func withoutTrivia() -> ObjCSelectorSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ObjCSelectorSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ObjCSelectorSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ObjCSelectorSyntax` to the `BidirectionalCollection` protocol.
extension ObjCSelectorSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `DifferentiabilityParamListSyntax` represents a collection of one or more
/// `DifferentiabilityParamSyntax` nodes. DifferentiabilityParamListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DifferentiabilityParamListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = DifferentiabilityParamSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .differentiabilityParamList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParamList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `DifferentiabilityParamListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DifferentiabilityParamListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DifferentiabilityParamListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return DifferentiabilityParamListSyntax(newData)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DifferentiabilityParamListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DifferentiabilityParamListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> DifferentiabilityParamListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DifferentiabilityParamListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DifferentiabilityParamListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DifferentiabilityParamListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DifferentiabilityParamListSyntax` with the first element removed.
  public func removingFirst() -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DifferentiabilityParamListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DifferentiabilityParamListSyntax` with the last element removed.
  public func removingLast() -> DifferentiabilityParamListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `DifferentiabilityParamListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> DifferentiabilityParamListSyntax {
    return DifferentiabilityParamListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DifferentiabilityParamListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> DifferentiabilityParamListSyntax {
    return DifferentiabilityParamListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `DifferentiabilityParamListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> DifferentiabilityParamListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `DifferentiabilityParamListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> DifferentiabilityParamListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `DifferentiabilityParamListSyntax` with all trivia removed.
  public func withoutTrivia() -> DifferentiabilityParamListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `DifferentiabilityParamListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `DifferentiabilityParamListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `DifferentiabilityParamListSyntax` to the `BidirectionalCollection` protocol.
extension DifferentiabilityParamListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `BackDeployVersionListSyntax` represents a collection of one or more
/// `BackDeployVersionArgumentSyntax` nodes. BackDeployVersionListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct BackDeployVersionListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = BackDeployVersionArgumentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .backDeployVersionList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .backDeployVersionList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `BackDeployVersionListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `BackDeployVersionListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> BackDeployVersionListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return BackDeployVersionListSyntax(newData)
  }

  /// Creates a new `BackDeployVersionListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `BackDeployVersionListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `BackDeployVersionListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `BackDeployVersionListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> BackDeployVersionListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `BackDeployVersionListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `BackDeployVersionListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `BackDeployVersionListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `BackDeployVersionListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `BackDeployVersionListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `BackDeployVersionListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `BackDeployVersionListSyntax` by removing the first element.
  ///
  /// - Returns: A new `BackDeployVersionListSyntax` with the first element removed.
  public func removingFirst() -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `BackDeployVersionListSyntax` by removing the last element.
  ///
  /// - Returns: A new `BackDeployVersionListSyntax` with the last element removed.
  public func removingLast() -> BackDeployVersionListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `BackDeployVersionListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> BackDeployVersionListSyntax {
    return BackDeployVersionListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `BackDeployVersionListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> BackDeployVersionListSyntax {
    return BackDeployVersionListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `BackDeployVersionListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> BackDeployVersionListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `BackDeployVersionListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> BackDeployVersionListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `BackDeployVersionListSyntax` with all trivia removed.
  public func withoutTrivia() -> BackDeployVersionListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `BackDeployVersionListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `BackDeployVersionListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `BackDeployVersionListSyntax` to the `BidirectionalCollection` protocol.
extension BackDeployVersionListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `SwitchCaseListSyntax` represents a collection of one or more
/// `Syntax` nodes. SwitchCaseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct SwitchCaseListSyntax: SyntaxCollection, SyntaxHashable {
  @frozen // FIXME: Not actually stable, works around a miscompile
  public enum Element: SyntaxChildChoices {
    case `switchCase`(SwitchCaseSyntax)
    case `ifConfigDecl`(IfConfigDeclSyntax)
    public var _syntaxNode: Syntax {
      switch self {
      case .switchCase(let node): return node._syntaxNode
      case .ifConfigDecl(let node): return node._syntaxNode
      }
    }
    init(_ data: SyntaxData) { self.init(Syntax(data))! }
    public init(_ node: SwitchCaseSyntax) {
      self = .switchCase(node)
    }
    public init(_ node: IfConfigDeclSyntax) {
      self = .ifConfigDecl(node)
    }
    public init?<S: SyntaxProtocol>(_ node: S) {
      if let node = node.as(SwitchCaseSyntax.self) {
        self = .switchCase(node)
        return
      }
      if let node = node.as(IfConfigDeclSyntax.self) {
        self = .ifConfigDecl(node)
        return
      }
      return nil
    }

    public static var structure: SyntaxNodeStructure {
      return .choices([
        .node(SwitchCaseSyntax.self),
        .node(IfConfigDeclSyntax.self),
      ])
    }
  }

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .switchCaseList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchCaseList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `SwitchCaseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `SwitchCaseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> SwitchCaseListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return SwitchCaseListSyntax(newData)
  }

  /// Creates a new `SwitchCaseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `SwitchCaseListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `SwitchCaseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> SwitchCaseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `SwitchCaseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `SwitchCaseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the first element removed.
  public func removingFirst() -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the last element removed.
  public func removingLast() -> SwitchCaseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `SwitchCaseListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> SwitchCaseListSyntax {
    return SwitchCaseListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `SwitchCaseListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> SwitchCaseListSyntax {
    return SwitchCaseListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `SwitchCaseListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> SwitchCaseListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `SwitchCaseListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> SwitchCaseListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `SwitchCaseListSyntax` with all trivia removed.
  public func withoutTrivia() -> SwitchCaseListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `SwitchCaseListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `SwitchCaseListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `SwitchCaseListSyntax` to the `BidirectionalCollection` protocol.
extension SwitchCaseListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `CatchClauseListSyntax` represents a collection of one or more
/// `CatchClauseSyntax` nodes. CatchClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CatchClauseListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = CatchClauseSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .catchClauseList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchClauseList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClauseList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `CatchClauseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CatchClauseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CatchClauseListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return CatchClauseListSyntax(newData)
  }

  /// Creates a new `CatchClauseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CatchClauseListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CatchClauseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> CatchClauseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CatchClauseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CatchClauseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the first element removed.
  public func removingFirst() -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the last element removed.
  public func removingLast() -> CatchClauseListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `CatchClauseListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> CatchClauseListSyntax {
    return CatchClauseListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CatchClauseListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> CatchClauseListSyntax {
    return CatchClauseListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CatchClauseListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> CatchClauseListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `CatchClauseListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> CatchClauseListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `CatchClauseListSyntax` with all trivia removed.
  public func withoutTrivia() -> CatchClauseListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `CatchClauseListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `CatchClauseListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `CatchClauseListSyntax` to the `BidirectionalCollection` protocol.
extension CatchClauseListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `CaseItemListSyntax` represents a collection of one or more
/// `CaseItemSyntax` nodes. CaseItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CaseItemListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = CaseItemSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .caseItemList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .caseItemList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItemList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `CaseItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CaseItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CaseItemListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return CaseItemListSyntax(newData)
  }

  /// Creates a new `CaseItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CaseItemListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CaseItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> CaseItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CaseItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CaseItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CaseItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the first element removed.
  public func removingFirst() -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the last element removed.
  public func removingLast() -> CaseItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `CaseItemListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> CaseItemListSyntax {
    return CaseItemListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CaseItemListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> CaseItemListSyntax {
    return CaseItemListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CaseItemListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> CaseItemListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `CaseItemListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> CaseItemListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `CaseItemListSyntax` with all trivia removed.
  public func withoutTrivia() -> CaseItemListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `CaseItemListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `CaseItemListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `CaseItemListSyntax` to the `BidirectionalCollection` protocol.
extension CaseItemListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `CatchItemListSyntax` represents a collection of one or more
/// `CatchItemSyntax` nodes. CatchItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CatchItemListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = CatchItemSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .catchItemList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchItemList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItemList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `CatchItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CatchItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CatchItemListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return CatchItemListSyntax(newData)
  }

  /// Creates a new `CatchItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CatchItemListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CatchItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> CatchItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CatchItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CatchItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CatchItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CatchItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CatchItemListSyntax` with the first element removed.
  public func removingFirst() -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CatchItemListSyntax` with the last element removed.
  public func removingLast() -> CatchItemListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `CatchItemListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> CatchItemListSyntax {
    return CatchItemListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CatchItemListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> CatchItemListSyntax {
    return CatchItemListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CatchItemListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> CatchItemListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `CatchItemListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> CatchItemListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `CatchItemListSyntax` with all trivia removed.
  public func withoutTrivia() -> CatchItemListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `CatchItemListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `CatchItemListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `CatchItemListSyntax` to the `BidirectionalCollection` protocol.
extension CatchItemListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `ConditionElementListSyntax` represents a collection of one or more
/// `ConditionElementSyntax` nodes. ConditionElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ConditionElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = ConditionElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .conditionElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conditionElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `ConditionElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ConditionElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ConditionElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return ConditionElementListSyntax(newData)
  }

  /// Creates a new `ConditionElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ConditionElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ConditionElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> ConditionElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ConditionElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ConditionElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the first element removed.
  public func removingFirst() -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the last element removed.
  public func removingLast() -> ConditionElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `ConditionElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> ConditionElementListSyntax {
    return ConditionElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ConditionElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> ConditionElementListSyntax {
    return ConditionElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `ConditionElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> ConditionElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `ConditionElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> ConditionElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `ConditionElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> ConditionElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `ConditionElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `ConditionElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `ConditionElementListSyntax` to the `BidirectionalCollection` protocol.
extension ConditionElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `GenericRequirementListSyntax` represents a collection of one or more
/// `GenericRequirementSyntax` nodes. GenericRequirementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericRequirementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = GenericRequirementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericRequirementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericRequirementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `GenericRequirementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericRequirementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericRequirementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return GenericRequirementListSyntax(newData)
  }

  /// Creates a new `GenericRequirementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericRequirementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericRequirementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> GenericRequirementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericRequirementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericRequirementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the first element removed.
  public func removingFirst() -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the last element removed.
  public func removingLast() -> GenericRequirementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `GenericRequirementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> GenericRequirementListSyntax {
    return GenericRequirementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericRequirementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> GenericRequirementListSyntax {
    return GenericRequirementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericRequirementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> GenericRequirementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `GenericRequirementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> GenericRequirementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `GenericRequirementListSyntax` with all trivia removed.
  public func withoutTrivia() -> GenericRequirementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `GenericRequirementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `GenericRequirementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `GenericRequirementListSyntax` to the `BidirectionalCollection` protocol.
extension GenericRequirementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `GenericParameterListSyntax` represents a collection of one or more
/// `GenericParameterSyntax` nodes. GenericParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericParameterListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = GenericParameterSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericParameterList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericParameterList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `GenericParameterListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericParameterListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericParameterListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return GenericParameterListSyntax(newData)
  }

  /// Creates a new `GenericParameterListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericParameterListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericParameterListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> GenericParameterListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericParameterListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericParameterListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the first element removed.
  public func removingFirst() -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the last element removed.
  public func removingLast() -> GenericParameterListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `GenericParameterListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> GenericParameterListSyntax {
    return GenericParameterListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericParameterListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> GenericParameterListSyntax {
    return GenericParameterListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericParameterListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> GenericParameterListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `GenericParameterListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> GenericParameterListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `GenericParameterListSyntax` with all trivia removed.
  public func withoutTrivia() -> GenericParameterListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `GenericParameterListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `GenericParameterListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `GenericParameterListSyntax` to the `BidirectionalCollection` protocol.
extension GenericParameterListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `PrimaryAssociatedTypeListSyntax` represents a collection of one or more
/// `PrimaryAssociatedTypeSyntax` nodes. PrimaryAssociatedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrimaryAssociatedTypeListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = PrimaryAssociatedTypeSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .primaryAssociatedTypeList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .primaryAssociatedTypeList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PrimaryAssociatedTypeListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return PrimaryAssociatedTypeListSyntax(newData)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> PrimaryAssociatedTypeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with the first element removed.
  public func removingFirst() -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrimaryAssociatedTypeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PrimaryAssociatedTypeListSyntax` with the last element removed.
  public func removingLast() -> PrimaryAssociatedTypeListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `PrimaryAssociatedTypeListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> PrimaryAssociatedTypeListSyntax {
    return PrimaryAssociatedTypeListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrimaryAssociatedTypeListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> PrimaryAssociatedTypeListSyntax {
    return PrimaryAssociatedTypeListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `PrimaryAssociatedTypeListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> PrimaryAssociatedTypeListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `PrimaryAssociatedTypeListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> PrimaryAssociatedTypeListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `PrimaryAssociatedTypeListSyntax` with all trivia removed.
  public func withoutTrivia() -> PrimaryAssociatedTypeListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `PrimaryAssociatedTypeListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `PrimaryAssociatedTypeListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `PrimaryAssociatedTypeListSyntax` to the `BidirectionalCollection` protocol.
extension PrimaryAssociatedTypeListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `CompositionTypeElementListSyntax` represents a collection of one or more
/// `CompositionTypeElementSyntax` nodes. CompositionTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CompositionTypeElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = CompositionTypeElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .compositionTypeElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .compositionTypeElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `CompositionTypeElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CompositionTypeElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CompositionTypeElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return CompositionTypeElementListSyntax(newData)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> CompositionTypeElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CompositionTypeElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the first element removed.
  public func removingFirst() -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the last element removed.
  public func removingLast() -> CompositionTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `CompositionTypeElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> CompositionTypeElementListSyntax {
    return CompositionTypeElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CompositionTypeElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> CompositionTypeElementListSyntax {
    return CompositionTypeElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `CompositionTypeElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> CompositionTypeElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `CompositionTypeElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> CompositionTypeElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `CompositionTypeElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> CompositionTypeElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `CompositionTypeElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `CompositionTypeElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `CompositionTypeElementListSyntax` to the `BidirectionalCollection` protocol.
extension CompositionTypeElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `TupleTypeElementListSyntax` represents a collection of one or more
/// `TupleTypeElementSyntax` nodes. TupleTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleTypeElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = TupleTypeElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tupleTypeElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleTypeElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `TupleTypeElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TupleTypeElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TupleTypeElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return TupleTypeElementListSyntax(newData)
  }

  /// Creates a new `TupleTypeElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TupleTypeElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TupleTypeElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> TupleTypeElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TupleTypeElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TupleTypeElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the first element removed.
  public func removingFirst() -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the last element removed.
  public func removingLast() -> TupleTypeElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `TupleTypeElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TupleTypeElementListSyntax {
    return TupleTypeElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TupleTypeElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TupleTypeElementListSyntax {
    return TupleTypeElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TupleTypeElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> TupleTypeElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `TupleTypeElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TupleTypeElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `TupleTypeElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> TupleTypeElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `TupleTypeElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `TupleTypeElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `TupleTypeElementListSyntax` to the `BidirectionalCollection` protocol.
extension TupleTypeElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `GenericArgumentListSyntax` represents a collection of one or more
/// `GenericArgumentSyntax` nodes. GenericArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericArgumentListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = GenericArgumentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .genericArgumentList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericArgumentList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `GenericArgumentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericArgumentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericArgumentListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return GenericArgumentListSyntax(newData)
  }

  /// Creates a new `GenericArgumentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericArgumentListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericArgumentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> GenericArgumentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericArgumentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericArgumentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the first element removed.
  public func removingFirst() -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the last element removed.
  public func removingLast() -> GenericArgumentListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `GenericArgumentListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> GenericArgumentListSyntax {
    return GenericArgumentListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericArgumentListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> GenericArgumentListSyntax {
    return GenericArgumentListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `GenericArgumentListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> GenericArgumentListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `GenericArgumentListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> GenericArgumentListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `GenericArgumentListSyntax` with all trivia removed.
  public func withoutTrivia() -> GenericArgumentListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `GenericArgumentListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `GenericArgumentListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `GenericArgumentListSyntax` to the `BidirectionalCollection` protocol.
extension GenericArgumentListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `TuplePatternElementListSyntax` represents a collection of one or more
/// `TuplePatternElementSyntax` nodes. TuplePatternElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TuplePatternElementListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = TuplePatternElementSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .tuplePatternElementList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePatternElementList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElementList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `TuplePatternElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TuplePatternElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TuplePatternElementListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return TuplePatternElementListSyntax(newData)
  }

  /// Creates a new `TuplePatternElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TuplePatternElementListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TuplePatternElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> TuplePatternElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TuplePatternElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TuplePatternElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the first element removed.
  public func removingFirst() -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the last element removed.
  public func removingLast() -> TuplePatternElementListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `TuplePatternElementListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TuplePatternElementListSyntax {
    return TuplePatternElementListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TuplePatternElementListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TuplePatternElementListSyntax {
    return TuplePatternElementListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `TuplePatternElementListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> TuplePatternElementListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `TuplePatternElementListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TuplePatternElementListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `TuplePatternElementListSyntax` with all trivia removed.
  public func withoutTrivia() -> TuplePatternElementListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `TuplePatternElementListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `TuplePatternElementListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `TuplePatternElementListSyntax` to the `BidirectionalCollection` protocol.
extension TuplePatternElementListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

/// `AvailabilitySpecListSyntax` represents a collection of one or more
/// `AvailabilityArgumentSyntax` nodes. AvailabilitySpecListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AvailabilitySpecListSyntax: SyntaxCollection, SyntaxHashable {
  public typealias Element = AvailabilityArgumentSyntax

  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .availabilitySpecList else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the provided root and data. This assumes 
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilitySpecList)
    self._syntaxNode = Syntax(data)
  }

  public init(_ children: [Element]) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: children.map { $0.raw }, arena: arena)
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int { return raw.layoutView!.children.count }

  /// Creates a new `AvailabilitySpecListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AvailabilitySpecListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AvailabilitySpecListSyntax {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return AvailabilitySpecListSyntax(newData)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AvailabilitySpecListSyntax` with that element appended to the end.
  public func appending(_ syntax: Element) -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AvailabilitySpecListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(_ syntax: Element) -> AvailabilitySpecListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AvailabilitySpecListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Element, at index: Int) -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AvailabilitySpecListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int, with syntax: Element) -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AvailabilitySpecListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by removing the first element.
  ///
  /// - Returns: A new `AvailabilitySpecListSyntax` with the first element removed.
  public func removingFirst() -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AvailabilitySpecListSyntax` by removing the last element.
  ///
  /// - Returns: A new `AvailabilitySpecListSyntax` with the last element removed.
  public func removingLast() -> AvailabilitySpecListSyntax {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns a new `AvailabilitySpecListSyntax` with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> AvailabilitySpecListSyntax {
    return AvailabilitySpecListSyntax(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AvailabilitySpecListSyntax` with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> AvailabilitySpecListSyntax {
    return AvailabilitySpecListSyntax(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
  }

  /// Returns a new `AvailabilitySpecListSyntax` with its leading trivia removed.
  public func withoutLeadingTrivia() -> AvailabilitySpecListSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new `AvailabilitySpecListSyntax` with its trailing trivia removed.
  public func withoutTrailingTrivia() -> AvailabilitySpecListSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new `AvailabilitySpecListSyntax` with all trivia removed.
  public func withoutTrivia() -> AvailabilitySpecListSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this `AvailabilitySpecListSyntax`.
  public var leadingTrivia: Trivia? {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = withLeadingTrivia(newValue ?? [])
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this `AvailabilitySpecListSyntax`.
  public var trailingTrivia: Trivia? {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = withTrailingTrivia(newValue ?? [])
    }
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }
}

/// Conformance for `AvailabilitySpecListSyntax` to the `BidirectionalCollection` protocol.
extension AvailabilitySpecListSyntax: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex

  public struct Iterator: IteratorProtocol {
    private let parent: Syntax
    private var iterator: RawSyntaxChildren.Iterator

    init(parent: Syntax, rawChildren: RawSyntaxChildren) {
      self.parent = parent
      self.iterator = rawChildren.makeIterator()
    }

    public mutating func next() -> Element? {
      guard let (raw, info) = self.iterator.next() else {
        return nil
      }
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: parent)
      return Element(data)
    }
  }

  public func makeIterator() -> Iterator {
    return Iterator(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can 
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(self.data.absoluteRaw)
  }

  public var startIndex: SyntaxChildrenIndex {
    return rawChildren.startIndex
  }
  public var endIndex: SyntaxChildrenIndex {
    return rawChildren.endIndex
  }

  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
      -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    let (raw, info) = rawChildren[position]
    let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
    let data = SyntaxData(absoluteRaw, parent: Syntax(self))
    return Element(data)
  }
}

extension CodeBlockItemListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension UnexpectedNodesSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension TupleExprElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ArrayElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension DictionaryElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension StringLiteralSegmentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension DeclNameArgumentListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ExprListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ClosureCaptureItemListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ClosureParamListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension MultipleTrailingClosureElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension KeyPathComponentListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension YieldExprListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension FunctionParameterListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension IfConfigClauseListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension InheritedTypeListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension MemberDeclListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ModifierListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension AccessPathSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension AccessorListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension PatternBindingListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension EnumCaseElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension DesignatedTypeListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension PrecedenceGroupAttributeListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension PrecedenceGroupNameListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension TokenListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension NonEmptyTokenListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension AttributeListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension SpecializeAttributeSpecListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ObjCSelectorSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension DifferentiabilityParamListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension BackDeployVersionListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension SwitchCaseListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension CatchClauseListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension CaseItemListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension CatchItemListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension ConditionElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension GenericRequirementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension GenericParameterListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension PrimaryAssociatedTypeListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension CompositionTypeElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension TupleTypeElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension GenericArgumentListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension TuplePatternElementListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
extension AvailabilitySpecListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map{ $0 })
  }
}
