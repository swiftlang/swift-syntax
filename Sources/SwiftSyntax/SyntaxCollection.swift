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

public protocol SyntaxCollection: SyntaxProtocol, BidirectionalCollection, MutableCollection where Element: SyntaxProtocol {
  associatedtype Iterator = SyntaxCollectionIterator<Element>

  /// The ``SyntaxKind`` of the syntax node that conforms to ``SyntaxCollection``.
  static var syntaxKind: SyntaxKind { get }
}

extension SyntaxCollection {
  public static var structure: SyntaxNodeStructure {
    return .collection(Element.self)
  }

  private var layoutView: RawSyntaxLayoutView {
    data.raw.layoutView!
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    self.init(Syntax(data))!
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
    self.init(SyntaxData.forRoot(raw, rawNodeArena: arena))
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
    let newData = data.replacingSelf(newRaw, rawNodeArena: arena, allocationArena: arena)
    return Syntax(newData).cast(Self.self)
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
    let data = SyntaxData(absoluteRaw, parent: parent)
    return Syntax(data).cast(Element.self)
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

  public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex) -> Int {
    return rawChildren.distance(from: start, to: end)
  }

  public subscript(position: SyntaxChildrenIndex) -> Element {
    get {
      let (raw, info) = rawChildren[position]
      let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
      let data = SyntaxData(absoluteRaw, parent: Syntax(self))
      return Syntax(data).cast(Element.self)
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
