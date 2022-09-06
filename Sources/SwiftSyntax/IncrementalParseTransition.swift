//===------ IncrementalParseTransition.swift - Parse Transition State -----===//
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
  func parserReusedNode(range: ByteSourceRange, previousNode: Syntax)
}

/// An implementation of `IncrementalParseReusedNodeDelegate` that just collects
/// the range and re-used node into an array.
public final class IncrementalParseReusedNodeCollector:
    IncrementalParseReusedNodeDelegate {
  public var rangeAndNodes: [(ByteSourceRange, Syntax)] = []

  public init() {}

  public func parserReusedNode(range: ByteSourceRange, previousNode: Syntax) {
    rangeAndNodes.append((range, previousNode))
  }
}

/// Keeps track of a previously parsed syntax tree and the source edits that
/// occurred since it was created.
public final class IncrementalParseTransition {
  fileprivate let previousTree: SourceFileSyntax
  fileprivate let edits: ConcurrentEdits
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
  @available(*, deprecated, message: "Use the initializer taking 'ConcurrentEdits' instead")
  public convenience init(previousTree: SourceFileSyntax,
                          edits: [SourceEdit],
                          reusedNodeDelegate: IncrementalParseReusedNodeDelegate? = nil) {
    self.init(
      previousTree: previousTree,
      edits: try! ConcurrentEdits(concurrent: edits),
      reusedNodeDelegate: reusedNodeDelegate
    )
  }

  /// - Parameters:
  ///   - previousTree: The previous tree to do lookups on.
  ///   - edits: The edits that have occurred since the last parse that resulted
  ///            in the new source that is about to be parsed.
  ///   - reusedNodeDelegate: Optional delegate to accept information about the
  ///                         reused regions and nodes.
  public init(previousTree: SourceFileSyntax,
              edits: ConcurrentEdits,
              reusedNodeDelegate: IncrementalParseReusedNodeDelegate? = nil) {
    self.previousTree = previousTree
    self.edits = edits
    self.reusedDelegate = reusedNodeDelegate
  }
}

fileprivate extension Sequence where Element: Comparable {
  var isSorted: Bool {
    return zip(self, self.dropFirst()).allSatisfy({ $0.0 < $0.1 })
  }
}

/// Edits that are applied **simultaneously**. That is, the offsets of all edits
/// refer to the original string and are not shifted by previous edits. For
/// example applying
///  - insert 'x' at offset 0
///  - insert 'y' at offset 1
///  - insert 'z' at offset 2
///  to '012345' results in 'x0y1z2345'.
///
/// The raw `edits` of this struct are guaranteed to
///   1. not be overlapping.
///   2. be in increasing source offset order.
public struct ConcurrentEdits {
  enum ConcurrentEditsError: Error, CustomStringConvertible {
    case editsNotConcurrent

    var description: String {
      switch self {
      case .editsNotConcurrent:
        return "Edits passed to ConcurrentEdits(concurrent:) does not satisfy the requirements posed by ConcurrentEdits"
      }
    }
  }

  /// The raw concurrent edits. Are guaranteed to satisfy the requirements
  /// stated above.
  public let edits: [SourceEdit]

  /// Initialize this struct from edits that are already in a concurrent form
  /// and are guaranteed to satisfy the requirements posed above.
  public init(concurrent: [SourceEdit]) throws {
    if !Self.isValidConcurrentEditArray(concurrent) {
      throw ConcurrentEditsError.editsNotConcurrent
    }
    self.edits = concurrent
  }

  /// Create concurrent from a set of sequential edits. Sequential edits are
  /// applied one after the other. Applying the first edit results in an
  /// intermediate string to which the second edit is applied etc. For example
  /// applying
  ///  - insert 'x' at offset 0
  ///  - insert 'y' at offset 1
  ///  - insert 'z' at offset 2
  ///  to '012345' results in 'xyz012345'.

  public init(fromSequential sequentialEdits: [SourceEdit]) {
    do {
      try self.init(concurrent: Self.translateSequentialEditsToConcurrentEdits(sequentialEdits))
    } catch {
      fatalError("ConcurrentEdits created by translateSequentialEditsToConcurrentEdits do not satisfy ConcurrentEdits requirements")
    }
  }

  /// Construct a concurrent edits struct from a single edit. For a single edit,
  /// there is no differentiation between being it being applied concurrently
  /// or sequentially.
  public init(_ single: SourceEdit) {
    do {
      try self.init(concurrent: [single])
    } catch {
      fatalError("A single edit doesn't satisfy the ConcurrentEdits requirements?")
    }
  }

  private static func translateSequentialEditsToConcurrentEdits(
    _ edits: [SourceEdit]
  ) -> [SourceEdit] {
    var concurrentEdits: [SourceEdit] = []
    for editToAdd in edits {
      var editToAdd = editToAdd
      var editIndiciesMergedWithNewEdit: [Int] = []
      for (index, existingEdit) in concurrentEdits.enumerated() {
        if existingEdit.replacementRange.intersectsOrTouches(editToAdd.range) {
          let intersectionLength =
            existingEdit.replacementRange.intersected(editToAdd.range).length
          editToAdd = SourceEdit(
            offset: Swift.min(existingEdit.offset, editToAdd.offset),
            length: existingEdit.length + editToAdd.length - intersectionLength,
            replacementLength: existingEdit.replacementLength +
              editToAdd.replacementLength - intersectionLength
          )
          editIndiciesMergedWithNewEdit.append(index)
        } else if existingEdit.offset < editToAdd.endOffset {
          editToAdd = SourceEdit(
            offset: editToAdd.offset - existingEdit.replacementLength +
              existingEdit.length,
            length: editToAdd.length,
            replacementLength: editToAdd.replacementLength
          )
        }
      }
      assert(editIndiciesMergedWithNewEdit.isSorted)
      for indexToRemove in editIndiciesMergedWithNewEdit.reversed() {
        concurrentEdits.remove(at: indexToRemove)
      }
      let insertPos = concurrentEdits.firstIndex(where: { edit in
        editToAdd.endOffset <= edit.offset
      }) ?? concurrentEdits.count
      concurrentEdits.insert(editToAdd, at: insertPos)
      assert(ConcurrentEdits.isValidConcurrentEditArray(concurrentEdits))
    }
    return concurrentEdits
  }

  private static func isValidConcurrentEditArray(_ edits: [SourceEdit]) -> Bool {
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

  /// **Public for testing purposes only**
  public static func _isValidConcurrentEditArray(_ edits: [SourceEdit]) -> Bool {
    return isValidConcurrentEditArray(edits)
  }
}

/// Provides a mechanism for the parser to skip regions of an incrementally
/// updated source that was already parsed during a previous parse invocation.
public struct IncrementalParseLookup {
  fileprivate let transition: IncrementalParseTransition
  fileprivate var cursor: SyntaxCursor

  public init(transition: IncrementalParseTransition) {
    self.transition = transition
    self.cursor = .init(root: transition.previousTree.data)
  }

  fileprivate var edits: ConcurrentEdits {
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
  ///   - kind: The `CSyntaxKind` that the parser expects at this position.
  /// - Returns: A `Syntax` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  @_spi(RawSyntax)
  public mutating func lookUp(_ newOffset: Int, kind: SyntaxKind) -> Syntax? {
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
  ) -> Syntax? {
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
    if !edits.edits.isEmpty && edits.edits.last!.range.endOffset < node.position.utf8Offset {
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
      if !edits.edits.isEmpty && edits.edits.first!.range.offset > nextSibling.endPosition.utf8Offset {
        return true
      }
      if let nextToken = nextSibling.raw.firstToken(viewMode: .sourceAccurate) {
        nextLeafNodeLength = nextToken.raw.totalLength - nextToken.trailingTriviaLength
      }
    }
    let nodeAffectRange = ByteSourceRange(offset: node.position.utf8Offset,
      length: (node.raw.totalLength + nextLeafNodeLength).utf8Length)

    for edit in edits.edits {
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
    for edit in edits.edits {
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
  var node: SyntaxData
  var finished: Bool
  let viewMode = SyntaxTreeViewMode.sourceAccurate

  init(root: SyntaxData) {
    self.node = root
    self.finished = false
  }

  var asSyntaxNode: Syntax {
    return Syntax(node)
  }

  /// Returns the next sibling node or the parent's sibling node if this is
  /// the last child. The cursor state is unmodified.
  /// - Returns: `nil` if it run out of nodes to walk to.
  var nextSibling: SyntaxData? {
    var node = self.node
    while let parent = node.parent {
      if let sibling = node.absoluteRaw.nextSibling(parent: parent.absoluteRaw, viewMode: viewMode) {
        return SyntaxData(sibling, parent: Syntax(parent))
      }
      node = parent
    }
    return nil
  }

  /// Moves to the first child of the current node.
  /// - Returns: False if the node has no children.
  mutating func advanceToFirstChild() -> Bool {
    guard let child = node.absoluteRaw.firstChild(viewMode: viewMode) else { return false }
    node = SyntaxData(child, parent: Syntax(node))
    return true
  }

  /// Moves to the next sibling node or the parent's sibling node if this is
  /// the last child.
  /// - Returns: False if it run out of nodes to walk to.
  mutating func advanceToNextSibling() -> Bool {
    guard let next = nextSibling else {
      finished = true
      return false
    }

    self.node = next
    return true
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
