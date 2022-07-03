//===----------------------------------------------------------------------===//
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

/// Extension to the `Node` type to provide functionality specific to
/// SwiftSyntaxBuilder.
extension Node {
  /// The node's syntax kind as `SyntaxBuildableType`.
  var type: SyntaxBuildableType {
    SyntaxBuildableType(syntaxKind: syntaxKind)
  }

  /// The node's syntax kind as `SyntaxBuildableType`.
  var baseType: SyntaxBuildableType {
    SyntaxBuildableType(syntaxKind: baseKind)
  }

  /// If documentation exists for this node, return it as a single-line string.
  /// Otherwise return an empty string.
  var documentation: String {
    guard let description = description,
          !description.isEmpty else {
      return ""
    }
    if isSyntaxCollection {
      return "`\(syntaxKind)` represents a collection of `\(description)`"
    } else {
      return flattened(indentedDocumentation: description)
    }
  }

  /// Assuming this node is a syntax collection, the type of its elements.
  var collectionElementType: SyntaxBuildableType {
    assert(isSyntaxCollection)
    return SyntaxBuildableType(syntaxKind: collectionElement)
  }

  /// Assuming this node has a single child without a default value, that child.
  var singleNonDefaultedChild: Child {
    let nonDefaultedParams = children.filter(\.type.defaultInitialization.isEmpty)
    assert(nonDefaultedParams.count == 1)
    return nonDefaultedParams[0]
  }

  static func from(type: SyntaxBuildableType) -> Node {
    let baseName = type.baseName
    guard let node = SYNTAX_NODE_MAP[baseName] else {
      fatalError("Base name \(baseName) does not have a syntax node")
    }
    return node
  }
}
