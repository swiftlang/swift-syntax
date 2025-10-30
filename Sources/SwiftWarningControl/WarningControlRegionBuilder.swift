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

/// Compute the full set of warning control regions in this syntax node
extension SyntaxProtocol {
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControlRegionTree(
    globalControls: [DiagnosticGroupIdentifier: WarningGroupControl] = [:],
    groupInheritanceTree: DiagnosticGroupInheritanceTree? = nil
  ) -> WarningControlRegionTree {
    return warningGroupControlRegionTreeImpl(
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree
    )
  }

  /// Implementation of constructing a region tree with an optional parameter
  /// to specify that the constructed tree must only contain nodes which contain
  /// a specific absolute position - meant to speed up tree generation for individual
  /// queries.
  func warningGroupControlRegionTreeImpl(
    globalControls: [DiagnosticGroupIdentifier: WarningGroupControl],
    groupInheritanceTree: DiagnosticGroupInheritanceTree?,
    containing position: AbsolutePosition? = nil
  ) -> WarningControlRegionTree {
    let visitor = WarningControlRegionVisitor(
      self.range,
      containing: position,
      groupInheritanceTree: groupInheritanceTree
    )
    visitor.tree.addWarningGroupControls(range: self.range, controls: globalControls)
    visitor.walk(self)
    return visitor.tree
  }
}

/// Add this warning control decl syntax node warning group controls (as specified with `@warn`)
/// to the tree.
extension WarningControlRegionTree {
  mutating func addWarningControlRegions(for syntax: some WithAttributesSyntax) {
    addWarningGroupControls(
      range: syntax.range,
      controls: syntax.allWarningGroupControls
    )
  }
}

/// Helper class that walks a syntax tree looking for warning behavior control regions.
private class WarningControlRegionVisitor: SyntaxAnyVisitor {
  /// The tree of warning control regions we have found so far
  var tree: WarningControlRegionTree
  let containingPosition: AbsolutePosition?

  init(
    _ topLevelRange: Range<AbsolutePosition>,
    containing position: AbsolutePosition?,
    groupInheritanceTree: DiagnosticGroupInheritanceTree?
  ) {
    self.tree = WarningControlRegionTree(range: topLevelRange, groupInheritanceTree: groupInheritanceTree)
    containingPosition = position
    super.init(viewMode: .fixedUp)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if let containingPosition,
      !node.range.contains(containingPosition)
    {
      return .skipChildren
    }
    if let withAttributesSyntax = node.asProtocol(WithAttributesSyntax.self) {
      tree.addWarningControlRegions(for: withAttributesSyntax)
    }
    return .visitChildren
  }
}
