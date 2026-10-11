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

/// `AbsoluteSyntaxInfo` represents the information that relates a `RawSyntax`
/// to a source file tree, like its absolute source offset.
struct AbsoluteSyntaxInfo: Sendable {
  /// The UTF-8 offset at which the syntax node’s leading trivia start in the source file.
  let offset: UInt32

  /// Index in parent's layout. Note that this counts `nil` children.
  let layoutIndexInParent: UInt32

  /// Index of the node when traversing the syntax tree using a depth-first traversal.
  /// This skips `nil` children in the parent's layout.
  let indexInTree: UInt32

  /// - Important: `@inline(__always)` because this runs once per slot of every node a
  ///   client visits, and it is small enough that a caller of any size should take it.
  ///   Left to the inliner it is dropped as soon as the caller grows, which cost 3%
  ///   of a tree walk once.
  @inline(__always)
  func advancedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxInfo {
    if let raw {
      // '&+' cannot overflow: a node's length and node count are sums `makeLayout`
      // checks as it builds them, in the same width.
      return AbsoluteSyntaxInfo(
        offset: offset &+ raw.byteLength,
        layoutIndexInParent: layoutIndexInParent &+ 1,
        indexInTree: indexInTree &+ raw.totalNodes
      )
    } else {
      return AbsoluteSyntaxInfo(
        offset: offset,
        layoutIndexInParent: layoutIndexInParent &+ 1,
        indexInTree: indexInTree
      )
    }
  }

  func advancedToFirstChild() -> AbsoluteSyntaxInfo {
    return AbsoluteSyntaxInfo(
      offset: offset,
      layoutIndexInParent: 0,
      indexInTree: indexInTree &+ 1
    )
  }

  static func forRoot(_ raw: RawSyntax) -> AbsoluteSyntaxInfo {
    return AbsoluteSyntaxInfo(
      offset: 0,
      layoutIndexInParent: 0,
      indexInTree: 0
    )
  }
}
