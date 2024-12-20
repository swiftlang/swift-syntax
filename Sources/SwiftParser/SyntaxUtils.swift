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

#if compiler(>=6)
@_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

// MARK: - Unexpected nodes

extension RawUnexpectedNodesSyntax {
  /// Returns `true` if this contains a token that satisfies `condition`.
  func containsToken(where condition: (RawTokenSyntax) -> Bool) -> Bool {
    return self.elements.contains(where: { node in
      if let token = node.as(RawTokenSyntax.self) {
        return condition(token)
      } else {
        return false
      }
    })
  }

  /// If `nodes` is not empty, construct a ``RawUnexpectedNodesSyntax``
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType], arena: __shared RawSyntaxArena) {
    if nodes.isEmpty {
      return nil
    } else {
      self.init(elements: nodes.map(RawSyntax.init), arena: arena)
    }
  }

  /// If `nodes` contains non-`nil` values, construct a ``RawUnexpectedNodesSyntax``
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType?], arena: __shared RawSyntaxArena) {
    self.init(nodes.compactMap({ $0 }), arena: arena)
  }
}

// MARK: Combining unexpected nodes

/// Implementation detail of `RawUnexpectedNodesSyntax.init(combining:arena)`.
protocol UnexpectedNodesCombinable {
  var elements: [RawSyntax] { get }
}

extension Array: UnexpectedNodesCombinable where Element: UnexpectedNodesCombinable {
  var elements: [RawSyntax] { self.flatMap { $0.elements } }
}

extension Optional: UnexpectedNodesCombinable where Wrapped: UnexpectedNodesCombinable {
  var elements: [RawSyntax] {
    if let self {
      return self.elements
    } else {
      return []
    }
  }
}

extension RawTokenSyntax: UnexpectedNodesCombinable {
  var elements: [RawSyntax] {
    return [RawSyntax(self)]
  }
}

extension RawUnexpectedNodesSyntax: UnexpectedNodesCombinable {}

extension RawUnexpectedNodesSyntax {
  init?(
    combining syntax1: some UnexpectedNodesCombinable,
    _ syntax2: some UnexpectedNodesCombinable,
    arena: __shared RawSyntaxArena
  ) {
    self.init(syntax1.elements + syntax2.elements, arena: arena)
  }

  init?(
    combining syntax1: some UnexpectedNodesCombinable,
    _ syntax2: some UnexpectedNodesCombinable,
    _ syntax3: some UnexpectedNodesCombinable,
    arena: __shared RawSyntaxArena
  ) {
    self.init(syntax1.elements + syntax2.elements + syntax3.elements, arena: arena)
  }

  init?(
    combining syntax1: some UnexpectedNodesCombinable,
    _ syntax2: some UnexpectedNodesCombinable,
    _ syntax3: some UnexpectedNodesCombinable,
    _ syntax4: some UnexpectedNodesCombinable,
    arena: __shared RawSyntaxArena
  ) {
    self.init(syntax1.elements + syntax2.elements + syntax3.elements + syntax4.elements, arena: arena)
  }
}

// MARK: - Converting nodes to unexpected nodes

extension RawSyntaxNodeProtocol {
  /// Select one node somewhere inside `self` and return a version of it with all of the other tokens in `self`
  /// converted to unexpected nodes.
  ///
  /// This is the same as ``RawSyntaxNodeProtocol/makeUnexpectedKeepingNodes(of:arena:where:makeMissing:)`` except that
  /// it always keeps, and always returns, exactly one node (the first one that would be encountered in a depth-first
  /// search, or the missing node). The other nodes that would have been kept are converted to unexpected tokens as
  /// usual. See that method for details about the behavior.
  ///
  /// - Parameters:
  ///   - keptType: The type of node that should be kept and returned.
  ///   - arena: The syntax arena to allocate new or copied nodes within.
  ///   - predicate: Should return `true` for the node that should be kept. Allows more selectivity than `keptType`
  ///     alone.
  ///   - makeMissing: If there are no children which satisfy `keptType` and `predicate`, this closure will be called
  ///     to create a substitute node for the unexpected syntax to be attached to. It's typically used to return a "missing syntax"
  ///     node, though that's not a technical requirement.
  ///
  /// - Returns: The kept node (or the missing node) with the other tokens in `self` attached to its leading and
  ///   trailing unexpected node children.
  func makeUnexpectedKeepingFirstNode<KeptNode: RawSyntaxNodeProtocol>(
    of keptType: KeptNode.Type,
    arena: RawSyntaxArena,
    where predicate: (KeptNode) -> Bool,
    makeMissing: () -> KeptNode
  ) -> KeptNode {
    var alreadyFoundFirst = false
    func compositePredicate(_ node: KeptNode) -> Bool {
      if alreadyFoundFirst || !predicate(node) {
        return false
      }
      alreadyFoundFirst = true
      return true
    }

    return makeUnexpectedKeepingNodes(
      of: keptType,
      arena: arena,
      where: compositePredicate,
      makeMissing: makeMissing
    ).first!
  }

  /// Select a number of nodes inside `self` and return versions of them with all of the other tokens in`self`
  /// attached to them as unexpected nodes.
  ///
  /// For instance, if you had a `RawIfConfigDeclSyntax` like this:
  ///
  /// ```swift
  /// #if FOO
  ///     func x() {}
  ///     func y() {}
  /// #elseif BAR
  ///     func a() {}
  ///     func b() {}
  /// #endif
  /// ```
  ///
  /// Then a call like this:
  ///
  /// ```swift
  /// let functions = directive.makeUnexpectedKeepingNodes(
  ///     of: RawFunctionDeclSyntax.self,
  ///     arena: parser.arena,
  ///     where: { node in true },
  ///     makeMissing: { RawFunctionDeclSyntax(...) }
  /// )
  /// ```
  ///
  /// Would return an array of four `RawFunctionDeclSyntax` nodes with the tokens for `#if FOO`, `#elseif BAR`, and
  /// `#endif` added to the nodes for `x()`, `a()`, and `b()` respectively.
  ///
  /// Specifically, this method performs a depth-first recursive search of the children of `self`, collecting nodes of
  /// type `keptType` for which `predicate` returns `true`. These nodes are then modified to add all of the tokens
  /// within `self`, but outside of the kept nodes, to their leading or trailing `RawUnexpectedNodesSyntax` child. If
  /// no kept nodes are found, the `makeMissing` closure is used to create a "missing syntax" node the tokens can be
  /// attached to.
  ///
  /// Tokens are usually added to the leading unexpected node child of the next kept node, except for tokens after the
  /// last kept node, which are added to the trailing unexpected node child of the last kept node.
  ///
  /// Token and collection nodes cannot be kept, as they cannot have unexpected syntax attached to them; however,
  /// parents of such nodes can be kept.
  ///
  /// - Parameters:
  ///   - keptType: The type of node that should be kept and returned in the array.
  ///   - arena: The syntax arena to allocate new or copied nodes within.
  ///   - predicate: Should return `true` for nodes that should be kept. Allows more selectivity than `keptType` alone.
  ///   - makeMissing: If there are no children which satisfy `keptType` and `predicate`, this closure will be called
  ///     to create a substitute node for the unexpected syntax to be attached to. It's typically used to return a "missing syntax"
  ///     node, though that's not a technical requirement.
  ///
  /// - Returns: The kept nodes (or the missing node) with the other tokens in `self` attached to them at appropriate
  ///   unexpected node children. Note that there is always at least one node in the array.
  func makeUnexpectedKeepingNodes<KeptNode: RawSyntaxNodeProtocol>(
    of keptType: KeptNode.Type,
    arena: RawSyntaxArena,
    where predicate: (KeptNode) -> Bool,
    makeMissing: () -> KeptNode
  ) -> [KeptNode] {
    var keptNodes: [KeptNode] = []
    var accumulatedTokens: [RawTokenSyntax] = []

    func attachAccumulatedTokensToLastKeptNode(appending: Bool) {
      if accumulatedTokens.isEmpty {
        // Nothing to add? Nothing to do.
        return
      }

      let lastKeptNodeIndex = keptNodes.endIndex - 1
      let lastKeptNode = keptNodes[lastKeptNodeIndex].raw.layoutView!

      let childIndex = appending ? lastKeptNode.children.endIndex - 1 : 0

      let newUnexpected: RawUnexpectedNodesSyntax
      if let oldUnexpected = lastKeptNode.children[childIndex]?.cast(RawUnexpectedNodesSyntax.self) {
        if appending {
          newUnexpected = RawUnexpectedNodesSyntax(combining: oldUnexpected, accumulatedTokens, arena: arena)!
        } else {
          newUnexpected = RawUnexpectedNodesSyntax(combining: accumulatedTokens, oldUnexpected, arena: arena)!
        }
      } else {
        newUnexpected = RawUnexpectedNodesSyntax(accumulatedTokens, arena: arena)!
      }

      keptNodes[lastKeptNodeIndex] = lastKeptNode.replacingChild(
        at: childIndex,
        with: newUnexpected.raw,
        arena: arena
      ).cast(KeptNode.self)

      accumulatedTokens.removeAll()
    }

    func walk(_ raw: RawSyntax) {
      if let token = RawTokenSyntax(raw) {
        if !token.isMissing {
          accumulatedTokens.append(token)
        }
      } else if !raw.kind.isSyntaxCollection, let node = raw.as(KeptNode.self), predicate(node) {
        keptNodes.append(node)
        attachAccumulatedTokensToLastKeptNode(appending: false)
      } else {
        for case let child? in raw.layoutView!.children {
          walk(child)
        }
      }
    }

    walk(self.raw)

    if keptNodes.isEmpty {
      keptNodes.append(makeMissing())
    }

    attachAccumulatedTokensToLastKeptNode(appending: true)

    return keptNodes
  }
}

// MARK: - Misc

extension SyntaxText {
  var isEditorPlaceholder: Bool {
    return self.starts(with: SyntaxText("<#")) && self.hasSuffix(SyntaxText("#>"))
  }

  var isStartingWithUppercase: Bool {
    if !self.isEmpty, let firstCharacterByte = self.baseAddress?.pointee {
      return 65 <= firstCharacterByte && firstCharacterByte <= 90
    } else {
      return false
    }
  }
}

extension RawTriviaPiece {
  var isIndentationWhitespace: Bool {
    switch self {
    case .spaces, .tabs: return true
    default: return false
    }
  }
}
