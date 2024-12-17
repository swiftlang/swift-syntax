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

/// Provides a stable and unique identity for ``Syntax`` nodes.
///
/// Note that two nodes might have the same contents even if their IDs are
/// different. For example two different ``FunctionDeclSyntax`` nodes
/// might have the exact same contents but if they occur at a different
/// location in the source file, they have different IDs.
///
/// Also note that the ID of a syntax node changes when it is anchored in a
/// different syntax tree. Modifying any node in the syntax tree a node is
/// contained in generates a copy of that tree and thus changes the IDs of all
/// nodes in the tree, not just the modified node's children.
public struct SyntaxIdentifier: Comparable, Hashable, Sendable {
  /// Represents a unique value for a node within its own tree.
  ///
  /// This is similar to ``SyntaxIdentifier`` but does not store the root ID of the tree.
  /// It can thus be transferred across trees that are structurally equivalent, for example two copies of the same tree
  /// that live in different processes.
  public struct SyntaxIndexInTree: Hashable, Sendable {
    /// When traversing the syntax tree using a depth-first traversal, the index at which the node will be visited.
    let indexInTree: UInt32

    init(indexInTree: UInt32) {
      self.indexInTree = indexInTree
    }

    /// Converts the ``SyntaxIdentifier/SyntaxIndexInTree`` to an opaque value that can be serialized.
    /// The opaque value can be restored to a ``SyntaxIdentifier/SyntaxIndexInTree`` using ``init(fromOpaque:)``.
    ///
    /// - Note: The contents of the opaque value are not specified and clients should not rely on them.
    public func toOpaque() -> UInt64 {
      return UInt64(indexInTree)
    }

    /// Creates a ``SyntaxIdentifier/SyntaxIndexInTree`` from an opaque value obtained using ``toOpaque()``.
    public init(fromOpaque opaque: UInt64) {
      self.indexInTree = UInt32(opaque)
    }
  }

  /// Unique value for the root node.
  ///
  /// Multiple trees may have the same 'rootId' if their root RawSyntax is the
  /// same instance. This guarantees that the trees with the same 'rootId' have
  /// exact the same structure. But, two trees with exactly the same structure
  /// might still have different 'rootId's.
  let rootId: UInt

  /// Unique value for a node within its own tree.
  public let indexInTree: SyntaxIndexInTree

  /// Forms a ``SyntaxIdentifier`` from an ``SyntaxIdentifier/SyntaxIndexInTree`` inside a ``Syntax`` node that
  /// constitutes the tree's root.
  ///
  /// Returns `nil` if `root` is not the root of a syntax tree or if `indexInTree` points to a node that is not within
  /// the tree spanned up by `root`.
  ///
  /// - Warning: ``SyntaxIdentifier/SyntaxIndexInTree`` is not stable with regard to insertion or deletions of nodes
  ///   into a syntax tree. There are only two scenarios where it is valid to share ``SyntaxIndexInTree`` between syntax
  ///   trees with different nodes:
  ///   (1) If two trees are guaranteed to be exactly the same eg. because they were parsed using the same version of
  ///       `SwiftParser` from the same source code.
  ///   (2) If a tree was mutated by only replacing tokens with other tokens. No nodes must have been inserted or
  ///       removed during the process, including tokens that are marked as ``SourcePresence/missing``.
  public static func fromIndexInTree(
    _ indexInTree: SyntaxIndexInTree,
    relativeToRoot root: some SyntaxProtocol
  ) -> SyntaxIdentifier? {
    guard !root.hasParent, Int(truncatingIfNeeded: indexInTree.indexInTree) < root.raw.totalNodes else {
      return nil
    }

    return SyntaxIdentifier(rootId: UInt(rawID: root.raw.id), indexInTree: indexInTree)
  }

  /// A ``SyntaxIdentifier`` compares less than another ``SyntaxIdentifier`` if the node at that identifier occurs first
  /// during a depth-first traversal of the tree. This implies that nodes with an earlier ``AbsolutePosition`` also
  /// have a lower ``SyntaxIdentifier``.
  public static func < (lhs: SyntaxIdentifier, rhs: SyntaxIdentifier) -> Bool {
    guard lhs.rootId == rhs.rootId else {
      // Nodes in different trees are not comparable.
      return false
    }
    return lhs.indexInTree.indexInTree < rhs.indexInTree.indexInTree
  }
}
