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

  /// Cache for `replacementChildren(for:by:)`. Ensures that we don't create two different replacement children even
  /// if we refactor the same child twice, so we can reliably equate and hash `Child` objects by object identity.
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
  private mutating func replacementChildren(for newerChild: Child, by refactoring: Child.Refactoring) -> [Child] {
    func make() -> [Child] {
      switch refactoring {
      case .renamed(from: let deprecatedName):
        return [
          Child(
            renamingTo: deprecatedName,
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
          Child(newerChildPath: [newerChild, newerGrandchild])
        }
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

  /// Compute and cache compatibility layer information for the given children.
  private mutating func computeMembersFor(
    typeName: String,
    initialChildren: [Child],
    history: Child.History,
    areRequirements: Bool
  ) -> DeprecatedMemberInfo {
    // The results that will ultimately be saved into the DeprecatedMemberInfo.
    var vars: [Child] = []
    var initSignatures: [InitSignature] = []

    // Temporary working state for the loop.
    var children = initialChildren
    var knownVars = Set(children)

    func firstIndexOfChild(named targetName: String) -> Int {
      guard let i = children.firstIndex(where: { $0.name == targetName }) else {
        fatalError(
          "couldn't find '\(targetName)' in current children of \(typeName): \(String(reflecting: children.map(\.name)))"
        )
      }
      return i
    }

    for changeSet in history {
      var unexpectedChildrenWithNewNames: Set<Child> = []

      // First pass: Apply the changes explicitly specified in the change set.
      for (currentName, refactoring) in changeSet {
        let i = firstIndexOfChild(named: currentName)

        let replacementChildren = replacementChildren(for: children[i], by: refactoring)
        children.replaceSubrange(i...i, with: replacementChildren)

        if !areRequirements {
          // Mark adjacent unexpected node children whose names have changed too.
          if currentName != replacementChildren.first?.name {
            unexpectedChildrenWithNewNames.insert(children[i - 1])
          }
          if currentName != replacementChildren.last?.name {
            unexpectedChildrenWithNewNames.insert(children[i + replacementChildren.count])
          }
        }
      }

      // Second pass: Update unexpected node children adjacent to those changes whose names have probably changed.
      for unexpectedChild in unexpectedChildrenWithNewNames {
        precondition(unexpectedChild.isUnexpectedNodes)
        let i = firstIndexOfChild(named: unexpectedChild.name)

        let earlier = children[checked: i - 1]
        let later = children[checked: i + 1]
        precondition(!(earlier?.isUnexpectedNodes ?? false) && !(later?.isUnexpectedNodes ?? false))

        let newChild = Child(forUnexpectedBetween: earlier, and: later, newerChildPath: [unexpectedChild])
        precondition(newChild.name != unexpectedChild.name)
        precondition(!children.contains { $0.name == newChild.name })

        children[i] = newChild
      }

      // Third pass: Append newly-created children to vars. We do this now so that changes from the first two passes are properly interleaved, preserving source order.
      vars += children.filter { knownVars.insert($0).inserted }

      // We don't create compatibility layers for protocol requirement inits.
      if !areRequirements {
        initSignatures.append(InitSignature(children: children))
      }
    }

    return DeprecatedMemberInfo(vars: vars, inits: initSignatures)
  }
}

/// Describes the deprecated members of a given type that the compatibility layer ought to provide.
public struct DeprecatedMemberInfo {
  /// Properties that are needed in the compatibility layer, in the order they ought to appear in the generated file.
  public var vars: [Child] = []

  /// Initializer signatures that are needed in the compatibility layer, in the order they ought to appear in the generated file.
  public var inits: [InitSignature] = []
}

extension Array {
  /// Returns `nil` if `i` is out of bounds, or the indicated element otherwise.
  fileprivate subscript(checked i: Index) -> Element? {
    get {
      return indices.contains(i) ? self[i] : nil
    }
  }
}
