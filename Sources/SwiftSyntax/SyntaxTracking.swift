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

// MARK: Utilities

fileprivate typealias SyntaxIndexInTree = SyntaxIdentifier.SyntaxIndexInTree

fileprivate extension Comparable {
  /// Adjusts this value so that it guaranteed to be in `range`.
  func clamped(to range: Range<Self>) -> Self {
    return min(max(self, range.lowerBound), range.upperBound)
  }
}

fileprivate extension Range {
  func split(by split: Range<Bound>) -> (before: Range, after: Range) {
    let before = self.lowerBound..<split.lowerBound.clamped(to: self)
    let after = split.upperBound.clamped(to: self)..<self.upperBound
    return (before, after)
  }
}

fileprivate extension Range<SyntaxIndexInTree> {
  func translated(by offset: Int) -> Range<SyntaxIndexInTree> {
    return SyntaxIndexInTree(
      UInt32(Int(self.lowerBound.indexInTree) + offset)
    )..<SyntaxIndexInTree(UInt32(Int(self.upperBound.indexInTree) + offset))
  }
}

fileprivate extension Syntax {
  var indexInTreeRange: Range<SyntaxIndexInTree> {
    return id.indexInTree..<id.indexInTree.advancedBy(raw)
  }
}
// MARK: SyntaxTracking

/// Maps how much offset needs to be added to a `SyntaxIndexInTree` to map to
/// the corresponding node in a tracked tree.
///
/// For example, if you have the following tree (index in tree in parentheses)
/// ```
///       a (0)
///      / \
/// (1) b   c (2)
/// ```
///
/// And you construct a new tree a follows
///
/// ```
///        x (0)
///      /   \
/// (1) y     a (2)
///          / \
///     (3) b   c (4)
/// ```
///
/// Then the new tree would have a single syntax tracking range of `2...4: -2`.
/// This defines that nodes with `indexInTree` 2 to 4 occur in the tracked tree
/// and that to receive the `indexInTree` within the tracked tree, 2 needs to
/// be subtracted from the node in the derived tree.
struct SyntaxTracking {
  fileprivate struct TrackedRange {
    /// The range that can be mapped to the tracked syntax tree
    var range: Range<SyntaxIndexInTree>

    /// The number that needs to be added to `indexInTree` to get the node in
    /// the tracked tree.
    var offset: Int

    /// Shift the tracked range so that it tracks nodes that are now `shift`
    /// nodes further in the tree.
    ///
    /// This shifts the tracked range upwards by `offset` and the offset down by
    /// `shift` so that the tracked nodes still point to the original nodes.
    func translated(by shift: Int) -> Self {
      return TrackedRange(
        range: self.range.translated(by: shift),
        offset: self.offset - shift
      )
    }
  }

  /// The ID of the tree to which tracked ranges can translate the syntax nodes.
  fileprivate var trackedTree: RootID

  /// Stores the actual tracked ranges
  private var trackedRanges: [TrackedRange] = [] {
    didSet {
      assertNoOverlappingTrackedRanges()
    }
  }

  fileprivate init(trackedTree: RootID, trackedRanges: [TrackedRange]) {
    self.trackedTree = trackedTree
    self.trackedRanges = trackedRanges
  }

  /// Update the `SyntaxTracking` to account for `oldNode` being replaced by `newNode`.
  ///
  /// It does the following
  ///  - Shift all tracked ranges after `oldNode` to account for the fact that
  ///    `newNode` might have more or fewer nodes than `oldNode`
  ///  - Incorporate the tracked ranges of `newNode` into this `SyntaxTracking`.
  ///
  /// - Complexity: O(trackedRanges.count + newNode.trackedRanges.count)
  func replacing(
    oldIndexInTree: SyntaxIdentifier.SyntaxIndexInTree,
    oldTotalNodes: Int,
    by newNode: Syntax?
  ) -> SyntaxTracking {
    let replacedRange = oldIndexInTree..<SyntaxIndexInTree(oldIndexInTree.indexInTree + UInt32(oldTotalNodes))
    var newTrackedRanges = trackedRanges.flatMap { tracked -> [TrackedRange] in
      let (before, after) = tracked.range.split(by: replacedRange)
      // - The ranges before the replaced nodes don't need to be adjusted
      // - The ranges after the replaced range need to be adjusted:
      //   - The range needs to be shifted upwards if the new node has more
      //     total subtree nodes
      //   - Because we shift the range upwards we need to shift the offset down
      //     correspondingly.
      let offset = (newNode?.raw.totalNodes ?? 0) - oldTotalNodes
      return [
        TrackedRange(range: before, offset: tracked.offset),
        TrackedRange(range: after, offset: tracked.offset).translated(by: offset),
      ].filter { !$0.range.isEmpty }
    }

    // If the new node has nodes that are being tracked in `trackedTree`
    // transfer these translations to the new tracked ranges.
    if let newNode,
      let newNodeSyntaxTracking = newNode.syntaxTracking, newNodeSyntaxTracking.trackedTree == trackedTree
    {
      newTrackedRanges += newNodeSyntaxTracking.trackedRanges.map { tracked in
        let offset = Int(oldIndexInTree.indexInTree) - Int(newNode.id.indexInTree.indexInTree)
        return tracked.translated(by: offset)
      }
    }
    return SyntaxTracking(trackedTree: self.trackedTree, trackedRanges: newTrackedRanges)
  }

  /// If `originalNode` has an original node within this `SyntaxTracking`'s
  /// `trackedTree` add an association of the node within a new tree to the
  /// tracked tree.
  ///
  /// - Parameters:
  ///   - originalNode: The node in the original tree. Note that this doesn't
  ///     have to be a node within the tracked tree. It can be a node in a
  ///     derived tree that itself tracks `trackedTree`.
  ///   - nodeIndexInNewTree: The `SyntaxIndexInTree` of the node within the new
  ///     tree.
  /// - Complexity: O(newNode.trackedRanges.count)
  fileprivate mutating func track(originalNode: Syntax, nodeIndexInNewTree: SyntaxIndexInTree) {
    guard originalNode.trackedTree == trackedTree else {
      // The node doesn't track the same tracked tree (or doesn't track any tree).
      // So there's nothing to do.
      return
    }

    // Find the tracked ranges in the original node that allow the translation
    // of nodes within the subtree of `originalNode` to be translated to nodes
    // in the tracked tree.
    guard let originalNodeTranslationRanges = originalNode.syntaxTracking?.trackedRanges(of: originalNode) else {
      return
    }

    // Adjust the tracked ranges and their offsets to refer to nodes in the new tree.
    let offset = Int(nodeIndexInNewTree.indexInTree) - Int(originalNode.id.indexInTree.indexInTree)
    self.trackedRanges += originalNodeTranslationRanges.map { tracked in
      return tracked.translated(by: offset)
    }
  }

  /// Return all tracked ranges of `node`.
  ///
  /// I.e. this returns all tracked ranges in this `SyntaxTracking` clamped to
  /// the ranges that affect `node`.
  ///
  /// - Complexity: O(trackedRanges.count)
  fileprivate func trackedRanges(of node: Syntax) -> [TrackedRange] {
    let nodeIndexInTreeRange = node.indexInTreeRange
    return trackedRanges.compactMap { tracked -> TrackedRange? in
      let clamped = tracked.range.clamped(to: nodeIndexInTreeRange)
      if clamped.isEmpty {
        return nil
      }
      return TrackedRange(range: clamped, offset: tracked.offset)
    }
  }

  /// Translate the `SyntaxIndexInTree` of a syntax node to the `SyntaxIndexInTree`
  /// in `trackedTree`.
  ///
  /// This is the main entry point to find the original node in a tracked tree.
  ///
  /// - Complexity: O(trackedRanges.count)
  func originalIndexInTree(
    of derivedIndexInTree: SyntaxIdentifier.SyntaxIndexInTree
  ) -> SyntaxIdentifier.SyntaxIndexInTree? {
    for tracked in trackedRanges {
      if tracked.range.contains(derivedIndexInTree) {
        return SyntaxIndexInTree(UInt32(Int(derivedIndexInTree.indexInTree) + tracked.offset))
      }
    }
    return nil
  }

  /// Assert that the tracked ranges don't overlap.
  ///
  /// - Complexity: O(trackedRanges.count ^ 2)
  private func assertNoOverlappingTrackedRanges() {
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    for xIndex in trackedRanges.indices {
      for yIndex in trackedRanges.index(after: xIndex)..<trackedRanges.endIndex {
        assert(!trackedRanges[xIndex].range.overlaps(trackedRanges[yIndex].range))
      }
    }
    #endif
  }
}

// MARK: Public accessors to tracking

extension Syntax {
  /// The same ``Syntax`` but with tracking enabled in the entire tree.
  ///
  /// All syntax nodes derived from this will be able to find their
  /// corresponding location in this original tree.
  fileprivate var tracked: Syntax {
    if let parent {
      let parentTracked = parent.tracked
      return parentTracked.child(at: self.indexInParent)!
    } else {
      let result = Syntax.forRoot(self.raw, rawNodeArena: self.raw.arenaReference.retained)
      let syntaxTracking = SyntaxTracking(
        trackedTree: result.id.rootId,
        trackedRanges: [SyntaxTracking.TrackedRange(range: result.indexInTreeRange, offset: 0)]
      )
      result.setSyntaxTrackingOfTree(syntaxTracking)
      return result
    }
  }

  /// The tree that this syntax node is tracking
  var trackedTree: RootID? {
    return syntaxTracking?.trackedTree
  }
}

class IndexInTreeFinder: SyntaxAnyVisitor {
  let indexInTree: SyntaxIdentifier.SyntaxIndexInTree
  var found: Syntax? = nil

  init(indexInTree: SyntaxIdentifier.SyntaxIndexInTree) {
    self.indexInTree = indexInTree
    super.init(viewMode: .all)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if node.id.indexInTree == indexInTree {
      assert(found == nil)
      found = node
    }
    if node.indexInTreeRange.contains(indexInTree) {
      return .visitChildren
    } else {
      return .skipChildren
    }
  }
}

extension SyntaxProtocol {
  /// The same ``Syntax`` but with tracking enabled in the entire tree.
  ///
  /// All syntax nodes derived from this will be able to find their
  /// corresponding location in this original tree.
  ///
  /// - Complexity: O(number of ancestors)
  public var tracked: Self {
    return Syntax(self).tracked.cast(Self.self)
  }

  /// If this syntax node is tracking `originalTree` and this node originated
  /// in that tree, return the corresponding corresponding node in `originalTree`.
  ///
  /// The original node will have the same structure as this node but the parent
  /// might be different since it's anchored in `originalTree`.
  ///
  /// The original node's source location will be the location that the node had
  /// in `originalTree`.
  ///
  /// - SeeAlso: ``SyntaxProtocol/tracked``
  /// - Complexity: O(tracked ranges in this tree) + O(width * depth of original tree)
  public func originalNode(in originalTree: some SyntaxProtocol) -> Self? {
    guard let originalIndexInTree = Syntax(self).syntaxTracking?.originalIndexInTree(of: self.id.indexInTree) else {
      return nil
    }

    let finder = IndexInTreeFinder(indexInTree: originalIndexInTree)
    finder.walk(originalTree.root)
    return finder.found?.cast(Self.self)
  }
}

// MARK: To be generated

extension SyntaxTracking {
  /// Find the tree that should be tracked by a node that has the given nodes as
  /// children.
  ///
  /// If all syntax nodes that have tracking enabled track the same tree, return
  /// that tree's root ID.
  ///
  /// If no nodes track any tree or there are two nodes that track conflicting
  /// trees, return `nil`.
  ///
  /// - Complexity: O(nodes.count)
  @inline(__always)
  private static func treeToTrack(_ nodes: [Syntax?]) -> RootID? {
    var treeToTrack: RootID? = nil
    for case .some(let node) in nodes {
      if treeToTrack == nil {
        treeToTrack = node.trackedTree
      } else if node.trackedTree != nil && treeToTrack != node.trackedTree {
        return nil
      }
    }
    return treeToTrack
  }

  /// Construct a new `SyntaxTracking` that tracks all `nodes` in a new node.
  /// that has `nodes` as children.
  ///
  /// - Complexity: O(Σ_(n in nodes) 1 + n.trackedRanges.count) i.e. O(nodes.count) if no node tracks a tree.
  @inline(__always)
  // FIXME: Rename to trackingChildren
  init?(tracking nodes: [Syntax?]) {
    guard let treeToTrack = SyntaxTracking.treeToTrack(nodes) else {
      return nil
    }
    self.init(trackedTree: treeToTrack, trackedRanges: [])
    var indexInTree = SyntaxIndexInTree(0).advancedToFirstChild()
    for case .some(let node) in nodes {
      self.track(originalNode: node, nodeIndexInNewTree: indexInTree)
      indexInTree = indexInTree.advancedBy(node.raw)
    }
  }

  /// Construct a new `SyntaxTracking` that tracks all `nodes` in a new node.
  /// that has `nodes` as children.
  ///
  /// - Complexity: O(Σ_(n in nodes) 1 + n.trackedRanges.count) i.e. O(nodes.count) if no node tracks a tree.
  @inline(__always)
  init?(trackingRoot node: Syntax) {
    guard let treeToTrack = node.trackedTree else {
      return nil
    }
    self.init(trackedTree: treeToTrack, trackedRanges: [])
    self.track(originalNode: node, nodeIndexInNewTree: SyntaxIndexInTree(0))
  }
}
