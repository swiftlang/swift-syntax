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

/// Represents a unique value for a node within its own tree.
@_spi(RawSyntax)
public struct SyntaxIndexInTree: Comparable, Hashable, Sendable {
  let indexInTree: UInt32

  static let zero: SyntaxIndexInTree = SyntaxIndexInTree(indexInTree: 0)

  /// Assuming that this index points to the start of ``Raw``, so that it points
  /// to the next sibling of ``Raw``.
  func advancedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree + UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  /// Assuming that this index points to the next sibling of ``Raw``, reverse it
  /// so that it points to the start of ``Raw``.
  func reversedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree - UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  func advancedToFirstChild() -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree + 1
    return .init(indexInTree: newIndexInTree)
  }

  init(indexInTree: UInt32) {
    self.indexInTree = indexInTree
  }

  /// Returns `true` if `lhs` occurs before `rhs` in the tree.
  public static func < (lhs: SyntaxIndexInTree, rhs: SyntaxIndexInTree) -> Bool {
    return lhs.indexInTree < rhs.indexInTree
  }
}

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
public struct SyntaxIdentifier: Hashable, Sendable {
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

  func advancedToFirstChild() -> SyntaxIdentifier {
    let newIndexInTree = self.indexInTree.advancedToFirstChild()
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  static func forRoot(_ raw: RawSyntax) -> SyntaxIdentifier {
    return .init(
      rootId: UInt(bitPattern: raw.pointer.unsafeRawPointer),
      indexInTree: .zero
    )
  }
}
