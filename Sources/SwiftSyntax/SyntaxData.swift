//===-------------------- SyntaxData.swift - Syntax Data ------------------===//
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

struct AbsoluteSyntaxPosition {
  /// The UTF-8 offset of the syntax node in the source file
  let offset: UInt32
  let indexInParent: UInt32

  func advancedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxPosition {
    let newOffset = self.offset + UInt32(truncatingIfNeeded: raw?.totalLength.utf8Length ?? 0)
    let newIndexInParent = self.indexInParent + 1
    return .init(offset: newOffset, indexInParent: newIndexInParent)
  }

  func reversedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxPosition {
    let newOffset = self.offset - UInt32(truncatingIfNeeded: raw?.totalLength.utf8Length ?? 0)
    let newIndexInParent = self.indexInParent - 1
    return .init(offset: newOffset, indexInParent: newIndexInParent)
  }

  func advancedToFirstChild() -> AbsoluteSyntaxPosition {
    return .init(offset: self.offset, indexInParent: 0)
  }

  static var forRoot: AbsoluteSyntaxPosition {
    return .init(offset: 0, indexInParent: 0)
  }
}

/// AbsoluteSyntaxInfo represents the information that relates a RawSyntax to a
/// source file tree, like its absolute source offset.
struct AbsoluteSyntaxInfo {
  let position: AbsoluteSyntaxPosition
  let nodeId: SyntaxIdentifier

  /// The UTF-8 offset of the syntax node in the source file
  var offset: UInt32 { return position.offset }
  var indexInParent: UInt32 { return position.indexInParent }

  func advancedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxInfo {
    let newPosition = position.advancedBySibling(raw)
    let newNodeId = nodeId.advancedBySibling(raw)
    return .init(position: newPosition, nodeId: newNodeId)
  }

  func reversedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxInfo {
    let newPosition = position.reversedBySibling(raw)
    let newNodeId = nodeId.reversedBySibling(raw)
    return .init(position: newPosition, nodeId: newNodeId)
  }

  func advancedToFirstChild() -> AbsoluteSyntaxInfo {
    let newPosition = position.advancedToFirstChild()
    let newNodeId = nodeId.advancedToFirstChild()
    return .init(position: newPosition, nodeId: newNodeId)
  }

  static func forRoot(_ raw: RawSyntax) -> AbsoluteSyntaxInfo {
    return .init(position: .forRoot, nodeId: .forRoot(raw))
  }
}

/// Represents a unique value for a node within its own tree.
@_spi(RawSyntax)
public struct SyntaxIndexInTree: Comparable, Hashable {
  let indexInTree: UInt32

  static var zero: SyntaxIndexInTree = SyntaxIndexInTree(indexInTree: 0)

  /// Assuming that this index points to the start of `Raw`, so that it points
  /// to the next sibling of `Raw`.
  func advancedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree +
                         UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  /// Assuming that this index points to the next sibling of `Raw`, reverse it
  /// so that it points to the start of `Raw`.
  func reversedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree -
                         UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  func advancedToFirstChild() -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree + 1
    return .init(indexInTree: newIndexInTree)
  }

  init(indexInTree: UInt32) {
    self.indexInTree = indexInTree
  }

  public static func < (lhs: SyntaxIndexInTree, rhs: SyntaxIndexInTree) -> Bool {
    return lhs.indexInTree < rhs.indexInTree
  }
}

/// Provides a stable and unique identity for `Syntax` nodes.
public struct SyntaxIdentifier: Hashable {
  /// Unique value for the root node.
  ///
  /// Multiple trees may have the same 'rootId' if their root RawSyntax is the
  /// same instance. This guarantees that the trees with the same 'rootId' have
  /// exact the same structure. But, two trees with exactly the same structure
  /// might still have different 'rootId's.
  let rootId: UInt
  /// Unique value for a node within its own tree.
  @_spi(RawSyntax)
  public let indexInTree: SyntaxIndexInTree

  func advancedBySibling(_ raw: RawSyntax?) -> SyntaxIdentifier {
    let newIndexInTree = indexInTree.advancedBy(raw)
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  func reversedBySibling(_ raw: RawSyntax?) -> SyntaxIdentifier {
    let newIndexInTree = self.indexInTree.reversedBy(raw)
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  func advancedToFirstChild() -> SyntaxIdentifier {
    let newIndexInTree = self.indexInTree.advancedToFirstChild()
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  static func forRoot(_ raw: RawSyntax) -> SyntaxIdentifier {
    return .init(rootId: UInt(bitPattern: raw.pointer),
                 indexInTree: .zero)
  }
}

struct AbsoluteRawSyntax {
  let raw: RawSyntax
  let info: AbsoluteSyntaxInfo

  /// The position of the start of this node's leading trivia
  var position: AbsolutePosition {
    return AbsolutePosition(utf8Offset: Int(info.offset))
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    return position + raw.totalLength
  }

  /// Returns first `present` child.
  func firstChild(viewMode: SyntaxTreeViewMode) -> AbsoluteRawSyntax? {
    guard let layoutView = raw.layoutView else { return nil }
    var curInfo = info.advancedToFirstChild()
    for childOpt in layoutView.children {
      if let child = childOpt, viewMode.shouldTraverse(node: child) {
        return AbsoluteRawSyntax(raw: child, info: curInfo)
      }
      curInfo = curInfo.advancedBySibling(childOpt)
    }
    return nil
  }

  /// Returns next `present` sibling.
  func nextSibling(parent: AbsoluteRawSyntax, viewMode: SyntaxTreeViewMode) -> AbsoluteRawSyntax? {
    var curInfo = info.advancedBySibling(raw)
    for siblingOpt in parent.raw.layoutView!.children.dropFirst(Int(info.indexInParent+1)) {
      if let sibling = siblingOpt, viewMode.shouldTraverse(node: sibling) {
        return AbsoluteRawSyntax(raw: sibling, info: curInfo)
      }
      curInfo = curInfo.advancedBySibling(siblingOpt)
    }
    return nil
  }

  func replacingSelf(_ newRaw: RawSyntax, newRootId: UInt) -> AbsoluteRawSyntax {
    let nodeId = SyntaxIdentifier(rootId: newRootId, indexInTree: info.nodeId.indexInTree)
    let newInfo = AbsoluteSyntaxInfo(position: info.position, nodeId: nodeId)
    return .init(raw: newRaw, info: newInfo)
  }

  static func forRoot(_ raw: RawSyntax) -> AbsoluteRawSyntax {
    return .init(raw: raw, info: .forRoot(raw))
  }
}

/// SyntaxData is the underlying storage for each Syntax node.
///
/// SyntaxData is an implementation detail, and should not be exposed to clients
/// of SwiftSyntax.
struct SyntaxData {
  private enum Info {
    case root(Root)
    indirect case nonRoot(NonRoot)

    // For root node.
    struct Root {
      var arena: SyntaxArena
    }

    // For non-root nodes.
    struct NonRoot {
      var parent: SyntaxData
      var absoluteInfo: AbsoluteSyntaxInfo
    }
  }

  private let info: Info
  let raw: RawSyntax

  private var rootInfo: Info.Root {
    switch info {
    case .root(let info): return info
    case .nonRoot(let info): return info.parent.rootInfo
    }
  }

  private var nonRootInfo: Info.NonRoot? {
    switch info {
    case .root(_): return nil
    case .nonRoot(let info): return info
    }
  }

  private var rootArena: SyntaxArena {
    rootInfo.arena
  }

  private var root: SyntaxData {
    switch info {
    case .root(_): return self
    case .nonRoot(let info): return info.parent.root
    }
  }

  var parent: SyntaxData? {
    nonRootInfo?.parent
  }

  var absoluteInfo: AbsoluteSyntaxInfo {
    nonRootInfo?.absoluteInfo ?? .forRoot(raw)
  }

  var absoluteRaw: AbsoluteRawSyntax {
    AbsoluteRawSyntax(raw: raw, info: absoluteInfo)
  }

  var indexInParent: Int {
    Int(absoluteInfo.indexInParent)
  }

  var nodeId: SyntaxIdentifier {
    absoluteInfo.nodeId
  }

  /// The position of the start of this node's leading trivia
  var position: AbsolutePosition {
    AbsolutePosition(utf8Offset: Int(absoluteInfo.offset))
  }

  /// The position of the start of this node's content, skipping its trivia
  var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return position + raw.leadingTriviaLength
  }

  /// The end position of this node's content, before any trailing trivia.
  var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return endPosition - raw.trailingTriviaLength
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    position + raw.totalLength
  }

  /// "designated" memberwise initializer of `SyntaxData`.
  private init(_ raw: RawSyntax, info: Info) {
    self.raw = raw
    self.info = info
  }

  init(_ raw: RawSyntax, parent: SyntaxData, absoluteInfo: AbsoluteSyntaxInfo) {
    self.init(raw, info: .nonRoot(.init(parent: parent, absoluteInfo: absoluteInfo)))
  }

  /// Creates a `SyntaxData` with the provided raw syntax and parent.
  /// - Parameters:
  ///   - absoluteRaw: The underlying `AbsoluteRawSyntax` of this node.
  ///   - parent: The parent of this node, or `nil` if this node is the root.
  init(_ absoluteRaw: AbsoluteRawSyntax, parent: Syntax) {
    self.init(absoluteRaw.raw, parent: parent.data, absoluteInfo: absoluteRaw.info)
  }

  /// Creates a `SyntaxData` for a root raw node.
  static func forRoot(_ raw: RawSyntax) -> SyntaxData {
    SyntaxData(raw, info: .root(.init(arena: raw.arena)))
  }

  /// Returns the child data at the provided index in this data's layout.
  /// - Note: This has O(n) performance, prefer using a proper Sequence type
  ///         if applicable, instead of this.
  /// - Note: This function traps if the index is out of the bounds of the
  ///         data's layout.
  ///
  /// - Parameter index: The index to create and cache.
  /// - Parameter parent: The parent to associate the child with. This is
  ///             normally the Syntax node that this `SyntaxData` belongs to.
  /// - Returns: The child's data at the provided index.
  func child(at index: Int, parent: Syntax) -> SyntaxData? {
    if raw.layoutView!.children[index] == nil { return nil }
    var iter = RawSyntaxChildren(absoluteRaw).makeIterator()
    for _ in 0..<index { _ = iter.next() }
    let (raw, info) = iter.next()!
    return SyntaxData(raw!, parent: self, absoluteInfo: info)
  }

  /// Creates a copy of `self` and recursively creates `SyntaxData` nodes up to
  /// the root.
  /// - parameter newRaw: The new RawSyntax that will back the new `Data`
  /// - returns: A tuple of both the new root node and the new data with the raw
  ///            layout replaced.
  func replacingSelf(
    _ newRaw: RawSyntax) -> SyntaxData {
    // If we have a parent already, then ask our current parent to copy itself
    // recursively up to the root.
    if let parent = parent {
      let parentData = parent.replacingChild(newRaw, at: indexInParent)
      let newParent = Syntax(parentData)
      return SyntaxData(absoluteRaw.replacingSelf(newRaw, newRootId: parentData.nodeId.rootId), parent: newParent)
    } else {
      // Otherwise, we're already the root, so return the new root data.
      return .forRoot(newRaw)
    }
  }

  /// Creates a copy of `self` with the child at the provided index replaced
  /// with a new SyntaxData containing the raw syntax provided.
  ///
  /// - Parameters:
  ///   - child: The raw syntax for the new child to replace.
  ///   - index: The index pointing to where in the raw layout to place this
  ///            child.
  /// - Returns: The new root node created by this operation, and the new child
  ///            syntax data.
  /// - SeeAlso: replacingSelf(_:)
  func replacingChild(_ child: RawSyntax?, at index: Int) -> SyntaxData {
    let newRaw = raw.layoutView!.replacingChild(at: index, with: child, arena: .default)
    return replacingSelf(newRaw)
  }

  func withLeadingTrivia(_ leadingTrivia: Trivia) -> SyntaxData {
    if let raw = raw.withLeadingTrivia(leadingTrivia) {
      return replacingSelf(raw)
    } else {
      return self
    }
  }

  func withTrailingTrivia(_ trailingTrivia: Trivia) -> SyntaxData {
    if let raw = raw.withTrailingTrivia(trailingTrivia) {
      return replacingSelf(raw)
    } else {
      return self
    }
  }
}
