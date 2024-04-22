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

import SyntaxSupport

/// Extension to the ``Node`` type to provide functionality specific to
/// SwiftSyntaxBuilder.
extension Node {
  /// The node's syntax kind as ``SyntaxBuildableType``.
  public var type: SyntaxBuildableType {
    SyntaxBuildableType(kind: .node(kind: kind))
  }

  /// The node's syntax kind as ``SyntaxBuildableType``.
  public var baseType: SyntaxBuildableType {
    if base == .syntaxCollection {
      return SyntaxBuildableType(kind: .node(kind: .syntax))
    } else {
      return SyntaxBuildableType(kind: .node(kind: base))
    }
  }

  public static func from(type: SyntaxBuildableType) -> Node {
    guard case .node(kind: let kind) = type.kind, let node = SYNTAX_NODE_MAP[kind] else {
      fatalError("Base name \(type) does not have a syntax node")
    }
    return node
  }
}

extension LayoutNode {
  /// Assuming this node has a single child without a default value, that child.
  public var singleNonDefaultedChild: Child {
    let nonDefaultedParams = children.filter { $0.defaultInitialization == nil }
    precondition(nonDefaultedParams.count == 1)
    return nonDefaultedParams[0]
  }
}

extension CollectionNode {
  /// Assuming this node is a syntax collection, the type of its elements.
  public var collectionElementType: SyntaxBuildableType {
    if elementChoices.count > 1 {
      return SyntaxBuildableType(kind: .node(kind: .syntax))
    } else {
      return SyntaxBuildableType(kind: .node(kind: elementChoices.first!))
    }
  }
}
