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

#if swift(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

extension Parser {
  mutating func loadCurrentSyntaxNodeFromCache(for kind: SyntaxKind) -> Syntax? {
    guard parseLookup != nil else {
      return nil
    }

    let currentOffset = self.lexemes.offsetToStart(self.currentToken)
    if let node = parseLookup!.lookUp(currentOffset, kind: kind) {
      self.lexemes.advance(by: node.totalLength.utf8Length, currentToken: &self.currentToken)
      return node
    }

    return nil
  }

  mutating func registerNodeForIncrementalParse(node: RawSyntax, startToken: Lexer.Lexeme) {
    lookaheadRanges.registerNodeForIncrementalParse(
      node: node,
      lookaheadLength: lexemes.lookaheadTracker.pointee.furthestOffset - self.lexemes.offsetToStart(startToken)
    )
  }
}

/// Accepts a re-used `Syntax` node that `IncrementalParseTransition`
/// determined they should be re-used for a parse invocation.
///
/// The client can use this information to potentially avoid unnecessary work
/// for regions of the source that have not changed.
///
/// This is also used for testing purposes to ensure incremental reparsing
/// worked as expected.
public typealias ReusedNodeCallback = (_ node: Syntax) -> ()

/// Keeps track of a previously parsed syntax tree and the source edits that
/// occurred since it was created.
public final class IncrementalParseTransition {
  fileprivate let previousIncrementalParseResult: IncrementalParseResult
  fileprivate let edits: ConcurrentEdits
  fileprivate let reusedNodeCallback: ReusedNodeCallback?

  /// - Parameters:
  ///   - previousTree: The previous tree to do lookups on.
  ///   - edits: The edits that have occurred since the last parse that resulted
  ///            in the new source that is about to be parsed.
  ///   - reusedNodeCallback: Optional closure to accept information about the re-used node. For each node that gets re-used `reusedNodeCallback` is called.
  @available(*, deprecated, message: "Use initializer taking `IncrementalParseResult` instead")
  public init(
    previousTree: SourceFileSyntax,
    edits: ConcurrentEdits,
    lookaheadRanges: LookaheadRanges,
    reusedNodeCallback: ReusedNodeCallback? = nil
  ) {
    self.previousIncrementalParseResult = IncrementalParseResult(tree: previousTree, lookaheadRanges: lookaheadRanges)
    self.edits = edits
    self.reusedNodeCallback = reusedNodeCallback
  }

  /// - Parameters:
  ///   - previousIncrementalParseResult: The previous incremental parse result to do lookups on.
  ///   - edits: The edits that have occurred since the last parse that resulted
  ///            in the new source that is about to be parsed.
  ///   - reusedNodeCallback: Optional closure to accept information about the re-used node. For each node that gets re-used `reusedNodeCallback` is called.
  public init(
    previousIncrementalParseResult: IncrementalParseResult,
    edits: ConcurrentEdits,
    reusedNodeCallback: ReusedNodeCallback? = nil
  ) {
    self.previousIncrementalParseResult = previousIncrementalParseResult
    self.edits = edits
    self.reusedNodeCallback = reusedNodeCallback
  }
}

/// Provides a mechanism for the parser to skip regions of an incrementally
/// updated source that was already parsed during a previous parse invocation.
struct IncrementalParseLookup {
  fileprivate let transition: IncrementalParseTransition
  fileprivate var cursor: SyntaxCursor

  /// Create a new ``IncrementalParseLookup`` that can look nodes up based on the
  /// given ``IncrementalParseTransition``.
  public init(transition: IncrementalParseTransition) {
    self.transition = transition
    self.cursor = .init(root: Syntax(transition.previousIncrementalParseResult.tree))
  }

  fileprivate var edits: ConcurrentEdits {
    return transition.edits
  }

  fileprivate var reusedCallback: ReusedNodeCallback? {
    return transition.reusedNodeCallback
  }

  /// Does a lookup to see if the current source `offset` should be associated
  /// with a known ``Syntax`` node and its region skipped during parsing.
  ///
  /// The implementation is responsible for checking whether an incremental edit
  /// has invalidated the previous ``Syntax`` node.
  ///
  /// - Parameters:
  ///   - offset: The byte offset of the source string that is currently parsed.
  ///   - kind: The `CSyntaxKind` that the parser expects at this position.
  /// - Returns: A ``Syntax`` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  fileprivate mutating func lookUp(_ newOffset: Int, kind: SyntaxKind) -> Syntax? {
    guard let prevOffset = translateToPreEditOffset(newOffset) else {
      return nil
    }
    let prevPosition = AbsolutePosition(utf8Offset: prevOffset)
    let node = cursorLookup(prevPosition: prevPosition, kind: kind)
    if let node {
      reusedCallback?(node)
    }
    return node
  }

  fileprivate mutating func cursorLookup(
    prevPosition: AbsolutePosition,
    kind: SyntaxKind
  ) -> Syntax? {
    guard !cursor.finished else { return nil }

    while true {
      if nodeAtCursorCanBeReused(prevPosition: prevPosition, kind: kind) {
        return cursor.node
      }
      guard cursor.advanceToNextNode(at: prevPosition) else { return nil }
    }
  }

  fileprivate func nodeAtCursorCanBeReused(
    prevPosition: AbsolutePosition,
    kind: SyntaxKind
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

    guard let nodeAffectRangeLength = transition.previousIncrementalParseResult.lookaheadRanges.lookaheadRanges[node.raw.id] else {
      return false
    }

    let nodeAffectRange = ByteSourceRange(
      offset: node.position.utf8Offset,
      length: nodeAffectRangeLength
    )

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
  var node: Syntax
  var finished: Bool
  let viewMode = SyntaxTreeViewMode.sourceAccurate

  init(root: Syntax) {
    self.node = root
    self.finished = false
  }

  /// Returns the next sibling node or the parent's sibling node if this is
  /// the last child. The cursor state is unmodified.
  /// - Returns: `nil` if it run out of nodes to walk to.
  var nextSibling: Syntax? {
    var node = self.node
    while let parent = node.parent {
      let children = parent.children(viewMode: viewMode)
      if let nodeIndex = children.index(of: node),
        children.index(after: nodeIndex) != children.endIndex
      {
        return children[children.index(after: nodeIndex)]
      }
      node = parent
    }
    return nil
  }

  /// Moves to the first child of the current node.
  /// - Returns: False if the node has no children.
  mutating func advanceToFirstChild() -> Bool {
    guard let child = node.children(viewMode: viewMode).first else { return false }
    node = child
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
public struct ConcurrentEdits: Sendable {
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
  public let edits: [IncrementalEdit]

  /// Initialize this struct from edits that are already in a concurrent form
  /// and are guaranteed to satisfy the requirements posed above.
  public init(concurrent: [IncrementalEdit]) throws {
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

  public init(fromSequential sequentialEdits: [IncrementalEdit]) {
    do {
      try self.init(concurrent: Self.translateSequentialEditsToConcurrentEdits(sequentialEdits))
    } catch {
      fatalError("ConcurrentEdits created by translateSequentialEditsToConcurrentEdits do not satisfy ConcurrentEdits requirements")
    }
  }

  /// Construct a concurrent edits struct from a single edit. For a single edit,
  /// there is no differentiation between being it being applied concurrently
  /// or sequentially.
  public init(_ single: IncrementalEdit) {
    do {
      try self.init(concurrent: [single])
    } catch {
      fatalError("A single edit doesn't satisfy the ConcurrentEdits requirements?")
    }
  }

  private static func translateSequentialEditsToConcurrentEdits(
    _ edits: [IncrementalEdit]
  ) -> [IncrementalEdit] {
    var concurrentEdits: [IncrementalEdit] = []
    for editToAdd in edits {
      var editToAdd = editToAdd
      var editIndicesMergedWithNewEdit: [Int] = []
      for (index, existingEdit) in concurrentEdits.enumerated() {
        if existingEdit.replacementRange.intersectsOrTouches(editToAdd.range) {
          let intersectionLength =
            existingEdit.replacementRange.intersected(editToAdd.range).length
          let replacement: [UInt8]
          replacement =
            existingEdit.replacement.prefix(max(0, editToAdd.offset - existingEdit.replacementRange.offset))
            + editToAdd.replacement
            + existingEdit.replacement.suffix(max(0, existingEdit.replacementRange.endOffset - editToAdd.endOffset))
          editToAdd = IncrementalEdit(
            offset: Swift.min(existingEdit.offset, editToAdd.offset),
            length: existingEdit.length + editToAdd.length - intersectionLength,
            replacement: replacement
          )
          editIndicesMergedWithNewEdit.append(index)
        } else if existingEdit.offset < editToAdd.endOffset {
          editToAdd = IncrementalEdit(
            offset: editToAdd.offset - existingEdit.replacementLength + existingEdit.length,
            length: editToAdd.length,
            replacement: editToAdd.replacement
          )
        }
      }
      precondition(editIndicesMergedWithNewEdit.isSorted)
      for indexToRemove in editIndicesMergedWithNewEdit.reversed() {
        concurrentEdits.remove(at: indexToRemove)
      }
      let insertPos =
        concurrentEdits.firstIndex(where: { edit in
          editToAdd.endOffset <= edit.offset
        }) ?? concurrentEdits.count
      concurrentEdits.insert(editToAdd, at: insertPos)
      precondition(ConcurrentEdits.isValidConcurrentEditArray(concurrentEdits))
    }
    return concurrentEdits
  }

  private static func isValidConcurrentEditArray(_ edits: [IncrementalEdit]) -> Bool {
    // Not quite sure if we should disallow creating an `IncrementalParseTransition`
    // object without edits but there doesn't seem to be much benefit if we do,
    // and there are 'lit' tests that want to test incremental re-parsing without edits.
    guard !edits.isEmpty else { return true }

    for i in 1..<edits.count {
      let prevEdit = edits[i - 1]
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
  public static func _isValidConcurrentEditArray(_ edits: [IncrementalEdit]) -> Bool {
    return isValidConcurrentEditArray(edits)
  }
}

fileprivate extension Sequence where Element: Comparable {
  var isSorted: Bool {
    return zip(self, self.dropFirst()).allSatisfy({ $0.0 < $0.1 })
  }
}
