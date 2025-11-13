//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// A single warning control region, consisting of a start and end positions,
/// a diagnostic group identifier, and an emission behavior control specifier.
@_spi(ExperimentalLanguageFeatures)
public struct WarningControlRegion {
  public let range: Range<AbsolutePosition>
  public let diagnosticGroupIdentifier: DiagnosticGroupIdentifier
  public let control: WarningGroupControl

  init(
    range: Range<AbsolutePosition>,
    diagnosticGroupIdentifier: DiagnosticGroupIdentifier,
    control: WarningGroupControl
  ) {
    self.range = range
    self.diagnosticGroupIdentifier = diagnosticGroupIdentifier
    self.control = control
  }
}

/// A struct representing a diagnostic group identifier string
@_spi(ExperimentalLanguageFeatures)
public struct DiagnosticGroupIdentifier: Hashable, Sendable, ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.identifier = value
  }
  public init(_ value: String) {
    self.identifier = value
  }
  public let identifier: String
}

/// Describes all of the `@warn` diagnostic group behavior controls within the
/// given syntax node, indicating each group's active behavior at a given position.
///
/// For example, given code like the following:
///
/// ```
///  1 |  @warn(Deprecate, as: error)
///  2 |  func foo() {
///  3 |     let a = dep
///  4 |     @warn(Deprecate, as: warning)
///  5 |     func bar() {
///  6 |         let b = dep
///  7 |         @warn(Deprecate, as: ignored)
///  8 |         func baz() {
///  9 |           let c = dep
/// 10 |        }
/// 11 |        @warn(Deprecate, as: error)
/// 12 |        @warn(OtherGroup, as: error)
/// 13 |        func qux() {
/// 14 |            let d = dep
/// 15 |             @warn(SomeOtherGroup, as: warning)
/// 16 |            func corge() {
/// 17 |              let e = dep
/// 18 |            }
/// 19 |        }
/// 20 |     }
/// 21 | }
/// 22 | func grault() {
/// 23 |   let f = dep
/// 24 | }
/// ```
///
/// the result will be:
///   - [`Deprecate`:`error`] region within `foo` lexical scope (lines 1-22)
///     - [`Deprecate`:`warning`] region within `bar` lexical scope (lines 4-20)
///       - [`Deprecate`:`ignored`] region within `baz` lexical scope (lines 7-10)
///       - [`Deprecate`:`error`, `OtherGroup`:`error`] region within `qux` lexical scope (lines 12-19)
///         - [`SomeOtherGroup`:`warning`] region within `corge` lexical scope (lines 15-18)
///
/// The data structure represents these regions and their nesting relationships
/// as an interval tree where interval nodes can only be nested or disjoint,
/// and where a given interval corresponds to a diagnostic control region for one
/// or more diagnostic group, with a behavior specifier for each.
///
/// Intervals cannot partially overlap, and each node's child intervals are always kept
/// sorted. The tree has multiple top-level nodes (roots) representing file-level warning
/// control regions.
///
/// Once the tree is computed, lookup of a diagnostic group behavior at a given position
/// is performed by recursively descending into the child node containing
/// the given position (located with a binary search of child nodes of a given parent node).
/// Once the position's depth in the interval tree is reached, we walk back the
/// traversal until we find the first containing region which specifies warning
/// behavior control for the given diagnostic group id.
///
@_spi(ExperimentalLanguageFeatures)
public struct WarningControlRegionTree {
  /// Root region representing top-level (file) scope
  private var rootRegionNode: WarningControlRegionNode

  /// All of the diagnostic group identifiers contained in this tree
  /// which have at least one occurence with a non-`ignored` behavior
  /// specifier
  @_spi(ExperimentalLanguageFeatures)
  public private(set) var enabledGroups: Set<DiagnosticGroupIdentifier> = []

  /// Inheritance tree among diagnostic group identifiers
  private let groupInheritanceTree: DiagnosticGroupInheritanceTree

  init(
    range: Range<AbsolutePosition>,
    groupInheritanceTree: DiagnosticGroupInheritanceTree?
  ) {
    self.rootRegionNode = WarningControlRegionNode(range: range)
    self.groupInheritanceTree = groupInheritanceTree ?? DiagnosticGroupInheritanceTree()
  }

  /// Add a warning control region to the tree
  mutating func addWarningGroupControls(
    range: Range<AbsolutePosition>,
    controls: [DiagnosticGroupIdentifier: WarningGroupControl]
  ) {
    guard !controls.isEmpty else { return }
    let newNode = WarningControlRegionNode(range: range)
    for (diagnosticGroupIdentifier, control) in controls {
      // Handle the control for the added diagnostic group
      // and propagate it to all of its subgroups.
      var groups: [DiagnosticGroupIdentifier] = [diagnosticGroupIdentifier]
      var processedGroups: Set<DiagnosticGroupIdentifier> = []
      while !groups.isEmpty {
        let groupIdentifier = groups.removeFirst()
        processedGroups.insert(groupIdentifier)
        newNode.addWarningGroupControl(for: groupIdentifier, control: control)
        if control != .ignored {
          enabledGroups.insert(diagnosticGroupIdentifier)
        }

        let newSubGroups = groupInheritanceTree.subgroups(of: groupIdentifier).filter { !processedGroups.contains($0) }
        // Ensure we add a corresponding control to each direct and
        // transitive sub-group of the one specified on this control.
        groups.append(contentsOf: newSubGroups)
      }
    }
    insertIntoSubtree(newNode, parent: rootRegionNode)
  }

  /// Insert a region node into the appropriate position in a subtree.
  /// During top-down traversal of the syntax tree, nodes that are visited
  /// later should never contain any of the previously visited nodes,
  /// so it is sufficient to either find an existing child to insert this node
  /// into, or add this node as a new child itself.
  private func insertIntoSubtree(
    _ node: WarningControlRegionNode,
    parent: WarningControlRegionNode
  ) {
    // Check if the new region has the same boundaries as the parent
    if parent.range == node.range {
      for (diagnosticGroupIdentifier, control) in node.warningGroupControls {
        parent.addWarningGroupControl(for: diagnosticGroupIdentifier, control: control)
      }
      return
    }

    // Check if this should be a child of one of parent's children
    if let containingChild = parent.findChildContaining(node.range.lowerBound) {
      insertIntoSubtree(node, parent: containingChild)
      return
    }

    // Add as direct child of parent
    parent.addChild(node)
  }
}

extension WarningControlRegionTree: CustomDebugStringConvertible {
  public var debugDescription: String {
    var result = "Warning Group Control Region Tree:\n"
    func printNode(_ node: WarningControlRegionNode, indent: Int) {
      let spacing = String(repeating: "  ", count: indent)
      result += "\(spacing)[\(node.range.lowerBound), \(node.range.upperBound)]"
      if !node.warningGroupControls.isEmpty {
        result +=
          " control(s): \(node.warningGroupControls.map { $0.key.identifier + ": " + $0.value.rawValue }.joined(separator: ", "))\n"
      } else {
        result += "\n"
      }
      for child in node.children {
        printNode(child, indent: indent + 1)
      }
    }

    printNode(rootRegionNode, indent: 0)
    return result
  }
}

extension WarningControlRegionTree {
  /// Determine the warning group behavior control at a specified position
  /// for a given diagnostic group.
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControl(
    at position: AbsolutePosition,
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier
  ) -> WarningGroupControl? {
    return rootRegionNode.innermostContainingRegion(at: position, for: diagnosticGroupIdentifier)?.control
  }
}

/// A node in the warning control region tree, representing a collection of warning
/// group controls and references to its nested child regions.
private class WarningControlRegionNode {
  let range: Range<AbsolutePosition>
  var warningGroupControls: [DiagnosticGroupIdentifier: WarningGroupControl] = [:]
  var children: [WarningControlRegionNode] = []

  init(
    range: Range<AbsolutePosition>,
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier,
    control: WarningGroupControl
  ) {
    self.range = range
    self.warningGroupControls = [diagnosticGroupIdentifier: control]
  }

  init(range: Range<AbsolutePosition>) {
    self.range = range
    self.warningGroupControls = [:]
  }

  /// Add a region with the same bounds as this node
  func addWarningGroupControl(
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier,
    control: WarningGroupControl
  ) {
    warningGroupControls[diagnosticGroupIdentifier] = control
  }

  /// Get region with specific identifier if it exists
  func getWarningGroupControl(for diagnosticGroupIdentifier: DiagnosticGroupIdentifier) -> WarningControlRegion? {
    guard let groupControl = warningGroupControls[diagnosticGroupIdentifier] else {
      return nil
    }
    return WarningControlRegion(
      range: range,
      diagnosticGroupIdentifier: diagnosticGroupIdentifier,
      control: groupControl
    )
  }

  /// Add a child region that is directly nested within this region
  func addChild(_ node: WarningControlRegionNode) {
    precondition(range.lowerBound <= node.range.lowerBound && node.range.upperBound <= range.upperBound)
    children.append(node)
    children.sort()
  }
}

extension WarningControlRegionNode {
  /// Find the most deeply-nested warning control region with a given diagnostic group identifier
  /// containing the specified position.
  ///
  /// Lookup complexity is `O(log n + d)` where `n` is the branching factor and `d` is the warning
  /// control node depth of the queried position.
  func innermostContainingRegion(
    at position: AbsolutePosition,
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier
  ) -> WarningControlRegion? {
    guard range.contains(position) else {
      return nil
    }
    if let childRegionContainingPosition = findChildContaining(position),
      let nestedResult = childRegionContainingPosition.innermostContainingRegion(
        at: position,
        for: diagnosticGroupIdentifier
      )
    {
      return nestedResult
    }
    // If no child region has this warning group, check self
    return getWarningGroupControl(for: diagnosticGroupIdentifier)
  }

  /// Binary search to find the exact child containing the specified position,
  /// or `nil` if one is not found, meaning it is only the `self` node itself that contains the position.
  func findChildContaining(_ position: AbsolutePosition) -> WarningControlRegionNode? {
    guard range.contains(position) && !children.isEmpty else { return nil }

    var left = 0
    var right = children.count - 1

    while left <= right {
      let mid = (left + right) / 2
      let region = children[mid]
      if region.range.lowerBound > position {
        right = mid - 1
      } else if region.range.upperBound <= position {
        left = mid + 1
      } else {
        return region
      }
    }
    return nil
  }
}

extension WarningControlRegionNode: Comparable {
  static func == (lhs: WarningControlRegionNode, rhs: WarningControlRegionNode) -> Bool {
    return lhs.range == rhs.range
  }

  static func < (lhs: WarningControlRegionNode, rhs: WarningControlRegionNode) -> Bool {
    if lhs.range.lowerBound != rhs.range.lowerBound {
      return lhs.range.lowerBound < rhs.range.lowerBound
    }
    // For same start, larger interval comes first (reverse order by end)
    // This can happen, for example, when the top-level region (source-file scope)
    // also contains a warning control scope at the very beginning which
    // also begins at position 0.
    return lhs.range.upperBound > rhs.range.upperBound
  }
}
