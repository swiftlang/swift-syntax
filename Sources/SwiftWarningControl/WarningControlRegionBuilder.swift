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

import SwiftIfConfig
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax

/// Compute the full set of warning control regions in this syntax node
extension SyntaxProtocol {
  /// Compute the tree of warning control regions for this syntax node, representing
  /// the effect of every `@diagnose` attribute reachable through the active
  /// branches of `#if` directives.
  ///
  /// The returned tree can be queried with `warningGroupControl(at:for:)` to
  /// determine the effective `WarningGroupControl` for a given diagnostic group
  /// at any position within this node.
  ///
  /// - Parameters:
  ///   - configuredRegions: The configured regions of the current syntax tree.
  ///     Used to resolve `#if` directives so that only `@diagnose` attributes
  ///     in active clauses contribute to the resulting tree.
  ///   - globalControls: The global controls to consider, specified by the client,
  ///     representing module-wide diagnostic group emission configuration, for example
  ///     with `-Wwarning` and `-Werror` flags. These controls can be overriden at
  ///     finer-grained scopes with the `@diagnose` attribute.
  ///   - groupInheritanceTree: An optional inheritance tree describing parent/child
  ///     relationships between diagnostic groups. When provided, a control applied
  ///     to a parent group also applies to its descendants unless overridden.
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControlRegionTree(
    configuredRegions: ConfiguredRegions,
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)] = [],
    groupInheritanceTree: DiagnosticGroupInheritanceTree? = nil
  ) -> WarningControlRegionTree {
    return warningGroupControlRegionTreeImpl(
      configuredRegions: configuredRegions,
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree
    )
  }

  @available(
    *,
    deprecated,
    message: "Use warningGroupControlRegionTree(configuredRegions:globalControls:groupInheritanceTree:) instead"
  )
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControlRegionTree(
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)] = [],
    groupInheritanceTree: DiagnosticGroupInheritanceTree? = nil
  ) -> WarningControlRegionTree {
    let emptyRegions = ConfiguredRegions.empty
    return warningGroupControlRegionTreeImpl(
      configuredRegions: emptyRegions,
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree
    )
  }

  /// Implementation of constructing a region tree with an optional parameter
  /// to specify that the constructed tree must only contain nodes which contain
  /// a specific absolute position - meant to speed up tree generation for individual
  /// queries.
  func warningGroupControlRegionTreeImpl(
    configuredRegions: ConfiguredRegions,
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)],
    groupInheritanceTree: DiagnosticGroupInheritanceTree?,
    containing position: AbsolutePosition? = nil
  ) -> WarningControlRegionTree {
    let visitor = WarningControlRegionVisitor(
      self.range,
      containing: position,
      groupInheritanceTree: groupInheritanceTree,
      configuredRegions: configuredRegions
    )
    visitor.tree.addWarningGroupControls(range: self.range, controls: globalControls)
    visitor.walk(self)
    return visitor.tree
  }
}

/// Add this warning control decl syntax node warning group controls (as specified with `@diagnose`)
/// to the tree.
extension WarningControlRegionTree {
  mutating func addWarningControlRegions(for syntax: some WithAttributesSyntax) {
    addWarningGroupControls(
      range: syntax.range,
      controls: syntax.allWarningGroupControls(in: configuredRegions)
    )
  }
}

/// Helper class that walks a syntax tree looking for warning behavior control regions.
private class WarningControlRegionVisitor: ActiveSyntaxAnyVisitor {
  /// The tree of warning control regions we have found so far
  var tree: WarningControlRegionTree
  let containingPosition: AbsolutePosition?

  init(
    _ topLevelRange: Range<AbsolutePosition>,
    containing position: AbsolutePosition?,
    groupInheritanceTree: DiagnosticGroupInheritanceTree?,
    configuredRegions: ConfiguredRegions
  ) {
    self.tree = WarningControlRegionTree(
      range: topLevelRange,
      configuredRegions: configuredRegions,
      groupInheritanceTree: groupInheritanceTree
    )
    containingPosition = position
    super.init(viewMode: .fixedUp, configuredRegions: configuredRegions)
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
