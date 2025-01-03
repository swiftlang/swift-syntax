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

/// An index in a syntax children collection.
public struct SyntaxChildrenIndex: Hashable, Comparable, Sendable {
  /// The index in a `SyntaxDataReferenceBuffer` that is being referenced by this `SyntaxChildrenIndex`.
  let value: Int

  init(value: Int) {
    self.value = value
  }

  /// Returns `true` if `lhs` occurs before `rhs`.
  public static func < (lhs: SyntaxChildrenIndex, rhs: SyntaxChildrenIndex) -> Bool {
    lhs.value < rhs.value
  }
}

// MARK: - Collections

/// Collection that contains the present child ``Syntax`` nodes of the given node.
public struct SyntaxChildren: BidirectionalCollection, Sendable {
  /// ``SyntaxChildren`` is indexed by ``SyntaxChildrenIndex``.
  public typealias Index = SyntaxChildrenIndex

  /// ``SyntaxChildren`` contains ``Syntax`` nodes.
  public typealias Element = Syntax

  private let viewMode: SyntaxTreeViewMode

  /// The parent node of the children. Used to build the ``Syntax`` nodes.
  private let parent: Syntax

  /// Pre-fetched layout buffer. Because accessing `Syntax.layoutBuffer` may not be trivial.
  private let layoutBuffer: SyntaxDataReferenceBuffer

  /// The index of the first child in this collection.
  public let startIndex: SyntaxChildrenIndex

  /// The index that’s one after the last element in the collection.
  public var endIndex: SyntaxChildrenIndex { Index(value: layoutBuffer.endIndex) }

  private static func shouldTraverse(_ dataRef: SyntaxDataReference?, viewMode: SyntaxTreeViewMode) -> Bool {
    guard let dataRef else {
      return false
    }
    return viewMode.shouldTraverse(node: dataRef.pointee.raw)
  }

  /// The index for the child that’s after the child at `index`.
  public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    precondition(index < endIndex)
    return Index(
      value: layoutBuffer[(index.value + 1)...]
        .firstIndex(where: { Self.shouldTraverse($0, viewMode: viewMode) }) ?? layoutBuffer.endIndex
    )
  }

  /// The index for the child that’s before the child at `index`.
  public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    precondition(index > startIndex)
    return Index(
      value: layoutBuffer[..<index.value]
        .lastIndex(where: { Self.shouldTraverse($0, viewMode: viewMode) })!
    )
  }

  /// The syntax node at the given `index`
  public subscript(index: SyntaxChildrenIndex) -> Syntax {
    return Syntax(arena: parent.arena, dataRef: layoutBuffer[index.value]!)
  }

  internal init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.parent = node
    self.layoutBuffer = node.layoutBuffer
    self.viewMode = viewMode
    self.startIndex = Index(
      value: layoutBuffer.firstIndex(where: { Self.shouldTraverse($0, viewMode: viewMode) }) ?? layoutBuffer.endIndex
    )
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
