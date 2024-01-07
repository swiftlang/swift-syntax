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

struct AbsoluteSyntaxPosition: Sendable {
  /// The UTF-8 offset of the syntax node in the source file
  let offset: UInt32
  let indexInParent: UInt32

  func advancedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxPosition {
    let newOffset = self.offset + UInt32(truncatingIfNeeded: raw?.totalLength.utf8Length ?? 0)
    let newIndexInParent = self.indexInParent + 1
    return .init(offset: newOffset, indexInParent: newIndexInParent)
  }

  func advancedToFirstChild() -> AbsoluteSyntaxPosition {
    return .init(offset: self.offset, indexInParent: 0)
  }

  static var forRoot: AbsoluteSyntaxPosition {
    return .init(offset: 0, indexInParent: 0)
  }
}

/// `AbsoluteSyntaxInfo` represents the information that relates a `RawSyntax`
/// to a source file tree, like its absolute source offset.
struct AbsoluteSyntaxInfo: Sendable {
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

  func advancedToFirstChild() -> AbsoluteSyntaxInfo {
    let newPosition = position.advancedToFirstChild()
    let newNodeId = nodeId.advancedToFirstChild()
    return .init(position: newPosition, nodeId: newNodeId)
  }

  static func forRoot(_ raw: RawSyntax) -> AbsoluteSyntaxInfo {
    return .init(position: .forRoot, nodeId: .forRoot(raw))
  }
}
