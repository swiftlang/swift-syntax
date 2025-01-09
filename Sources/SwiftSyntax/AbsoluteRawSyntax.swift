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

struct AbsoluteRawSyntax: Sendable {
  let raw: RawSyntax
  let info: AbsoluteSyntaxInfo

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
    for siblingOpt in parent.raw.layoutView!.children.dropFirst(Int(info.indexInParent + 1)) {
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
}
