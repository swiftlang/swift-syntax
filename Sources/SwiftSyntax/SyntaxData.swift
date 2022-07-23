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

/// SyntaxData is a tree node built around RawSyntax.
///
/// In addtion to the `RawSyntax` information, each `SyntaxData` holds the
/// reference to the parent node, and its absolute information in the tree,
/// including byte offset from the root node.
///
/// `SyntaxData` is am implementation detail of `Syntax` nodes. It doesn't
/// provide any public API.
@usableFromInline
struct SyntaxData {
  /// SyntaxData information.
  enum Info {
    case root(Root)
    indirect case edge(Edge)

    /// Data for the root node.
    struct Root {
      // SyntaxArena where the root `RawSyntax` is managed.
      var arena: SyntaxArena
    }

    /// Data for non-root nodes.
    struct Edge {
      // Parent node.
      var parent: SyntaxData
      // Index in parent's chilren. i.e. `parent.child(at: indexInParent) == self`.
      var indexInParent: Int
      // Byte offset from the root node.
      var byteOffset: Int
      // Index from the root node.
      var indexInTree: Int
    }
  }

  private var _info: Info
  var raw: RawSyntax

  init(rootRaw: RawSyntax, arena: SyntaxArena) {
    self._info = .root(.init(arena: arena))
    self.raw = rootRaw
  }

  private init(raw: RawSyntax, parent: SyntaxData, at index: Int, byteOffset: Int, indexInTree: Int) {
    self._info = .edge(.init(parent: parent, indexInParent: index, byteOffset: byteOffset, indexInTree: indexInTree))
    self.raw = raw
  }

  var edgeInfo: Info.Edge? {
    switch _info {
    case .root(_): return nil
    case .edge(let parent): return parent
    }
  }

  var rootInfo: Info.Root {
    var current = self
    while true {
      switch current._info {
      case .edge(let edge):
        current = edge.parent
      case .root(let _root):
        return _root
      }
    }
  }

  /// Absolute byte offset based on the root node.
  var byteOffset: Int {
    return edgeInfo?.byteOffset ?? 0
  }

  /// Absolute node index based on the root node.
  var indexInTree: Int {
    return edgeInfo?.indexInTree ?? 0
  }

  /// Total "width" of the decendent nodes.
  var byteLength: Int {
    return raw.byteLength
  }

  /// Total number of node including `self`.
  var nodeCount: Int {
    return raw.nodeCount
  }

  var root: SyntaxData {
    var current = self
    while let edgeInfo = current.edgeInfo {
      current = edgeInfo.parent
    }
    return current
  }

  /// SyntaxArena where the root resides.
  ///
  /// This arena may be different from the arena where the curent node resides.
  /// In such cases, this 'arena'
  var arena: SyntaxArena {
    rootInfo.arena
  }
}

extension SyntaxData: Hashable {
  @usableFromInline
  func hash(into hasher: inout Hasher) {
    hasher.combine(indexInTree)
    hasher.combine(root.raw.id)
  }
  @usableFromInline
  static func ==(lhs: SyntaxData, rhs: SyntaxData) -> Bool {
    return lhs.indexInTree == rhs.indexInTree && lhs.root.raw === rhs.root.raw
  }
}

/// Provides a stable and unique identity for `Syntax` nodes.
public struct SyntaxIdentifier: Hashable {
  var rawId: Int
  var indexInTree: Int
}

extension SyntaxData: Identifiable {
  public var id: SyntaxIdentifier {
    return .init(rawId: raw.id, indexInTree: indexInTree)
  }
}

// MARK: - Traverse the tree.

/// SyntaxData have a refernce to the parent node, so when the user has a node,
/// they can access to any node in the tree.
///
/// For example, given this tree.
///
///   [root]
///     +- [a]
///     |   +- [b]
///     |   |   |- [c]
///     |   |   `- [d]
///     |   `- [e]
///     |       `- [f]
///     `- [g]
///
/// From [b]'s perspective,
/// - `nextNonNilChild()` -> [c]
/// - `nextSibling()` -> [e]
/// - `nextAncestorSiblig()` -> [g]
/// So, if you want to traverse the tree from [root] in source order(i.e.
/// `[a] ... [g]`), you can check
/// `nextNonNilChild() ?? nextSibling() ?? nextAncestorSibling()` to get the
/// "next" node from each node.
extension SyntaxData {
  var parent: SyntaxData? {
    edgeInfo?.parent
  }

  /// Index in the parent's *layout* buffer.
  ///
  /// This doesn't skip `nil` children. I.e. for `[a, <nil>, b]`,
  /// `b.indexInParent` is `2`. Also, given a non-root node,
  /// `node.parent!.child(at: node.indexInParent!)` must be identical to `node`
  var indexInParent: Int? {
    edgeInfo?.indexInParent
  }

  /// The child node at index in the *layout* buffer.
  func child(at index: Int) -> SyntaxData? {
    guard let childRaw = raw.children[index] else { return nil }

    var byteOffset = byteOffset
    var indexInTree = indexInTree + 1

    // Calculate position data of the child.
    for case let sibling? in raw.children[0..<index] {
      byteOffset += sibling.byteLength
      indexInTree += sibling.nodeCount
    }
    return SyntaxData(raw: childRaw, parent: self, at: index, byteOffset: byteOffset, indexInTree: indexInTree)
  }

  /// The first present child. `nil` if there is no child.
  var firstNonNilChild: SyntaxData? {
    guard nodeCount > 1 else { return nil }
    return raw.children
      .firstIndex { $0.map{ !$0.isMissing } == true }
      .map { child(at: $0)! }
  }

  var lastNonNilChild: SyntaxData? {
    guard nodeCount > 1 else { return nil }
    return raw.children
      .lastIndex { $0.map{ !$0.isMissing } == true }
      .map { child(at: $0)! }
  }

  /// Next present node in the parent.
  var nextSibling: SyntaxData? {
    guard let edgeInfo = edgeInfo else { return nil }
    let parent = edgeInfo.parent
    let rawSiblings = parent.raw.children

    for i in (edgeInfo.indexInParent + 1) ..< rawSiblings.count {
      guard let sibling = rawSiblings[i], !sibling.isMissing else { continue }
      let byteOffset = self.byteOffset + self.byteLength
      let indexInTree = self.indexInTree + self.nodeCount
      return SyntaxData(raw: sibling, parent: parent, at: i, byteOffset: byteOffset, indexInTree: indexInTree)
    }
    return nil
  }

  /// Previous present node in the parent.
  var previousSibling: SyntaxData? {
    guard let edgeInfo = edgeInfo else { return nil }
    let parent = edgeInfo.parent
    let rawSiblings = parent.raw.children

    for i in (0 ..< edgeInfo.indexInParent).reversed() {
      guard let sibling = rawSiblings[i], !sibling.isMissing else { continue }
      let byteOffset = self.byteOffset - sibling.byteLength
      let indexInTree = self.indexInTree - sibling.nodeCount
      return SyntaxData(raw: sibling, parent: parent, at: i, byteOffset: byteOffset, indexInTree: indexInTree)
    }
    return nil
  }

  // The next sibling node of the parent node. If the parent doesn't have it,
  // grand parent's next sibling node, and so on.
  var nextAncestorSibling: SyntaxData? {
    var current = parent
    while let cur = current {
      if let sibling = cur.nextSibling {
        return sibling
      }
      current = cur.parent
    }
    return nil
  }

  // The previous sibling node of the parent node. If the parent doesn't have it,
  // parent's parent's previous sibling node, and so on.
  var previousAncestorSibling: SyntaxData? {
    var current = parent
    while let cur = current {
      if let sibling = cur.previousSibling {
        return sibling
      }
      current = cur.parent
    }
    return nil
  }

  var nextNode: SyntaxData? {
    return firstNonNilChild ?? nextSibling ?? nextAncestorSibling
  }

  var previousNode: SyntaxData? {
    return (previousSibling.map { $0.lastNonNilChild ?? $0 } ??
            previousAncestorSibling.map { $0.lastNonNilChild ?? $0 })
  }
}

// MARK: - Editing the tree.
extension SyntaxData {
  func replacingChild(at index: Int, with childRaw: RawSyntax, arena: SyntaxArena) -> SyntaxData {
    let newRaw = raw.replacingChild(at: index, with: childRaw, arena: arena)
    return self.replacingSelf(with: newRaw, arena: arena)
  }

  func replacingSelf(with newRaw: RawSyntax, arena: SyntaxArena) -> SyntaxData {
    if let edgeInfo = edgeInfo {
      let parentData = edgeInfo.parent.replacingChild(
        at: edgeInfo.indexInParent, with: newRaw, arena: arena)
      return parentData.child(at: edgeInfo.indexInParent)!
    } else {
      return SyntaxData(rootRaw: newRaw, arena: arena)
    }
  }
}
