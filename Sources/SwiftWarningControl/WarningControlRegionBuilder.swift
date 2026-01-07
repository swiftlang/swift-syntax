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

@_spi(ExperimentalLanguageFeatures) import SwiftSyntax

/// Compute the full set of warning control regions in this syntax node
extension SyntaxProtocol {
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControlRegionTree(
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)] = [],
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
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)],
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
    if let withAttributesSyntax = node.asProtocol(WithAttributesSyntax.self) {
      tree.addWarningControlRegions(for: withAttributesSyntax)
    }
    // Handle file-scoped `using` declarations before the `containingPosition`
    // check since they may only appear in top-level code and may affect
    // warning group control of all positions in this source file.
    if let usingAttributedSyntax = node.as(UsingDeclSyntax.self),
      node.isTopLevelCode(),
      let usingWarningControl = usingAttributedSyntax.warningControl
    {
      tree.addRootWarningGroupControls(controls: [usingWarningControl])
    }
    // Skip all declarations which do not contain the specified
    // `containingPosition`.
    if let containingPosition,
      node.isProtocol(DeclSyntaxProtocol.self),
      !node.range.contains(containingPosition)
    {
      return .skipChildren
    }
    return .visitChildren
  }
}

extension SyntaxProtocol {
  /// Determines if this syntax node is top-level code (not contained in any declaration
  /// or other scoped source in top-level script code).
  func isTopLevelCode() -> Bool {
    let current = Syntax(self)
    if current.parent?.is(CodeBlockItemSyntax.self) ?? false,
      current.parent?.parent?.is(CodeBlockItemListSyntax.self) ?? false,
      current.parent?.parent?.parent?.is(SourceFileSyntax.self) ?? false
    {
      return true
    }
    return false
  }
}
