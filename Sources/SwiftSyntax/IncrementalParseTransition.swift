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
/// occurred since it was created and provides a mechanism for the parser to
/// skip regions of an incrementally updated source that was already parsed
/// during a previous parse invocation.
public final class IncrementalParseTransition {
  // The implementation is based on `SyntaxParsingCache` from the swift
  // repository.

  private let previousTree: SourceFileSyntax
  private let edits: [SourceEdit]
  private let reusedDelegate: IncrementalParseReusedNodeDelegate?

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

  /// Does a lookup to see if the current source `offset` should be associated
  /// with a known `Syntax` node and its region skipped during parsing.
  ///
  /// The implementation is responsible for checking whether an incremental edit
  /// has invalidated the previous `Syntax` node.
  ///
  /// - Parameters:
  ///   - offset: The byte offset of the source string that is currently parsed.
  ///   - kind: The `SyntaxKind` that the parser expects at this position.
  /// - Returns: A `Syntax` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  func lookUp(_ newOffset: Int, kind: SyntaxKind) -> _SyntaxBase? {
    guard let prevOffset = translateToPreEditOffset(newOffset) else {
      return nil
    }
    let (nodeOffset, node) = lookUpFrom(previousTree, nodeOffset: 0,
                                        prevOffset: prevOffset, kind: kind)
    if let delegate = reusedDelegate, let node = node {
      delegate.parserReusedNode(
        range: ByteSourceRange(offset: nodeOffset, length: node.byteSize),
        previousNode: node)
    }
    return node
  }

  fileprivate func lookUpFrom(_ node: _SyntaxBase, nodeOffset: Int, prevOffset: Int,
                              kind: SyntaxKind) -> (Int, _SyntaxBase?) {
    if nodeCanBeReused(node, nodeOffset: nodeOffset, prevOffset: prevOffset,
                       kind: kind) {
      return (nodeOffset, node)
    }

    // Compute the child's position on the fly
    var childOffset = nodeOffset
    for child in node.children {
      if child.isMissing {
        continue
      }
      let childEnd = childOffset + child.byteSize
      if childOffset <= prevOffset && prevOffset < childEnd {
        return lookUpFrom(child, nodeOffset: childOffset,
                          prevOffset: prevOffset, kind: kind)
      }
      // The next child starts where the previous child ended
      childOffset = childEnd
    }
    return (0, nil)
  }

  fileprivate func nodeCanBeReused(_ node: _SyntaxBase, nodeOffset: Int,
                                   prevOffset: Int, kind: SyntaxKind) -> Bool {
    // Computing the value of NodeStart on the fly is faster than determining a
    // node's absolute position, but make sure the values match in an assertion
    // build
    assert(nodeOffset == node.position.utf8Offset);

    if nodeOffset != prevOffset {
      return false
    }
    if node.raw.kind != kind {
      return false
    }

    // Node can also not be reused if an edit has been made in the next token's
    // text, e.g. because `private struct Foo {}` parses as a CodeBlockItem with
    // a StructDecl inside and `private struc Foo {}` parses as two
    // CodeBlockItems one for `private` and one for `struc Foo {}`
    var nextLeafNodeLength = 0
    if let nextToken = node.nextToken {
      let nextRawNode = nextToken.raw
      assert(nextRawNode.isPresent)
      nextLeafNodeLength += nextRawNode.contentLength.utf8Length
      nextLeafNodeLength += nextRawNode.leadingTriviaLength.utf8Length
    }

    for edit in edits {
      // Check if this node or the trivia of the next node has been edited. If
      // it has, we cannot reuse it.
      if edit.intersectsOrTouchesRange(ByteSourceRange(offset: nodeOffset,
                                  length: node.byteSize + nextLeafNodeLength)) {
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
