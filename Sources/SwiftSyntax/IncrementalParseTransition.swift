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

/// Provides a mechanism for the parser to skip regions of an incrementally
/// updated source that was already parsed during a previous parse invocation.
public struct IncrementalParseLookup {
  fileprivate let transition: IncrementalParseTransition
  fileprivate var cursor: Syntax?

  public init(transition: IncrementalParseTransition) {
    self.transition = transition
    self.cursor = transition.previousTree.syntax
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
  /// - Returns: A `SyntaxNode` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  public mutating func lookUp(_ newOffset: Int, kind: SyntaxKind) -> Syntax? {
    guard let prevOffset = translateToPreEditOffset(newOffset) else {
      return nil
    }
    let prevPosition = AbsolutePosition(utf8Offset: prevOffset)

    let node = cursorLookup(prevPosition: prevPosition, kind: kind)
    if let delegate = reusedDelegate, let node = node {
      delegate.parserReusedNode(
        range: ByteSourceRange(offset: newOffset, length: node.byteLength),
        previousNode: node)
    }
    return node
  }

  mutating fileprivate func cursorLookup(
    prevPosition: AbsolutePosition, kind: SyntaxKind
  ) -> Syntax? {
    while let node = cursor, node.position <= prevPosition {
      // If the current node reusable, return it.
      if node.position == prevPosition && isNodeCanBeReused(node, kind: kind){
        return node
      }
      cursor = node.findNext(where: { _ in true })
    }
    return nil
  }

  fileprivate func isNodeCanBeReused(_ node: Syntax, kind: SyntaxKind) -> Bool {
    if node.syntaxKind != kind {
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
    var nextLeafNodeLength: Int = 0

    if let nextSibling = node.nextSibling {
      // Fast path check: if next sibling is before all the edits then we can
      // re-use the node.
      if !edits.edits.isEmpty && edits.edits.first!.range.offset > nextSibling.endPosition.utf8Offset {
        return true
      }
      if let nextToken = nextSibling.firstToken {
        nextLeafNodeLength = nextToken.byteLength - nextToken.trailingTriviaLength
      }
    }
    let nodeAffectRange = ByteSourceRange(offset: node.byteOffset,
      length: (node.byteLength + nextLeafNodeLength))

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

