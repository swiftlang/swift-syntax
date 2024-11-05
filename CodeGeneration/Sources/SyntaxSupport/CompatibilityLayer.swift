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

  /// Cache for `replacementChild(for:)`. Ensures that we don't create two different replacement children even
  /// if we refactor the same child twice, so we can reliably equate and hash `Child` objects by object identity.
  private var cachedReplacementChildren: [Child: Child?] = [:]

  /// Returns the deprecated members that the compatibility layer needs for `node`.
  public func deprecatedMembers(for node: LayoutNode) -> DeprecatedMemberInfo {
    return deprecatedMembersByNode[node.kind] ?? DeprecatedMemberInfo()
  }

  internal init(nodes: [Node]) {
    // This instance will be stored in a global that's used from multiple threads simultaneously, so it won't be safe
    // to mutate once the initializer returns. We therefore do all the work to populate its tables up front, rather
    // than computing it lazily on demand.
    for node in nodes {
      computeMembers(for: node)
    }
  }

  private mutating func replacementChild(for newerChild: Child) -> Child? {
    func make() -> Child? {
      guard let deprecatedName = newerChild.deprecatedName else {
        return nil
      }

      return Child(renamingTo: deprecatedName, newerChild: newerChild)
    }

    // Make sure we return the same instance even if we're called twice.
    if cachedReplacementChildren[newerChild] == nil {
      cachedReplacementChildren[newerChild] = make()
    }
    return cachedReplacementChildren[newerChild]!
  }

  private mutating func computeMembers(for node: Node) {
    guard deprecatedMembersByNode[node.syntaxNodeKind] == nil, let layoutNode = node.layoutNode else {
      return
    }

    // The results that will ultimately be saved into the DeprecatedMemberInfo.
    var vars: [Child] = []
    var initSignatures: [InitSignature] = []

    // Temporary working state.
    var children = layoutNode.children
    var knownVars = Set(children)

    func firstIndexOfChild(named targetName: String) -> Int {
      guard let i = children.firstIndex(where: { $0.name == targetName }) else {
        fatalError(
          "couldn't find '\(targetName)' in current children of \(node.syntaxNodeKind.rawValue): \(String(reflecting: children.map(\.name)))"
        )
      }
      return i
    }

    var unexpectedChildrenWithNewNames: Set<Child> = []

    // First pass: Apply the changes explicitly specified in the change set.
    for i in children.indices {
      let currentName = children[i].name
      guard let replacementChild = replacementChild(for: children[i]) else {
        continue
      }
      children[i] = replacementChild

      // Mark adjacent unexpected node children whose names have changed too.
      if currentName != replacementChild.name {
        unexpectedChildrenWithNewNames.insert(children[i - 1])
        unexpectedChildrenWithNewNames.insert(children[i + 1])
      }
    }

    // Second pass: Update unexpected node children adjacent to those changes whose names have probably changed.
    for unexpectedChild in unexpectedChildrenWithNewNames {
      precondition(unexpectedChild.isUnexpectedNodes)
      let i = firstIndexOfChild(named: unexpectedChild.name)

      let earlier = children[checked: i - 1]
      let later = children[checked: i + 1]
      precondition(!(earlier?.isUnexpectedNodes ?? false) && !(later?.isUnexpectedNodes ?? false))

      let newChild = Child(forUnexpectedBetween: earlier, and: later, newerChild: unexpectedChild)
      precondition(newChild.name != unexpectedChild.name)
      precondition(!children.contains { $0.name == newChild.name })

      children[i] = newChild
    }

    // Third pass: Append newly-created children to vars. We do this now so that changes from the first two passes are properly interleaved, preserving source order.
    vars += children.filter { knownVars.insert($0).inserted }

    initSignatures.append(InitSignature(children: children))

    deprecatedMembersByNode[node.syntaxNodeKind] = DeprecatedMemberInfo(vars: vars, inits: initSignatures)
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
