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

// MARK: - Index

/// The data for an index in a syntax children collection that is not the end
/// index. See ``SyntaxChildrenIndex`` for the representation of the end index.
struct SyntaxChildrenIndexData: Hashable, Comparable, Sendable {
  /// The UTF-8 offset of the item at this index in the source file
  /// See `AbsoluteSyntaxPosition.offset`
  let offset: UInt32
  /// The index of the node in the parent.
  /// See `AbsoluteSyntaxPosition.indexInParent`
  let indexInParent: UInt32
  /// Unique value for a node within its own tree.
  /// See `SyntaxIdentifier.indexIntree`
  let indexInTree: SyntaxIndexInTree

  static func < (
    lhs: SyntaxChildrenIndexData,
    rhs: SyntaxChildrenIndexData
  ) -> Bool {
    return lhs.indexInParent < rhs.indexInParent
  }

  fileprivate init(
    offset: UInt32,
    indexInParent: UInt32,
    indexInTree: SyntaxIndexInTree
  ) {
    self.offset = offset
    self.indexInParent = indexInParent
    self.indexInTree = indexInTree
  }

  init(_ absoluteSyntaxInfo: AbsoluteSyntaxInfo) {
    self.offset = absoluteSyntaxInfo.offset
    self.indexInParent = absoluteSyntaxInfo.indexInParent
    self.indexInTree = absoluteSyntaxInfo.nodeId.indexInTree
  }
}

/// An index in a syntax children collection.
public struct SyntaxChildrenIndex: Hashable, Comparable, ExpressibleByNilLiteral, Sendable {
  /// Construct the `endIndex` of a ``SyntaxChildren`` collection.
  public init(nilLiteral: ()) {
    self.data = nil
  }

  // Performance considerations:
  // It is faster to use a special end index than computing a materialized index
  // that stores past the end of the collection if forward iteration is the only
  // thing that's needed.

  /// `nil` represents the end index and `.some` represents a materialized index
  /// that points into a collection.
  /// It is faster to use `Optional` here rather than making
  /// `SyntaxChildrenIndex` an enum because the optional value can be
  /// force-unwrapped when we know that an index is not the end index, saving a
  /// switch case comparison.
  let data: SyntaxChildrenIndexData?

  fileprivate init(
    offset: UInt32,
    indexInParent: UInt32,
    indexInTree: SyntaxIndexInTree
  ) {
    self.data = SyntaxChildrenIndexData(
      offset: offset,
      indexInParent: indexInParent,
      indexInTree: indexInTree
    )
  }

  internal init(_ absoluteSyntaxInfo: AbsoluteSyntaxInfo) {
    self.data = SyntaxChildrenIndexData(absoluteSyntaxInfo)
  }

  /// Returns `true` if `lhs` occurs before `rhs`.
  public static func < (lhs: SyntaxChildrenIndex, rhs: SyntaxChildrenIndex) -> Bool {
    switch (lhs.data, rhs.data) {
    case (.some(let lhsData), .some(let rhsData)):
      return lhsData < rhsData
    case (.some(_), .none):
      return true
    case (.none, .some(_)):
      return false
    case (.none, .none):
      return false
    }
  }
}

fileprivate extension AbsoluteSyntaxInfo {
  /// Construct `AbsoluteSyntaxInfo` from the given index data and a `rootId`.
  init(index: SyntaxChildrenIndexData, rootId: UInt) {
    let position = AbsoluteSyntaxPosition(
      offset: index.offset,
      indexInParent: index.indexInParent
    )
    let identifier = SyntaxIdentifier(
      rootId: rootId,
      indexInTree: index.indexInTree
    )
    self.init(position: position, nodeId: identifier)
  }
}

// MARK: - Collections

/// Collection that contains the child nodes of a raw node (including missing
/// nodes), along with their associated `AbsoluteSyntaxInfo`.
struct RawSyntaxChildren: BidirectionalCollection, Sendable {
  typealias Element = (raw: RawSyntax?, syntaxInfo: AbsoluteSyntaxInfo)
  typealias Index = SyntaxChildrenIndex

  struct Iterator: IteratorProtocol {
    let collection: RawSyntaxChildren
    var nextIndex: SyntaxChildrenIndex

    init(collection: RawSyntaxChildren) {
      self.collection = collection
      self.nextIndex = collection.startIndex
    }

    mutating func next() -> RawSyntaxChildren.Element? {
      guard nextIndex != collection.endIndex else {
        return nil
      }
      // Re-use the fetched child to compute the next index, eliminating one
      // access to the underlying collection
      let child = collection[nextIndex]
      nextIndex = collection.index(nextIndex, advancedBy: child.raw)
      return child
    }
  }

  /// The node whose children shall be accessed
  private let parent: RawSyntax

  private var parentLayoutView: RawSyntaxLayoutView {
    return parent.layoutView!
  }

  /// The rootId of the tree the child nodes belong to
  private let rootId: UInt

  /// The number of children in `parent`. Cached to avoid reaching into `parent` for every index
  /// advancement
  private let numberOfChildren: Int

  let startIndex: SyntaxChildrenIndex
  var endIndex: SyntaxChildrenIndex {
    return nil
  }

  func makeIterator() -> Iterator {
    return Iterator(collection: self)
  }

  /// Advance the given index by the given ``RawSyntax`` node.
  func index(_ index: Index, advancedBy node: RawSyntax?) -> Index {
    // We can assume a non-end index since advancing the end index is undefined
    // behaviour.
    let index = index.data!

    if index.indexInParent + 1 < numberOfChildren {
      // Compute the next materialized index
      let nodeLength = UInt32(node?.totalLength.utf8Length ?? 0)
      let advancedIndexInTree = index.indexInTree.advancedBy(node)
      return SyntaxChildrenIndex(
        offset: index.offset + nodeLength,
        indexInParent: index.indexInParent + 1,
        indexInTree: advancedIndexInTree
      )
    } else {
      // We have reached the end of the collection. Return the end index.
      return nil
    }
  }

  func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    guard let indexData = index.data else {
      preconditionFailure("Cannot get the index after the end index")
    }
    let node = parent.layoutView!.children[Int(indexData.indexInParent)]
    return self.index(index, advancedBy: node)
  }

  func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    if let index = index.data {
      // We are reversing a non-end index.
      let previousNode = parent.layoutView!.children[Int(index.indexInParent - 1)]
      let previousNodeLength = UInt32(previousNode?.totalLength.utf8Length ?? 0)
      let reversedIndexInTree = index.indexInTree.reversedBy(previousNode)
      return SyntaxChildrenIndex(
        offset: index.offset - previousNodeLength,
        indexInParent: index.indexInParent - 1,
        indexInTree: reversedIndexInTree
      )
    } else {
      // We need to reverse the end index. For this we need to compute a
      // materialized version of the end index that points one past the end of
      // the collection. After we have that materialized index, we can reverse
      // it using the above logic.

      // If the start index is nil, then the collection is empty and we are
      // reversing before the start index. That is undefined behaviour, so we
      // can assume a non-end index.
      let startIndex = self.startIndex.data!

      // Compute a materialized index.
      let offset = startIndex.offset + UInt32(parent.totalLength.utf8Length)
      let indexInParent = startIndex.indexInParent + UInt32(parentLayoutView.children.count)
      let indexInTree = startIndex.indexInTree.indexInTree + UInt32(parent.totalNodes) - 1
      let syntaxIndexInTree = SyntaxIndexInTree(indexInTree: indexInTree)
      let materialized = SyntaxChildrenIndex(
        offset: offset,
        indexInParent: indexInParent,
        indexInTree: syntaxIndexInTree
      )

      // Reverse index based on the above logic
      return self.index(before: materialized)
    }
  }

  func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex) -> Int {
    switch (start.data, end.data) {
    case (.some(let start), .some(let end)):
      return Int(end.indexInParent - start.indexInParent)
    case (.some(let start), .none):
      return parentLayoutView.children.count - Int(start.indexInParent)
    case (.none, .some(let end)):
      return Int(end.indexInParent) - parentLayoutView.children.count
    case (.none, .none):
      return 0
    }
  }

  subscript(index: SyntaxChildrenIndex) -> (raw: RawSyntax?, syntaxInfo: AbsoluteSyntaxInfo) {
    // Accessing the end index is undefined. So we can assume a non-end index.
    let index = index.data!

    let child = parent.layoutView!.children[Int(index.indexInParent)]
    let info = AbsoluteSyntaxInfo(index: index, rootId: rootId)
    return (child, info)
  }

  init(_ parent: AbsoluteRawSyntax) {
    self.parent = parent.raw
    self.rootId = parent.info.nodeId.rootId
    switch parent.raw.view {
    case .layout(let layoutView):
      self.numberOfChildren = layoutView.children.count
    case .token:
      self.numberOfChildren = 0
    }

    if self.numberOfChildren == 0 {
      self.startIndex = nil
    } else {
      let startPosition = parent.info.advancedToFirstChild()
      self.startIndex = SyntaxChildrenIndex(startPosition)
    }
  }

  init(_ base: Syntax) {
    self.init(base.absoluteRaw)
  }
}

/// Collection that contains the `present` child nodes of an
/// `AbsoluteRawSyntax` node.
struct NonNilRawSyntaxChildren: BidirectionalCollection, Sendable {
  typealias Element = AbsoluteRawSyntax
  typealias Index = SyntaxChildrenIndex

  struct Iterator: IteratorProtocol {
    var iterator: RawSyntaxChildren.Iterator
    let viewMode: SyntaxTreeViewMode

    init(allChildren: RawSyntaxChildren, viewMode: SyntaxTreeViewMode) {
      self.iterator = allChildren.makeIterator()
      self.viewMode = viewMode
    }

    mutating func next() -> AbsoluteRawSyntax? {
      // Advance the underlying RawSyntaxChildren.Iterator until we find a
      // present node.
      while true {
        guard let (node, info) = self.iterator.next() else {
          return nil
        }
        if let node, viewMode.shouldTraverse(node: node) {
          return AbsoluteRawSyntax(raw: node, info: info)
        }
      }
    }
  }

  let viewMode: SyntaxTreeViewMode

  /// The underlying collection which contains all children. The present
  /// children are filtered from this collection.
  private var allChildren: RawSyntaxChildren

  let startIndex: SyntaxChildrenIndex
  var endIndex: SyntaxChildrenIndex {
    return allChildren.endIndex
  }

  func makeIterator() -> Iterator {
    return Iterator(allChildren: allChildren, viewMode: viewMode)
  }

  /// Advances the index to the next present node in the given collection. If
  /// the node at the given index is already present, it is not advanced.
  /// If no present node exists in the given collection after the index, the
  /// collection's `endIndex` is returned.
  private static func presentIndex(
    after index: SyntaxChildrenIndex,
    in children: RawSyntaxChildren,
    viewMode: SyntaxTreeViewMode
  ) -> SyntaxChildrenIndex {
    var advancedIndex = index
    while true {
      if advancedIndex != children.endIndex {
        let node = children[advancedIndex].raw
        if let node = node, viewMode.shouldTraverse(node: node) {
          // Found a present node. Return its index.
          return advancedIndex
        }
        // Continue advancing
        advancedIndex = children.index(advancedIndex, advancedBy: node)
      } else {
        // Reached the end of the collection. Don't advance further.
        return advancedIndex
      }
    }
  }

  /// Reverses the index to the previous present node in the given collection.
  /// If the node at the given index is already present, it is not reversed.
  /// Behavior is undefined if no present index exists before the given index.
  private static func presentIndex(
    before index: SyntaxChildrenIndex,
    in children: RawSyntaxChildren,
    viewMode: SyntaxTreeViewMode
  ) -> SyntaxChildrenIndex {
    var reversedIndex = index
    while true {
      if reversedIndex < children.endIndex,
        let node = children[reversedIndex].raw,
        viewMode.shouldTraverse(node: node)
      {
        return reversedIndex
      }
      // Reversing any further would result in undefined behaviour of
      // index(before:)
      precondition(reversedIndex != children.startIndex, "presentIndex(before:) must not be called if there is no " + "present index before the given one")
      reversedIndex = children.index(before: reversedIndex)
    }
  }

  func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    let nextIndex = allChildren.index(after: index)
    return Self.presentIndex(
      after: nextIndex,
      in: allChildren,
      viewMode: viewMode
    )
  }

  func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    // presentIndex(before:) must have a valid previous present node. By
    // contract of the index(before:) function we are not called on the start
    // index. The start index points to the first present node. Hence there is
    // a present node before us.
    return Self.presentIndex(
      before: allChildren.index(before: index),
      in: allChildren,
      viewMode: viewMode
    )
  }

  subscript(position: SyntaxChildrenIndex) -> AbsoluteRawSyntax {
    let (node, info) = allChildren[position]
    // Valid indices always point to present nodes. Thus safe to force unwrap.
    return AbsoluteRawSyntax(raw: node!, info: info)
  }

  init(_ parent: AbsoluteRawSyntax, viewMode: SyntaxTreeViewMode) {
    let allChildren = RawSyntaxChildren(parent)

    self.allChildren = allChildren
    self.startIndex = Self.presentIndex(
      after: allChildren.startIndex,
      in: allChildren,
      viewMode: viewMode
    )
    self.viewMode = viewMode
  }

  init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.init(node.absoluteRaw, viewMode: viewMode)
  }
}

/// Collection that contains the present child ``Syntax`` nodes of the given node.
public struct SyntaxChildren: BidirectionalCollection, Sendable {
  /// ``SyntaxChildren`` is indexed by ``SyntaxChildrenIndex``.
  public typealias Index = SyntaxChildrenIndex

  /// ``SyntaxChildren`` contains ``Syntax`` nodes.
  public typealias Element = Syntax

  /// The collection that contains the raw child nodes. ``Syntax`` nodes are
  /// generated from these.
  private let rawChildren: NonNilRawSyntaxChildren

  /// The parent node of the children. Used to build the ``Syntax`` nodes.
  private let parent: Syntax

  /// The index of the first child in this collection.
  public var startIndex: SyntaxChildrenIndex { return rawChildren.startIndex }

  /// The index that’s one after the last element in the collection.
  public var endIndex: SyntaxChildrenIndex { return rawChildren.endIndex }

  /// The index for the child that’s after the child at `index`.
  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(after: index)
  }

  /// The index for the child that’s before the child at `index`.
  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    return rawChildren.index(before: index)
  }

  /// The syntax node at the given `index`
  public subscript(index: SyntaxChildrenIndex) -> Syntax {
    let child = rawChildren[index]
    return Syntax(child, parent: parent)
  }

  internal init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.rawChildren = NonNilRawSyntaxChildren(node, viewMode: viewMode)
    self.parent = node
  }

  /// Return the index of `node` within this collection.
  ///
  /// If `node` is not part of this collection, returns `nil`.
  public func index(of node: some SyntaxProtocol) -> SyntaxChildrenIndex? {
    return index(of: Syntax(node))
  }

  /// Return the index of `node` within this collection.
  ///
  /// If `node` is not part of this collection, returns `nil`.
  ///
  /// - Note: This method is functionally equivalent to the one that takes
  ///   ``SyntaxProtocol``. It is provided because otherwise `Collection.index(of:)`
  ///   is chosen, which is marked as deprecated and renamed to `firstIndex(of:)`.
  public func index(of node: Syntax) -> SyntaxChildrenIndex? {
    guard node.parent == parent else {
      return nil
    }
    return node.indexInParent
  }
}
