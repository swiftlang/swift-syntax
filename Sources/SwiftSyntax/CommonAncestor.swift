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

/// Returns the bottommost node whose subtree contains both `lhs` and `rhs`.
public func findCommonAncestorOrSelf(_ lhs: Syntax, _ rhs: Syntax) -> Syntax? {
  var lhs: Syntax? = lhs
  var rhs: Syntax? = rhs
  while lhs != nil && rhs != nil {
    if lhs == rhs {
      return lhs
    }
    if let lhsIndex = lhs?.indexInParent.data?.indexInTree, let rhsIndex = rhs?.indexInParent.data?.indexInTree {
      if lhsIndex < rhsIndex {
        rhs = rhs?.parent
      } else {
        lhs = lhs?.parent
      }
    }
  }
  return nil
}

/// Returns the bottommost node whose subtree contains all nodes in `nodes`.
public func findCommonAncestorOrSelf(_ nodes: [Syntax]) -> Syntax? {
  var commonParent = nodes.first
  for node in nodes.dropFirst() {
    if let commonParentUnwrapped = commonParent {
      commonParent = findCommonAncestorOrSelf(commonParentUnwrapped, node)
    } else {
      return nil
    }
  }
  return commonParent
}
