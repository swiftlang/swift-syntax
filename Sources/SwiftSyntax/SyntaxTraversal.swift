//===------------ SyntaxTraversal.swift - Syntax Tree Walking -------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Traverse the tree in the source order.
///
/// APIs to visit "next" or "previous" token in the source order. For example,
/// given a tree like this:
///
///   [root]
///     +- [a]
///     |   +- [b]
///     |   |   |- [c]
///     |   |   `- [d]
///     |   `- [e]
///     |       `- [f]
///     `- [g]
///
/// The order of the traversal is `[root, a, b, c, d, e, f, g]`. A node's
/// `indexInTree` is index like so.
///
/// - `findNext(where:)`/`findPrevious(where:)`: find the next/previous node
///   that matches the criteria.
/// - `nextToken`/`previousToken`: find the next/previous token node.
/// - `findFirst(where:)`/`findLast(where:)`: find the first/last node
///   that matches the criteria _inside_ this node.
/// - `firstToken`/`lastToken`: find the first/last token node _inside this
///   node. NOTE: if the node itself is a token, returns `self`.
extension SyntaxProtocol {
  public var nextNode: Syntax? {
    data.nextNode.map(Syntax.init(data:))
  }

  public var previousNode: Syntax? {
    data.previousNode.map(Syntax.init(data:))
  }

  public var nextSibling: Syntax? {
    data.nextSibling.map(Syntax.init(data:))
  }

  public var previousSibling: Syntax? {
    data.previousSibling.map(Syntax.init(data:))
  }

  public var nextAncestorSibling: Syntax? {
    data.nextAncestorSibling.map(Syntax.init(data:))
  }

  public var previousAncestorSibling: Syntax? {
    data.previousAncestorSibling.map(Syntax.init(data:))
  }
  public var firstNonNilChild: Syntax? {
    data.firstNonNilChild.map(Syntax.init(data:))
  }

  public var lastNonNilChild: Syntax? {
    data.lastNonNilChild.map(Syntax.init(data:))
  }

  public func findNext(where testFn: (Syntax) -> Bool) -> Syntax? {
    var current = nextNode
    while let cur = current, !testFn(cur) {
      current = cur.nextNode
    }
    return current
  }

  public func findPrevious(where testFn: (Syntax) -> Bool) -> Syntax? {
    var current = previousNode
    while let cur = current, !testFn(cur) {
      current = cur.previousNode
    }
    return current
  }

  /// Recursively walks through the tree to find the token semantically after
  /// this node.
  public var previousToken: TokenSyntax? {
    findPrevious(where: { $0.isToken })
      .map({ TokenSyntax(data: $0.data) })
  }

  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  public var nextToken: TokenSyntax? {
    findNext(where: { $0.isToken })
      .map({ TokenSyntax(data: $0.data) })
  }

  /// Find first matching node _inside_ the current node.
  public func findFirst(where testFn: (Syntax) -> Bool) -> Syntax? {
    let terminal = self.indexInTree + self.data.nodeCount

    var current = firstNonNilChild
    while let cur = current, cur.indexInTree < terminal {
      // If the current node satisfies the conditon, we're done.
      if testFn(cur) { return cur }
      current = cur.nextNode
    }
    return nil
  }

  /// Find last matching node _inside_ the current node.
  public func findLast(where testFn: (Syntax) -> Bool) -> Syntax? {
    let terminal = self.indexInTree

    var current = lastNonNilChild
    while let cur = current, cur.indexInTree > terminal {
      if testFn(cur) { return cur }
      current = cur.previousNode
    }
    return nil
  }

  public var firstToken: TokenSyntax? {
    if let token = TokenSyntax(self) { return token }
    return findFirst(where: { $0.isToken }).map { TokenSyntax(data: $0.data) }
  }

  public var lastToken: TokenSyntax? {
    if let token = TokenSyntax(self) { return token }
    return findLast(where: { $0.isToken }).map { TokenSyntax(data: $0.data) }
  }

  /// Sequence of tokens that are part of the node.
  public var tokens: TokenSequence {
    TokenSequence(self)
  }
}

/// Sequence of tokens that are part of the provided Syntax node.
public struct TokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    public typealias Element = TokenSyntax
    private var pending: TokenSyntax?

    // Note: We should not use 'byteOffset' as an terminal
    // because there might be zero width tokens after this in the node.
    private var endIndexInTree: Int

    init(pending: TokenSyntax?, endIndexInTree: Int) {
      self.pending = pending
      self.endIndexInTree = endIndexInTree
    }

    public func peek() -> Element? {
      return pending
    }

    public mutating func next() -> Element? {
      defer {
        if let next = self.pending?.nextToken, next.data.indexInTree < endIndexInTree {
          self.pending = next
        } else {
          self.pending = nil
        }
      }
      return pending
    }
  }

  var node: Syntax
  init(_ node: Syntax) { self.node = node }
  init<Node: SyntaxProtocol>(_ node: Node) { self.node = node.syntax }

  public func makeIterator() -> Iterator {
    Iterator(
      pending: node.firstToken,
      endIndexInTree: node.data.indexInTree + node.data.nodeCount)
  }

  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node)
  }
}

extension TokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: Array(self))
  }
}

/// Sequence of tokens that are part of the provided Syntax node.
public struct ReversedTokenSequence: Sequence {
  public struct Iterator: IteratorProtocol {
    public typealias Element = TokenSyntax
    private var pending: TokenSyntax?

    // Note: We should not use 'byteOffset' as an terminal
    // because there might be zero width tokens after this in the node.
    private var endIndexInTree: Int

    init(pending: TokenSyntax?, endIndexInTree: Int) {
      self.pending = pending
      self.endIndexInTree = endIndexInTree
    }

    public func peek() -> Element? {
      return pending
    }

    public mutating func next() -> Element? {
      defer {
        if let next = self.pending?.previousToken, next.data.indexInTree >= endIndexInTree {
          self.pending = next
        } else {
          self.pending = nil
        }
      }
      return pending
    }
  }

  var node: Syntax
  init(_ node: Syntax) { self.node = node }
  init<Node: SyntaxProtocol>(_ node: Node) { self.node = node.syntax }

  public func makeIterator() -> Iterator {
    Iterator(
      pending: node.lastToken,
      endIndexInTree: node.data.indexInTree)
  }

  public func reversed() -> TokenSequence {
    return TokenSequence(node)
  }
}

extension ReversedTokenSequence: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: Array(self))
  }
}
