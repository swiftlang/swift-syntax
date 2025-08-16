//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Represents an initializer that should be generated.
public struct InitSignature {
  /// The list of children which should be initialized by the initializer.
  /// Includes hidden children.
  public var children: [Child]

  /// The list of children which should be given parameters. Excludes hidden
  /// children.
  public var visibleChildren: LazyFilterSequence<[Child]> {
    return children.lazy.filter { !$0.isHidden }
  }

  /// Does this initializer cover any experimental features?
  public var isExperimental: Bool {
    return visibleChildren.contains { $0.isExperimental && !$0.isUnexpectedNodes }
  }

  /// Does this initializer cover any historical children (vs. just omitting experimental features)?
  public var isHistorical: Bool {
    return visibleChildren.contains { $0.isHistorical && !$0.isUnexpectedNodes }
  }

  /// Create an initializer with an arbitrary array of children.
  public init(children: [Child]) {
    self.children = children
  }

  /// Create an initializer for the (non-deprecated) children of a given layout node.
  public init(_ layoutNode: LayoutNode) {
    self.init(children: layoutNode.children)
  }

  /// Create an initializer for the (non-deprecated) children of a given trait.
  public init(_ trait: Trait) {
    self.init(children: trait.children)
  }
}
