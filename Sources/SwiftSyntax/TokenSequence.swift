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

extension Syntax {
  /// Implementation of 'SyntaxProtocol.previousToken(viewMode:)'
  func previousToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parentDataRef = data.parent else {
      return nil
    }
    for case let childDataRef? in arena.layout(for: parentDataRef)[..<layoutIndexInParent].reversed() {
      if let token = Syntax(arena: arena, dataRef: childDataRef).lastToken(viewMode: viewMode) {
        return token
      }
    }
    return Syntax(arena: arena, dataRef: parentDataRef).previousToken(viewMode: viewMode)
  }

  /// Implementation of 'SyntaxProtocol.nextToken(viewMode:)'
  func nextToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parentDataRef = data.parent else {
      return nil
    }
    for case let childDataRef? in arena.layout(for: parentDataRef)[(layoutIndexInParent &+ 1)...] {
      if let token = Syntax(arena: arena, dataRef: childDataRef).firstToken(viewMode: viewMode) {
        return token
      }
    }
    return Syntax(arena: arena, dataRef: parentDataRef).nextToken(viewMode: viewMode)
  }

  /// Implementation of 'SyntaxProtocol.firstToken(viewMode:)'
  ///
  /// - Note: Can't use 'RawSyntax.firstToken(viewMode:)' because it loses absolute info.
  func firstToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else {
      return nil
    }
    if raw.isToken {
      return TokenSyntax(self)!
    }
    for case let childDataRef? in layoutBuffer {
      if let token = Syntax(arena: arena, dataRef: childDataRef).firstToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }

  /// Implementation of 'SyntaxProtocol.lastToken(viewMode:)'
  ///
  /// - Note: Can't use 'RawSyntax.lastToken(viewMode:)' because it loses absolute info.
  func lastToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else {
      return nil
    }
    if raw.isToken {
      return TokenSyntax(self)!
    }
    for case let childDataRef? in layoutBuffer.reversed() {
      if let token = Syntax(arena: arena, dataRef: childDataRef).lastToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }
}

/// Sequence of tokens that are part of the provided Syntax node.
public struct TokenSequence: Sequence, Sendable {
  /// Iterates over a ``TokenSequence``.
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    /// The last token to iterate (inclusive).
    let endToken: TokenSyntax?
    let viewMode: SyntaxTreeViewMode

    init(_ token: TokenSyntax?, endToken: TokenSyntax?, viewMode: SyntaxTreeViewMode) {
      self.nextToken = token
      self.endToken = endToken
      self.viewMode = viewMode
    }

    /// Return the next element in a ``TokenSequence``.
    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      if nextToken == endToken {
        self.nextToken = nil
      } else {
        self.nextToken = token.nextToken(viewMode: viewMode)
      }
      return token
    }
  }

  let node: Syntax
  let viewMode: SyntaxTreeViewMode

  /// Construct a ``TokenSequence`` that walks all tokens in `node` in source order,
  /// recursively walking into child nodes.
  ///
  /// All nodes that are not visible in the given `viewMode` are skipped.
  public init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.node = node
    self.viewMode = viewMode
  }

  /// Create an iterator that iterates over all the tokens in the sequence.
  public func makeIterator() -> Iterator {
    return Iterator(
      node.firstToken(viewMode: viewMode),
      endToken: node.lastToken(viewMode: viewMode),
      viewMode: viewMode
    )
  }

  /// Iterate the tokens in reverse order.
  public func reversed() -> ReversedTokenSequence {
    return ReversedTokenSequence(node, viewMode: viewMode)
  }
}

extension TokenSequence: CustomReflectable {
  /// A custom mirror for ``TokenSequence`` that shows all elements in the sequence.
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map { $0 })
  }
}

/// Reverse sequence of tokens that are part of the provided Syntax node.
public struct ReversedTokenSequence: Sequence, Sendable {
  /// Iterates over a ``ReversedTokenSequence``.
  public struct Iterator: IteratorProtocol {
    var nextToken: TokenSyntax?
    let startPosition: AbsolutePosition
    let viewMode: SyntaxTreeViewMode

    init(_ token: TokenSyntax?, startPosition: AbsolutePosition, viewMode: SyntaxTreeViewMode) {
      self.nextToken = token
      self.startPosition = startPosition
      self.viewMode = viewMode
    }

    /// Returns the next element in a ``ReversedTokenSequence``, i.e. the one
    /// that occurred before the current token in source order.
    public mutating func next() -> TokenSyntax? {
      guard let token = self.nextToken else { return nil }
      self.nextToken = token.previousToken(viewMode: viewMode)
      // Make sure we stop once we went beyond the start of the containing node.
      if let nextTok = self.nextToken, nextTok.position < self.startPosition {
        self.nextToken = nil
      }
      return token
    }
  }

  let node: Syntax
  let viewMode: SyntaxTreeViewMode

  /// Construct a ``TokenSequence`` that walks all tokens in `node` in reverse
  /// source order, recursively walking into child nodes.
  ///
  /// All nodes that are not visible in the given `viewMode` are skipped.
  public init(_ node: Syntax, viewMode: SyntaxTreeViewMode) {
    self.node = node
    self.viewMode = viewMode
  }

  /// Create an iterator that iterates over all the tokens in the sequence.
  public func makeIterator() -> Iterator {
    return Iterator(node.lastToken(viewMode: viewMode), startPosition: node.position, viewMode: viewMode)
  }

  /// Iterate over the tokens in source order.
  public func reversed() -> TokenSequence {
    return TokenSequence(node, viewMode: viewMode)
  }
}

extension ReversedTokenSequence: CustomReflectable {
  /// A custom mirror for ``ReversedTokenSequence`` that shows all elements in the sequence.
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: self.map { $0 })
  }
}
