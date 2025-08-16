//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Computes and caches information about properties and initializers that ought to be generated for the compatibility layer.
public struct CompatibilityLayer {
  /// Deprecated members that the compatibility layer needs for each node.
  private var deprecatedMembersByNode: [SyntaxNodeKind: DeprecatedMemberInfo] = [:]

  /// Deprecated members that the compatibility layer needs for each trait.
  public var deprecatedMembersByTrait: [String: DeprecatedMemberInfo] = [:]

  /// Cache for `replacementChildren(for:by:historical:)`. Ensures that we don't create two different replacement
  /// children even if we refactor the same child twice, so we can reliably equate and hash `Child` objects by
  /// object identity.
  private var cachedReplacementChildren: [Child: [Child]] = [:]

  /// Returns the deprecated members that the compatibility layer needs for `node`.
  public func deprecatedMembers(for node: LayoutNode) -> DeprecatedMemberInfo {
    return deprecatedMembersByNode[node.kind] ?? DeprecatedMemberInfo()
  }

  /// Returns the deprecated members that the compatibility layer needs for `trait`.
  public func deprecatedMembers(for trait: Trait) -> DeprecatedMemberInfo {
    return deprecatedMembersByTrait[trait.traitName] ?? DeprecatedMemberInfo()
  }

  internal init(nodes: [Node], traits: [Trait]) {
    // This instance will be stored in a global that's used from multiple threads simultaneously, so it won't be safe
    // to mutate once the initializer returns. We therefore do all the work to populate its tables up front, rather
    // than computing it lazily on demand.
    for node in nodes {
      computeMembers(for: node)
    }
    for trait in traits {
      computeMembers(for: trait)
    }
  }

  /// Returns the child or children that would have existed in place of this
  /// child before this refactoring was applied.
  ///
  /// - Parameters:
  ///   - newerChild: The child which is being replaced.
  ///   - refactoring: The refactoring which created that child and must be
  ///     reversed.
  fileprivate mutating func replacementChildren(
    for newerChild: Child,
    by refactoring: Child.Refactoring,
    historical: Bool
  ) -> [Child] {
    func make() -> [Child] {
      switch refactoring {
      case .renamed(from: let deprecatedName):
        return [
          Child(
            renamingTo: deprecatedName,
            makingHistorical: historical,
            newerChildPath: [newerChild]
          )
        ]

      case .extracted:
        let extractedNode = SYNTAX_NODE_MAP[newerChild.syntaxNodeKind]!
        computeMembers(for: extractedNode)

        var newerGrandchildren = extractedNode.layoutNode!.children[...]

        // Drop the leading and trailing unexpected nodes--these will be newly introduced.
        if newerGrandchildren.first?.isUnexpectedNodes ?? false {
          newerGrandchildren.removeFirst()
        }
        if newerGrandchildren.last?.isUnexpectedNodes ?? false {
          newerGrandchildren.removeLast()
        }

        return newerGrandchildren.map { newerGrandchild in
          Child(
            makingHistorical: historical,
            newerChildPath: [newerChild, newerGrandchild]
          )
        }

      case .introduced:
        return [
          Child(
            makingHistorical: historical,
            makingHidden: true,
            newerChildPath: [newerChild]
          )
        ]
      }
    }

    // Make sure we return the same instance even if we're called twice.
    if cachedReplacementChildren[newerChild] == nil {
      cachedReplacementChildren[newerChild] = make()
    }
    return cachedReplacementChildren[newerChild]!
  }

  /// Compute and cache compatibility layer information for the given node, unless it is already present.
  private mutating func computeMembers(for node: Node) {
    guard deprecatedMembersByNode[node.syntaxNodeKind] == nil, let layoutNode = node.layoutNode else {
      return
    }

    let result = computeMembersFor(
      typeName: layoutNode.kind.rawValue,
      initialChildren: layoutNode.children,
      history: layoutNode.childHistory,
      areRequirements: false
    )

    deprecatedMembersByNode[node.syntaxNodeKind] = result
  }

  /// Compute and cache compatibility layer information for the given children.
  private mutating func computeMembers(for trait: Trait) {
    guard deprecatedMembersByTrait[trait.traitName] == nil else {
      return
    }

    let result = computeMembersFor(
      typeName: trait.traitName,
      initialChildren: trait.children,
      history: trait.childHistory,
      areRequirements: true
    )

    deprecatedMembersByTrait[trait.traitName] = result
  }

  /// Compute compatibility layer information for the given children.
  private mutating func computeMembersFor(
    typeName: String,
    initialChildren: [Child],
    history: Child.History,
    areRequirements: Bool
  ) -> DeprecatedMemberInfo {
    var builder = DeprecatedMemberInfo.Builder(
      typeName: typeName,
      children: initialChildren,
      areRequirements: areRequirements
    )

    // If any of the children are experimental, apply an initial change set that hides them, ensuring that we generate
    // APIs which aren't experimental.
    let experimentalChildren = initialChildren.filter { $0.isExperimental && !$0.isUnexpectedNodes }
    if !experimentalChildren.isEmpty {
      let syntheticChangeSet = experimentalChildren.map { ($0.name, Child.Refactoring.introduced) }
      builder.applyChangeSet(syntheticChangeSet, for: &self, historical: false)
    }

    // Apply changes in the history
    for changeSet in history {
      builder.applyChangeSet(changeSet, for: &self, historical: true)
    }

    return builder.make()
  }
}

/// Describes the deprecated members of a given type that the compatibility layer ought to provide.
public struct DeprecatedMemberInfo {
  /// Properties that are needed in the compatibility layer, in the order they ought to appear in the generated file.
  public var vars: [Child] = []

  /// Initializer signatures that are needed in the compatibility layer, in the order they ought to appear in the generated file.
  public var inits: [InitSignature] = []

  /// Is there anything whatsoever that we ought to generate?
  public var isEmpty: Bool {
    return vars.isEmpty && inits.isEmpty
  }

  fileprivate struct Builder {
    /// Properties that are needed in the compatibility layer, in the order they ought to appear in the generated file.
    /// This becomes a property of the `DeprecatedMemberInfo`.
    var vars: [Child] = []

    /// Initializer signatures that are needed in the compatibility layer, in the order they ought to appear in the generated file.
    /// This becomes a property of the `DeprecatedMemberInfo`.
    var inits: [InitSignature] = []

    /// Name of the type we're generating a compatibility layer for.
    private let typeName: String

    /// Are we building a compatibility layer for requirements of a trait? Traits don't have unexpected children or
    /// initializers.
    private let areRequirements: Bool

    /// The current set of children after applying all of the change sets ever passed to `applyChangeSet(_:for:historical:)`.
    /// This is working state.
    private var children: [Child]

    /// The set of all children that have ever been added to `vars`, plus the ones that were originally present.
    /// Used to ensure duplicates aren't added to `vars`. This is working state.
    private var knownVars: Set<Child>

    /// Creates a builder with no deprecated members, but ready to start adding change sets.
    init(typeName: String, children: [Child], areRequirements: Bool) {
      self.typeName = typeName
      self.areRequirements = areRequirements

      self.children = children
      self.knownVars = Set(children)
    }

    /// Creates a `DeprecatedMemberInfo` from all the change sets that have been passed to
    /// `applyChangeSet(_:for:historical:)`.
    func make() -> DeprecatedMemberInfo {
      return DeprecatedMemberInfo(vars: vars, inits: inits)
    }

    func lastVisibleChild(before i: Int, isUnexpectedNodes: Bool) -> Child? {
      let allEarlier = children.prefix(through: max(i - 1, children.startIndex))
      return allEarlier.last { !$0.isHidden && $0.isUnexpectedNodes == isUnexpectedNodes }
    }

    func firstVisibleChild(after i: Int, isUnexpectedNodes: Bool) -> Child? {
      let allLater = children.suffix(from: min(i + 1, children.endIndex))
      return allLater.first { !$0.isHidden && $0.isUnexpectedNodes == isUnexpectedNodes }
    }

    /// Generate the new `vars` and `inits` that are required to maintain compatibility with `changeSet`.
    ///
    /// - Parameters:
    ///   - changeSet: The changes to apply. This type is basically a generic form of `Child.ChangeSet`.
    ///   - compatibilityLayer: The compatibility layer that these children will ultimately belong to.
    ///   - historical: Should the children created by this change set be marked historical (and thus be deprecated)?
    mutating func applyChangeSet(
      _ changeSet: some RandomAccessCollection<(key: String, value: Child.Refactoring)>,
      for compatibilityLayer: inout CompatibilityLayer,
      historical: Bool
    ) {
      var unexpectedChildrenWithNewNames: Set<Child> = []

      // First pass: Apply the changes explicitly specified in the change set.
      for (currentName, refactoring) in changeSet {
        let i = firstIndexOfChild(named: currentName)
        let oldChild = children[i]

        let replacementChildren = compatibilityLayer.replacementChildren(
          for: children[i],
          by: refactoring,
          historical: historical
        )
        children.replaceSubrange(i...i, with: replacementChildren)

        if !areRequirements {
          func isDifferent(_ newChild: Child) -> Bool {
            oldChild.isHidden != newChild.isHidden || oldChild.name != newChild.name
          }

          // Mark adjacent unexpected node children whose names have changed too.
          if let firstNewChild = replacementChildren.first, isDifferent(firstNewChild),
            let adjacentUnexpectedChild = lastVisibleChild(before: i, isUnexpectedNodes: true)
          {
            unexpectedChildrenWithNewNames.insert(adjacentUnexpectedChild)
          }
          if let lastNewChild = replacementChildren.last, isDifferent(lastNewChild),
            let adjacentUnexpectedChild = firstVisibleChild(
              after: i + replacementChildren.count - 1,
              isUnexpectedNodes: true
            )
          {
            unexpectedChildrenWithNewNames.insert(adjacentUnexpectedChild)
          }
        }
      }

      // Second pass: Update unexpected node children adjacent to those changes whose names have probably changed.
      for unexpectedChild in unexpectedChildrenWithNewNames where !unexpectedChild.isHidden {
        precondition(unexpectedChild.isUnexpectedNodes)
        let i = firstIndexOfChild(named: unexpectedChild.name)

        guard i == 0 || !children[i - 1].isHidden else {
          // Special case: `unexpectedChild` follows a hidden child and should be hidden too.
          children[i] = Child(makingHistorical: historical, makingHidden: true, newerChildPath: [unexpectedChild])
          continue
        }

        // Find nearest expected, non-hidden nodes around `unexpectedChild`
        let earlier = lastVisibleChild(before: i, isUnexpectedNodes: false)
        let later = firstVisibleChild(after: i, isUnexpectedNodes: false)

        precondition(!(earlier?.isUnexpectedNodes ?? false) && !(later?.isUnexpectedNodes ?? false))

        let newChild = Child(forUnexpectedBetween: earlier, and: later, newerChildPath: [unexpectedChild])
        precondition(newChild.name != unexpectedChild.name)
        precondition(!children.contains { $0.name == newChild.name })

        children[i] = newChild
      }

      // Third pass: Append newly-created children to vars. We do this now so that changes from the first two passes
      // are properly interleaved, preserving source order.
      self.vars += children.filter { !$0.isHidden && knownVars.insert($0).inserted }

      // We don't create compatibility layers for protocol requirement inits.
      if !areRequirements {
        self.inits.append(InitSignature(children: children))
      }
    }

    @_optimize(none)  // Workaround for SIL optimizer crash (rdar://158353230)
    private func firstIndexOfChild(named targetName: String) -> Int {
      guard let i = children.firstIndex(where: { $0.name == targetName }) else {
        fatalError(
          "couldn't find '\(targetName)' in current children of \(typeName): \(String(reflecting: children.map(\.name)))"
        )
      }
      return i
    }
  }
}
