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

public protocol SyntaxCollection: SyntaxProtocol, BidirectionalCollection, ExpressibleByArrayLiteral
where Element: SyntaxProtocol, Index == SyntaxChildrenIndex {
  associatedtype Iterator = SyntaxCollectionIterator<Element>

  /// The ``SyntaxKind`` of the syntax node that conforms to ``SyntaxCollection``.
  static var syntaxKind: SyntaxKind { get }
}

extension SyntaxCollection {
  public static var structure: SyntaxNodeStructure {
    return .collection(Element.self)
  }

  private var layoutView: RawSyntaxLayoutView {
    raw.layoutView!
  }

  /// Initialize the collection from a collection of the same type.
  ///
  /// - Note: This initializer is needed to improve source compatibility after
  ///   the `+` operators have been added. Previously, they created an array
  ///   that was converted to a ``SyntaxCollection`` and now they create a
  ///   ``SyntaxCollection``, which makes the initializer a no-op.
  @available(*, deprecated, message: "Call to initializer is not necessary.")
  public init(_ collection: Self) {
    self = collection
  }

  public init<Children: Sequence>(_ children: Children) where Children.Element == Element {
    let arena = SyntaxArena()
    // Extend the lifetime of children so their arenas don't get destroyed
    // before they can be added as children of the new arena.
    let raw = withExtendedLifetime(children) {
      RawSyntax.makeLayout(
        kind: Self.syntaxKind,
        from: children.map { $0.raw },
        arena: arena
      )
    }
    self = Syntax.forRoot(raw, rawNodeArena: RetainedSyntaxArena(arena)).cast(Self.self)
  }

  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  /// The number of elements, `present` or `missing`, in this collection.
  public var count: Int {
    return layoutView.children.count
  }

  /// Creates a new collection by replacing the underlying layout with a
  /// different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new collection with the new layout underlying it.
  internal func replacingLayout(_ layout: [RawSyntax?]) -> Self {
    let arena = SyntaxArena()
    let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
    return Syntax(self).replacingSelf(newRaw, rawNodeArena: RetainedSyntaxArena(arena), allocationArena: arena).cast(Self.self)
  }

  /// Return the index of `node` within this collection.
  ///
  /// If `node` is not part of this collection, returns `nil`.
  public func index(of node: some SyntaxProtocol) -> SyntaxChildrenIndex? {
    guard let node = node as? Element else {
      return nil
    }
    return index(of: node)
  }

  /// Return the index of `node` within this collection.
  ///
  /// If `node` is not part of this collection, returns `nil`.
  ///
  /// - Note: This method is functionally equivalent to the one that takes
  ///   ``SyntaxProtocol``. It is provided because otherwise `Collection.index(of:)`
  ///   is chosen, which is marked as deprecated and renamed to `firstIndex(of:)`.
  public func index(of node: Element) -> SyntaxChildrenIndex? {
    guard node.parent == Syntax(self) else {
      return nil
    }
    return node.indexInParent
  }

  /// Returns the index of the n-th element in this collection.
  ///
  /// The behavior is undefined if `offset` is greater than the number of
  /// elements in this collection.
  ///
  /// - Complexity: O(`offset`) because all previous element need to be iterated
  ///   to find the byte offset of the `offset`-th node within the source file.
  ///
  /// - Note: Because getting the `n`-th element in a ``SyntaxCollection`` is
  ///   not O(1), ``SyntaxCollection`` doesn’t provide a subscript to retrieve
  ///   the `n`-th element. Such a subscript would mask the complexity of
  ///   getting the `n`-th element.
  public func index(at offset: Int) -> SyntaxChildrenIndex {
    if offset > self.count / 2 {
      // If we are closer to the end of the collection, it's more efficient to
      // calculate the index starting from the back.
      return self.index(self.endIndex, offsetBy: -(self.count - offset))
    } else {
      return self.index(self.startIndex, offsetBy: offset)
    }
  }

  /// Creates a new collection by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new collection with that element appended to the end.
  @available(*, deprecated, message: "Create a new array of elements and construct a new collection type from those elements")
  public func appending(_ syntax: Element) -> Self {
    var newLayout = layoutView.formLayoutArray()
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new collection by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new collection with that element prepended to the
  ///            beginning.
  @available(*, deprecated, message: "Create a new array of elements and construct a new collection type from those elements")
  public func prepending(_ syntax: Element) -> Self {
    return inserting(syntax, at: 0)
  }

  /// Creates a new collection by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new collection with that element appended to the end.
  @available(*, deprecated, message: "Create a new array of elements and construct a new collection type from those elements")
  public func inserting(_ syntax: Element, at index: Int) -> Self {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition(
      (newLayout.startIndex...newLayout.endIndex).contains(index),
      "inserting node at invalid index \(index)"
    )
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new collection by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new collection with the new element at the provided index.
  @available(*, deprecated, message: "Use .with(\\.[index], newValue) instead")
  public func replacing(childAt index: Int, with syntax: Element) -> Self {
    var newLayout = layoutView.formLayoutArray()
    /// Make sure the index is a valid index for replacing
    precondition(
      (newLayout.startIndex..<newLayout.endIndex).contains(index),
      "replacing node at invalid index \(index)"
    )
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new collection by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new collection with the element at the provided index
  ///            removed.
  @available(*, deprecated, message: "Use filter to remove unwanted elements and construct a new collection type from the filtered elements")
  public func removing(childAt index: Int) -> Self {
    var newLayout = layoutView.formLayoutArray()
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new collection by removing the first element.
  ///
  /// - Returns: A new collection with the first element removed.
  @available(*, deprecated, message: "Use CollectionType(node.dropFirst())")
  public func removingFirst() -> Self {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new collection by removing the last element.
  ///
  /// - Returns: A new collection with the last element removed.
  @available(*, deprecated, message: "Use CollectionType(node.dropLast())")
  public func removingLast() -> Self {
    var newLayout = layoutView.formLayoutArray()
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }
}

/// An iterator over a ``SyntaxCollection``.
public struct SyntaxCollectionIterator<E: SyntaxProtocol>: IteratorProtocol {
  private let parent: Syntax
  public typealias Element = E

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
    return Syntax(absoluteRaw, parent: parent).cast(Element.self)
  }
}

// MARK: Functions analogous to RangeReplaceableCollection

/// Defines functions that are similar to those in `RangeReplaceableCollection`.
///
/// SyntaxCollection doesn’t conform to `RangeReplaceableCollection` because of
/// two reasons:
///  - `RangeReplaceableCollection` assumes that creating a new colleciton and
///    adding all elements from another collection to it results in the same
///    collection. This is not true for `SyntaxCollection` because the new
///    collection wouldn’t have a parent. This causes eg. the default
///    implementation of `filter` to misbehave.
///  - It can’t make the complexity guarantees that `RangeReplaceableCollection`
///    requires, e.g. `append` is `O(tree depth)` instead of `O(1)`.
extension SyntaxCollection {
  /// Replace the nodes in `subrange` by `newElements`.
  public mutating func replaceSubrange(_ subrange: Range<Self.Index>, with newElements: some Collection<Element>) {
    // We only access the raw nodes of `newElements` below.
    // Keep `newElements` alive so their arena doesn't get deallocated.
    withExtendedLifetime(newElements) {
      var newLayout = layoutView.formLayoutArray()
      let layoutRangeLowerBound = (subrange.lowerBound.data?.indexInParent).map(Int.init) ?? newLayout.endIndex
      let layoutRangeUpperBound = (subrange.upperBound.data?.indexInParent).map(Int.init) ?? newLayout.endIndex
      newLayout.replaceSubrange(layoutRangeLowerBound..<layoutRangeUpperBound, with: newElements.map { $0.raw })
      self = replacingLayout(newLayout)
    }
  }

  /// Adds an element to the end of the collection.
  ///
  /// - Parameter newElement: The element to append to the collection.
  public mutating func append(_ newElement: Element) {
    insert(newElement, at: endIndex)
  }

  /// Adds the elements of a sequence to the end of this collection.
  ///
  /// - Parameter newElements: The elements to append to the collection.
  public mutating func append(contentsOf newElements: some Sequence<Element>) {
    insert(contentsOf: Array(newElements), at: endIndex)
  }

  /// Inserts a new element into the collection at the specified position.
  ///
  /// - Parameter newElement: The new element to insert into the collection.
  /// - Parameter i: The position at which to insert the new element.
  ///   `index` must be a valid index into the collection.
  public mutating func insert(_ newElement: Element, at i: Index) {
    replaceSubrange(i..<i, with: CollectionOfOne(newElement))
  }

  /// Inserts the elements of a sequence into the collection at the specified
  /// position.
  ///
  /// - Parameter newElements: The new elements to insert into the collection.
  /// - Parameter i: The position at which to insert the new elements. `index`
  ///   must be a valid index of the collection.
  public mutating func insert(contentsOf newElements: some Collection<Element>, at i: Index) {
    replaceSubrange(i..<i, with: newElements)
  }

  /// Removes and returns the element at the specified position.
  ///
  /// - Parameter position: The position of the element to remove. `position`
  ///   must be a valid index of the collection that is not equal to the
  ///   collection's end index.
  /// - Returns: The removed element.
  @discardableResult
  public mutating func remove(at position: Index) -> Element {
    precondition(!isEmpty, "Can't remove from an empty collection")
    let result: Element = self[position]
    replaceSubrange(position..<index(after: position), with: EmptyCollection())
    return result
  }

  /// Removes the elements in the specified subrange from the collection.
  ///
  /// - Parameter bounds: The range of the collection to be removed. The
  ///   bounds of the range must be valid indices of the collection.
  public mutating func removeSubrange(_ bounds: Range<Index>) {
    replaceSubrange(bounds, with: EmptyCollection())
  }

  /// Creates a new collection by concatenating the elements of a collection and
  /// a sequence.
  ///
  /// - Parameters:
  ///   - lhs: A ``SyntaxCollection``
  ///   - rhs: A collection or finite sequence.
  public static func + (lhs: Self, rhs: some Sequence<Element>) -> Self {
    var result = lhs
    result.append(contentsOf: rhs)
    return result
  }

  /// Creates a new collection by concatenating the elements of a collection and
  /// a sequence.
  ///
  /// - Parameters:
  ///   - lhs: A ``SyntaxCollection``
  ///   - rhs: A collection or finite sequence.
  ///
  /// - Note: This overload exists to resolve when adding an array to a ``SyntaxCollection``.
  public static func + (lhs: Self, rhs: some RangeReplaceableCollection<Element>) -> Self {
    var result = lhs
    result.append(contentsOf: rhs)
    return result
  }

  /// Creates a new collection by concatenating the elements of a sequence and a
  /// collection.
  ///
  /// - Parameters:
  ///   - lhs: A collection or finite sequence.
  ///   - rhs: A range-replaceable collection.
  public static func + (lhs: some Sequence<Element>, rhs: Self) -> Self {
    var result = rhs
    result.insert(contentsOf: Array(lhs), at: result.startIndex)
    return result
  }

  /// Creates a new collection by concatenating the elements of a sequence and a
  /// collection.
  ///
  /// - Parameters:
  ///   - lhs: A collection or finite sequence.
  ///   - rhs: A range-replaceable collection.
  ///
  /// - Note: This overload exists to resolve when adding an array to a ``SyntaxCollection``.
  public static func + (lhs: some RangeReplaceableCollection<Element>, rhs: Self) -> Self {
    var result = rhs
    result.insert(contentsOf: Array(lhs), at: result.startIndex)
    return result
  }

  /// Appends the elements of a sequence to a range-replaceable collection.
  ///
  /// - Parameters:
  ///   - lhs: The ``SyntaxCollection`` to append to.
  ///   - rhs: A collection or finite sequence.
  ///
  /// - Note: This will result in an allocation of a copy of this node.
  public static func += (lhs: inout Self, rhs: some Sequence<Element>) {
    lhs.append(contentsOf: rhs)
  }

  /// Returns a new ``SyntaxCollection`` that just contains the elements
  /// satisfying the given predicate.
  ///
  /// - Parameter isIncluded: A closure that takes an element of the
  ///   collection as its argument and returns a Boolean value indicating
  ///   whether the element should be included in the returned collection.
  /// - Returns: A ``SyntaxCollection`` of the elements that `isIncluded` allowed.
  ///
  /// - Note: This creates a new ``SyntaxCollection`` node. If the resulting node
  ///   is not needed (e.g. because it’s only being iterated), convert the
  ///   ``SyntaxCollection`` to an array first or use the `where` clause in
  ///   a `for` statement.
  public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> Self {
    var result = self
    result.replaceSubrange(self.startIndex..<self.endIndex, with: try Array(self).filter(isIncluded))
    return result
  }
}

/// Conformance to `BidirectionalCollection`.
extension SyntaxCollection {
  public func makeIterator() -> SyntaxCollectionIterator<Element> {
    return SyntaxCollectionIterator<Element>(parent: Syntax(self), rawChildren: rawChildren)
  }

  private var rawChildren: RawSyntaxChildren {
    // We know children in a syntax collection cannot be missing. So we can
    // use the low-level and faster RawSyntaxChildren collection instead of
    // NonNilRawSyntaxChildren.
    return RawSyntaxChildren(Syntax(self).absoluteRaw)
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

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex) -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    get {
      let (raw, info) = rawChildren[position]
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      return Syntax(absoluteRaw, parent: Syntax(self)).cast(Element.self)
    }
    set {
      guard let indexToReplace = (position.data?.indexInParent).map(Int.init) else {
        preconditionFailure("Cannot replace element at the end index")
      }
      var newLayout = layoutView.formLayoutArray()
      /// Make sure the index is a valid index for replacing
      precondition(
        (newLayout.startIndex..<newLayout.endIndex).contains(indexToReplace),
        "replacing node at invalid index \(indexInParent)"
      )
      newLayout[indexToReplace] = newValue.raw
      self = replacingLayout(newLayout)
    }
  }
}
