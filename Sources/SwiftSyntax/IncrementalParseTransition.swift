//===------ IncrementalParseTransition.swift - Parse Transition State -----===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Accepts the re-used `Syntax` nodes that `IncrementalParseTransition`
/// determined they should be re-used for a parse invocation.
///
/// The client can use this information to potentially avoid unnecessary work
/// for regions of the source that have not changed.
///
/// This is also used for testing purposes to ensure incremental reparsing
/// worked as expected.
public protocol IncrementalParseReusedNodeDelegate {
  /// Accepts the range and `Syntax` node of skipped source region.
  ///
  /// - Parameters:
  ///   - range: The source region of the currently parsed source.
  ///   - previousNode: The node from the previous tree that is associated with
  ///                   the skipped source region.
  func parserReusedNode(range: ByteSourceRange, previousNode: SyntaxNode)
}

/// An implementation of `IncrementalParseReusedNodeDelegate` that just collects
/// the range and re-used node into an array.
public final class IncrementalParseReusedNodeCollector:
    IncrementalParseReusedNodeDelegate {
  public var rangeAndNodes: [(ByteSourceRange, SyntaxNode)] = []

  public init() {}

  public func parserReusedNode(range: ByteSourceRange, previousNode: SyntaxNode) {
    rangeAndNodes.append((range, previousNode))
  }
}

/// Keeps track of a previously parsed syntax tree and the source edits that
/// occurred since it was created.
public final class IncrementalParseTransition {
  fileprivate let previousTree: SourceFileSyntax
  fileprivate let edits: [SourceEdit]
  fileprivate let reusedDelegate: IncrementalParseReusedNodeDelegate?

  /// - Parameters:
  ///   - previousTree: The previous tree to do lookups on.
  ///   - edits: The edits that have occurred since the last parse that resulted
  ///            in the new source that is about to be parsed. There is a strict
  ///            requirement for the array of edits to:
  ///              1. not be overlapping.
  ///              2. should be in increasing source offset order.
  ///   - reusedNodeDelegate: Optional delegate to accept information about the
  ///                         reused regions and nodes.
  public init(previousTree: SourceFileSyntax,
              edits: [SourceEdit],
              reusedNodeDelegate: IncrementalParseReusedNodeDelegate? = nil) {
    assert(IncrementalParseTransition.isEditArrayValid(edits))
    self.previousTree = previousTree
    self.edits = edits
    self.reusedDelegate = reusedNodeDelegate
  }

  /// Checks the requirements for the edits array to:
  ///   1. not be overlapping.
  ///   2. should be in increasing source offset order.
  public static func isEditArrayValid(_ edits: [SourceEdit]) -> Bool {
    // Not quite sure if we should disallow creating an `IncrementalParseTransition`
    // object without edits but there doesn't seem to be much benefit if we do,
    // and there are 'lit' tests that want to test incremental re-parsing without edits.
    guard !edits.isEmpty else { return true }

    for i in 1..<edits.count {
      let prevEdit = edits[i-1]
      let curEdit = edits[i]
      if curEdit.range.offset < prevEdit.range.endOffset {
        return false
      }
      if curEdit.intersectsRange(prevEdit.range) {
        return false
      }
    }
    return true
  }
}

/// Provides a mechanism for the parser to skip regions of an incrementally
/// updated source that was already parsed during a previous parse invocation.
internal struct IncrementalParseLookup {
  fileprivate let transition: IncrementalParseTransition
  fileprivate var cursor: SyntaxCursor

  init(transition: IncrementalParseTransition) {
    self.transition = transition
    self.cursor = .init(root: transition.previousTree.data.absoluteRaw)
  }

  fileprivate var edits: [SourceEdit] {
    return transition.edits
  }

  fileprivate var reusedDelegate: IncrementalParseReusedNodeDelegate? {
    return transition.reusedDelegate
  }

  /// Does a lookup to see if the current source `offset` should be associated
  /// with a known `Syntax` node and its region skipped during parsing.
  ///
  /// The implementation is responsible for checking whether an incremental edit
  /// has invalidated the previous `Syntax` node.
  ///
  /// - Parameters:
  ///   - offset: The byte offset of the source string that is currently parsed.
  ///   - kind: The `SyntaxKind` that the parser expects at this position.
  /// - Returns: A `SyntaxNode` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  mutating func lookUp(_ newOffset: Int, kind: SyntaxKind) -> SyntaxNode? {
    guard let prevOffset = translateToPreEditOffset(newOffset) else {
      return nil
    }
    let prevPosition = AbsolutePosition(utf8Offset: prevOffset)
    let node = cursorLookup(prevPosition: prevPosition, kind: kind)
    if let delegate = reusedDelegate, let node = node {
      delegate.parserReusedNode(
        range: ByteSourceRange(offset: newOffset, length: node.byteSize),
        previousNode: node)
    }
    return node
  }

  mutating fileprivate func cursorLookup(
    prevPosition: AbsolutePosition, kind: SyntaxKind
  ) -> SyntaxNode? {
    guard !cursor.finished else { return nil }

    while true {
      if nodeAtCursorCanBeReused(prevPosition: prevPosition, kind: kind) {
        return cursor.asSyntaxNode
      }
      guard cursor.advanceToNextNode(at: prevPosition) else { return nil }
    }
  }

  fileprivate func nodeAtCursorCanBeReused(
    prevPosition: AbsolutePosition, kind: SyntaxKind
  ) -> Bool {
    let node = cursor.node
    if node.position != prevPosition {
      return false
    }
    if node.raw.kind != kind {
      return false
    }

    // Fast path check: if parser is past all the edits then any matching node
    // can be re-used.
    if !edits.isEmpty && edits.last!.range.endOffset < node.position.utf8Offset {
      return true
    }

    // Node can also not be reused if an edit has been made in the next token's
    // text, e.g. because `private struct Foo {}` parses as a CodeBlockItem with
    // a StructDecl inside and `private struc Foo {}` parses as two
    // CodeBlockItems one for `private` and one for `struc Foo {}`
    var nextLeafNodeLength: SourceLength = .zero
    if let nextSibling = cursor.nextSibling {
      // Fast path check: if next sibling is before all the edits then we can
      // re-use the node.
      if !edits.isEmpty && edits.first!.range.offset > nextSibling.endPosition.utf8Offset {
        return true
      }
      if let nextToken = nextSibling.raw.firstPresentToken {
        nextLeafNodeLength = nextToken.totalLength - nextToken.trailingTriviaLength
      }
    }
    let nodeAffectRange = ByteSourceRange(offset: node.position.utf8Offset,
      length: (node.raw.totalLength + nextLeafNodeLength).utf8Length)

    for edit in edits {
      // Check if this node or the trivia of the next node has been edited. If
      // it has, we cannot reuse it.
      if edit.range.offset > nodeAffectRange.endOffset {
        // Remaining edits don't affect the node. (Edits are sorted)
        break
      }
      if edit.intersectsOrTouchesRange(nodeAffectRange) {
        return false
      }
    }

    return true
  }

  fileprivate func translateToPreEditOffset(_ postEditOffset: Int) -> Int? {
    var offset = postEditOffset
    for edit in edits {
      if edit.range.offset > offset {
        // Remaining edits doesn't affect the position. (Edits are sorted)
        break
      }
      if edit.range.offset + edit.replacementLength > offset {
        // This is a position inserted by the edit, and thus doesn't exist in
        // the pre-edit version of the file.
        return nil
      }
      offset = offset - edit.replacementLength + edit.range.length
    }
    return offset
  }
}

/// Functions as an iterator that walks the tree looking for nodes with a
/// certain position.
fileprivate struct SyntaxCursor {
  var parents: [AbsoluteRawSyntax]
  var node: AbsoluteRawSyntax
  var finished: Bool

  init(root: AbsoluteRawSyntax) {
    self.node = root
    self.parents = []
    self.finished = false
  }

  var asSyntaxNode: SyntaxNode {
    return SyntaxNode(node: node, parents: ArraySlice(parents))
  }

  /// Returns the next sibling node or the parent's sibling node if this is
  /// the last child. The cursor state is unmodified.
  /// - Returns: False if it run out of nodes to walk to.
  var nextSibling: AbsoluteRawSyntax? {
    var parents = ArraySlice(self.parents)
    var node = self.node
    while !parents.isEmpty {
      if let sibling = node.nextSibling(parent: parents.last!) {
        return sibling
      }
      node = parents.removeLast()
    }

    return nil
  }

  /// Moves to the first child of the current node.
  /// - Returns: False if the node has no children.
  mutating func advanceToFirstChild() -> Bool {
    guard let child = node.firstChild else { return false }
    parents.append(node)
    node = child
    return true
  }

  /// Moves to the next sibling node or the parent's sibling node if this is
  /// the last child.
  /// - Returns: False if it run out of nodes to walk to.
  mutating func advanceToNextSibling() -> Bool {
    while !parents.isEmpty {
      if let sibling = node.nextSibling(parent: parents.last!) {
        node = sibling
        return true
      }
      node = parents.removeLast()
    }

    finished = true
    return false
  }

  /// Moves to the next node in the tree with the provided `position`.
  /// The caller should be calling this with `position`s in ascending order, not
  /// random ones.
  /// - Returns: True if it moved to a new node at the provided position,
  ///   false if it moved to a node past the position or there are no more nodes.
  mutating func advanceToNextNode(at position: AbsolutePosition) -> Bool {
    repeat {
      // if the node is fully before the requested position we can skip its children.
      if node.endPosition > position {
        if advanceToFirstChild() { continue }
      }
      if !advanceToNextSibling() { return false }
    } while node.position < position

    return node.position == position
  }
}
