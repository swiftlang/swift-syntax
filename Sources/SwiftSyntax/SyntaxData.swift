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

struct AbsoluteSyntaxPosition {
  /// The UTF-8 offset of the syntax node in the source file
  let offset: UInt32
  let indexInParent: UInt32

  func advancedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxPosition {
    let newOffset = self.offset + UInt32(truncatingIfNeeded: raw?.totalLength.utf8Length ?? 0)
    let newIndexInParent = self.indexInParent + 1
    return .init(offset: newOffset, indexInParent: newIndexInParent)
  }

  func reversedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxPosition {
    let newOffset = self.offset - UInt32(truncatingIfNeeded: raw?.totalLength.utf8Length ?? 0)
    let newIndexInParent = self.indexInParent - 1
    return .init(offset: newOffset, indexInParent: newIndexInParent)
  }

  func advancedToFirstChild() -> AbsoluteSyntaxPosition {
    return .init(offset: self.offset, indexInParent: 0)
  }

  static var forRoot: AbsoluteSyntaxPosition {
    return .init(offset: 0, indexInParent: 0)
  }
}

/// AbsoluteSyntaxInfo represents the information that relates a RawSyntax to a
/// source file tree, like its absolute source offset.
struct AbsoluteSyntaxInfo {
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

  func reversedBySibling(_ raw: RawSyntax?) -> AbsoluteSyntaxInfo {
    let newPosition = position.reversedBySibling(raw)
    let newNodeId = nodeId.reversedBySibling(raw)
    return .init(position: newPosition, nodeId: newNodeId)
  }

  func advancedToFirstChild() -> AbsoluteSyntaxInfo {
    let newPosition = position.advancedToFirstChild()
    let newNodeId = nodeId.advancedToFirstChild()
    return .init(position: newPosition, nodeId: newNodeId)
  }

  static var forRoot: AbsoluteSyntaxInfo {
    return .init(position: .forRoot, nodeId: .newRoot())
  }
}

/// Represents a unique value for a node within its own tree.
struct SyntaxIndexInTree: Hashable {
  let indexInTree: UInt32

  static var zero: SyntaxIndexInTree = SyntaxIndexInTree(indexInTree: 0)

  /// Assuming that this index points to the start of `Raw`, so that it points
  /// to the next sibling of `Raw`.
  func advancedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree +
                         UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  /// Assuming that this index points to the next sibling of `Raw`, reverse it
  /// so that it points to the start of `Raw`.
  func reversedBy(_ raw: RawSyntax?) -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree -
                         UInt32(truncatingIfNeeded: raw?.totalNodes ?? 0)
    return .init(indexInTree: newIndexInTree)
  }

  func advancedToFirstChild() -> SyntaxIndexInTree {
    let newIndexInTree = self.indexInTree + 1
    return .init(indexInTree: newIndexInTree)
  }

  init(indexInTree: UInt32) {
    self.indexInTree = indexInTree
  }
}

/// Provides a stable and unique identity for `Syntax` nodes.
public struct SyntaxIdentifier: Hashable {
  /// Unique value for each root node created.
  let rootId: UInt32
  /// Unique value for a node within its own tree.
  let indexInTree: SyntaxIndexInTree

  func advancedBySibling(_ raw: RawSyntax?) -> SyntaxIdentifier {
    let newIndexInTree = indexInTree.advancedBy(raw)
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  func reversedBySibling(_ raw: RawSyntax?) -> SyntaxIdentifier {
    let newIndexInTree = self.indexInTree.reversedBy(raw)
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  func advancedToFirstChild() -> SyntaxIdentifier {
    let newIndexInTree = self.indexInTree.advancedToFirstChild()
    return .init(rootId: self.rootId, indexInTree: newIndexInTree)
  }

  static func newRoot() -> SyntaxIdentifier {
    return .init(rootId: UInt32(truncatingIfNeeded: AtomicCounter.next()),
                 indexInTree: .zero)
  }
}

struct AbsoluteRawSyntax {
  let raw: RawSyntax
  let info: AbsoluteSyntaxInfo

  /// The position of the start of this node's leading trivia
  var position: AbsolutePosition {
    return AbsolutePosition(utf8Offset: Int(info.offset))
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    return position + raw.totalLength
  }

  /// Returns first `present` child.
  var firstChild: AbsoluteRawSyntax? {
    var curInfo = info.advancedToFirstChild()
    for i in 0..<raw.numberOfChildren {
      let childOpt = raw.child(at: i)
      if let child = childOpt, child.isPresent {
        return AbsoluteRawSyntax(raw: child, info: curInfo)
      }
      curInfo = curInfo.advancedBySibling(childOpt)
    }
    return nil
  }

  /// Returns next `present` sibling.
  func nextSibling(parent: AbsoluteRawSyntax) -> AbsoluteRawSyntax? {
    var curInfo = info.advancedBySibling(raw)
    for i in Int(info.indexInParent+1) ..< parent.raw.numberOfChildren {
      let siblingOpt = parent.raw.child(at: i)
      if let sibling = siblingOpt, sibling.isPresent {
        return AbsoluteRawSyntax(raw: sibling, info: curInfo)
      }
      curInfo = curInfo.advancedBySibling(siblingOpt)
    }
    return nil
  }

  func replacingSelf(_ newRaw: RawSyntax, newRootId: UInt32) -> AbsoluteRawSyntax {
    let nodeId = SyntaxIdentifier(rootId: newRootId, indexInTree: info.nodeId.indexInTree)
    let newInfo = AbsoluteSyntaxInfo(position: info.position, nodeId: nodeId)
    return .init(raw: newRaw, info: newInfo)
  }

  static func forRoot(_ raw: RawSyntax) -> AbsoluteRawSyntax {
    return .init(raw: raw, info: .forRoot)
  }
}

/// Indirect wrapper for a `Syntax` node to avoid cyclic inclusion of the 
/// `Syntax` struct in `SyntaxData`
class SyntaxBox: CustomStringConvertible, 
    CustomDebugStringConvertible, TextOutputStreamable {
  let value: Syntax

  init(_ value: Syntax) {
    self.value = value
  }

  // SyntaxBox should be transparent in all descriptions

  /// A source-accurate description of this node.
  var description: String {
    return value.description
  }

  /// Returns a description used by dump.
  var debugDescription: String {
    return value.debugDescription
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    return value.write(to: &target)
  }
}

/// SyntaxData is the underlying storage for each Syntax node.
///
/// SyntaxData is an implementation detail, and should not be exposed to clients
/// of SwiftSyntax.
struct SyntaxData {
  private let parentBox: SyntaxBox?
  var parent: Syntax? {
    return parentBox?.value
  }
  let absoluteRaw: AbsoluteRawSyntax

  var raw: RawSyntax { return absoluteRaw.raw }

  var indexInParent: Int { return Int(absoluteRaw.info.indexInParent) }

  var nodeId: SyntaxIdentifier { return absoluteRaw.info.nodeId }

  /// The position of the start of this node's leading trivia
  var position: AbsolutePosition {
    return absoluteRaw.position
  }

  /// The position of the start of this node's content, skipping its trivia
  var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return position + raw.leadingTriviaLength
  }

  /// The end position of this node's content, before any trailing trivia.
  var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return endPosition - raw.trailingTriviaLength
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    return absoluteRaw.endPosition
  }

  /// Creates a `SyntaxData` with the provided raw syntax and parent.
  /// - Parameters:
  ///   - absoluteRaw: The underlying `AbsoluteRawSyntax` of this node.
  ///   - parent: The parent of this node, or `nil` if this node is the root.
  init(_ absoluteRaw: AbsoluteRawSyntax, parent: Syntax?) {
    self.absoluteRaw = absoluteRaw
    self.parentBox = parent.map(SyntaxBox.init)
  }

  /// Creates a `SyntaxData` with the provided raw syntax and parent.
  /// - Parameters:
  ///   - absoluteRaw: The underlying `AbsoluteRawSyntax` of this node.
  ///   - parentBox: The boxed parent of this node, or `nil` if this node is the 
  ///                root.
  init(_ absoluteRaw: AbsoluteRawSyntax, parentBox: SyntaxBox?) {
    self.absoluteRaw = absoluteRaw
    self.parentBox = parentBox
  }

  /// Creates a `SyntaxData` for a root raw node.
  static func forRoot(_ raw: RawSyntax) -> SyntaxData {
    return SyntaxData(.forRoot(raw), parent: nil)
  }

  /// Returns the child data at the provided index in this data's layout.
  /// - Note: This has O(n) performance, prefer using a proper Sequence type
  ///         if applicable, instead of this.
  /// - Note: This function traps if the index is out of the bounds of the
  ///         data's layout.
  ///
  /// - Parameter index: The index to create and cache.
  /// - Parameter parent: The parent to associate the child with. This is
  ///             normally the Syntax node that this `SyntaxData` belongs to.
  /// - Returns: The child's data at the provided index.
  func child(at index: Int, parent: Syntax) -> SyntaxData? {
    if !raw.hasChild(at: index) { return nil }
    var iter = RawSyntaxChildren(absoluteRaw).makeIterator()
    for _ in 0..<index { _ = iter.next() }
    let (raw, info) = iter.next()!
    return SyntaxData(AbsoluteRawSyntax(raw: raw!, info: info), parent: parent)
  }

  /// Returns the child data at the provided cursor in this data's layout.
  /// - Note: This has O(n) performance, prefer using a proper Sequence type
  ///         if applicable, instead of this.
  /// - Note: This function traps if the cursor is out of the bounds of the
  ///         data's layout.
  ///
  /// - Parameter cursor: The cursor to create and cache.
  /// - Parameter parent: The parent to associate the child with. This is
  ///             normally the Syntax node that this `SyntaxData` belongs to.
  /// - Returns: The child's data at the provided cursor.
  func child<CursorType: RawRepresentable>(
    at cursor: CursorType, parent: Syntax) -> SyntaxData?
    where CursorType.RawValue == Int {
    return child(at: cursor.rawValue, parent: parent)
  }

  /// Creates a copy of `self` and recursively creates `SyntaxData` nodes up to
  /// the root.
  /// - parameter newRaw: The new RawSyntax that will back the new `Data`
  /// - returns: A tuple of both the new root node and the new data with the raw
  ///            layout replaced.
  func replacingSelf(
    _ newRaw: RawSyntax) -> SyntaxData {
    // If we have a parent already, then ask our current parent to copy itself
    // recursively up to the root.
    if let parent = parent {
      let parentData = parent.data.replacingChild(newRaw, at: indexInParent)
      let newParent = Syntax(parentData)
      return SyntaxData(absoluteRaw.replacingSelf(newRaw, newRootId: parentData.nodeId.rootId), parent: newParent)
    } else {
      // Otherwise, we're already the root, so return the new root data.
      return .forRoot(newRaw)
    }
  }

  /// Creates a copy of `self` with the child at the provided index replaced
  /// with a new SyntaxData containing the raw syntax provided.
  ///
  /// - Parameters:
  ///   - child: The raw syntax for the new child to replace.
  ///   - index: The index pointing to where in the raw layout to place this
  ///            child.
  /// - Returns: The new root node created by this operation, and the new child
  ///            syntax data.
  /// - SeeAlso: replacingSelf(_:)
  func replacingChild(_ child: RawSyntax?, at index: Int) -> SyntaxData {
    let newRaw = raw.replacingChild(index, with: child)
    return replacingSelf(newRaw)
  }

  /// Creates a copy of `self` with the child at the provided cursor replaced
  /// with a new SyntaxData containing the raw syntax provided.
  ///
  /// - Parameters:
  ///   - child: The raw syntax for the new child to replace.
  ///   - cursor: A cursor that points to the index of the child you wish to
  ///             replace
  /// - Returns: The new root node created by this operation, and the new child
  ///            syntax data.
  /// - SeeAlso: replacingSelf(_:)
  func replacingChild<CursorType: RawRepresentable>(_ child: RawSyntax?,
    at cursor: CursorType) -> SyntaxData
    where CursorType.RawValue == Int {
    return replacingChild(child, at: cursor.rawValue)
  }

  func withLeadingTrivia(_ leadingTrivia: Trivia) -> SyntaxData {
    if let raw = raw.withLeadingTrivia(leadingTrivia) {
      return replacingSelf(raw)
    } else {
      return self
    }
  }

  func withTrailingTrivia(_ trailingTrivia: Trivia) -> SyntaxData {
    if let raw = raw.withTrailingTrivia(trailingTrivia) {
      return replacingSelf(raw)
    } else {
      return self
    }
  }
}
