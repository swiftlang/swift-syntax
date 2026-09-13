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

extension RawSyntax {
  /// A view into the ``RawSyntax`` that exposes functionality that's specific to layout nodes.
  /// The token's payload must be a layout, otherwise this traps.
  @_spi(RawSyntax)
  public var layoutView: RawSyntaxLayoutView? {
    switch header {
    case .smolParsedToken, .parsedToken, .materializedToken:
      return nil
    case .flat, .layout, .layoutWithUnexpected:
      return RawSyntaxLayoutView(raw: self)
    }
  }
}

/// A view into ``RawSyntax`` that exposes functionality that only applies to layout nodes.
@_spi(RawSyntax)
public struct RawSyntaxLayoutView {
  private let raw: RawSyntax

  fileprivate init(raw: RawSyntax) {
    self.raw = raw
    switch raw.header {
    case .smolParsedToken, .parsedToken, .materializedToken:
      preconditionFailure("RawSyntax must be a layout")
    case .flat, .layout, .layoutWithUnexpected:
      break
    }
  }

  var recursiveFlags: RecursiveRawSyntaxFlags {
    return raw.asLayout.recursiveFlags
  }

  /// Creates a new node of the same kind but with children replaced by `elements`.
  ///
  /// The newly created syntax node is allocated in `arena`.
  @_spi(RawSyntax)
  public func replacingLayout(
    with elements: some Collection<RawSyntax?>,
    arena: RawSyntaxArena
  ) -> RawSyntax {
    return .makeLayout(
      kind: raw.kind,
      uninitializedCount: elements.count,
      arena: arena
    ) { buffer in
      if buffer.isEmpty { return }
      _ = buffer.initialize(from: elements)
    }
  }

  @_spi(RawSyntax)
  public func insertingChild(
    _ newChild: RawSyntax?,
    at index: Int,
    arena: RawSyntaxArena
  ) -> RawSyntax {
    precondition(children.count >= index)
    return .makeLayout(
      kind: raw.kind,
      uninitializedCount: children.count + 1,
      arena: arena
    ) { buffer in
      let children = self.children
      var source = 0
      for i in 0..<buffer.count {
        if i == index {
          buffer.initializeElement(at: i, to: newChild)
        } else {
          buffer.initializeElement(at: i, to: children[source])
          source += 1
        }
      }
    }
  }

  @_spi(RawSyntax)
  public func removingChild(
    at index: Int,
    arena: RawSyntaxArena
  ) -> RawSyntax {
    precondition(children.count > index)
    let count = children.count - 1
    return .makeLayout(
      kind: raw.kind,
      uninitializedCount: count,
      arena: arena
    ) { buffer in
      if buffer.isEmpty { return }
      let children = self.children
      // Everything before the index, then everything after it.
      for i in 0..<index {
        buffer.initializeElement(at: i, to: children[i])
      }
      for i in index..<count {
        buffer.initializeElement(at: i, to: children[i + 1])
      }
    }
  }

  @_spi(RawSyntax)
  public func appending(_ newChild: RawSyntax?, arena: RawSyntaxArena) -> RawSyntax {
    insertingChild(newChild, at: children.count, arena: arena)
  }

  @_spi(RawSyntax)
  public func replacingChildSubrange(
    _ range: Range<Int>,
    with elements: some Collection<RawSyntax?>,
    arena: RawSyntaxArena
  ) -> RawSyntax {
    precondition(!raw.isToken)
    let newCount = children.count - range.count + elements.count
    return .makeLayout(
      kind: raw.kind,
      uninitializedCount: newCount,
      arena: arena
    ) { buffer in
      if buffer.isEmpty { return }
      let children = self.children
      var next = 0
      for i in 0..<range.lowerBound {
        buffer.initializeElement(at: next, to: children[i])
        next += 1
      }
      for elem in elements {
        buffer.initializeElement(at: next, to: elem)
        next += 1
      }
      for i in range.upperBound..<children.count {
        buffer.initializeElement(at: next, to: children[i])
        next += 1
      }
    }
  }

  @_spi(RawSyntax)
  public func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    arena: RawSyntaxArena
  ) -> RawSyntax {
    precondition(!raw.isToken && children.count > index)
    return .makeLayout(
      kind: raw.kind,
      uninitializedCount: children.count,
      arena: arena
    ) { buffer in
      _ = buffer.initialize(from: children)
      buffer[index] = newChild
    }
  }

  @_spi(RawSyntax)
  public func formLayoutArray() -> [RawSyntax?] {
    Array(children)
  }

  /// Child nodes.
  @_spi(RawSyntax)
  public var children: RawLayoutChildren {
    raw.logicalChildren
  }
}

/// A layout node's children as the tree describes them: an `unexpected` slot
/// before the first child, between each pair and after the last, for the kinds
/// that interleave them.
///
/// A node that has nothing unexpected in it keeps no room for those slots, so
/// they are not read from memory but answered as nil. Indices here are the ones
/// the tree is described by and the generated accessors used before the shapes
/// diverged; where a child physically sits is this type's business.
@_spi(RawSyntax)
public struct RawLayoutChildren: RandomAccessCollection {
  public typealias Element = RawSyntax?
  public typealias Index = Int

  /// The real children, in source order.
  private let real: UnsafeBufferPointer<RawSyntax?>

  /// The `unexpected` slots, or empty when the node kept no room for them.
  private let unexpected: UnsafeBufferPointer<RawSyntax?>

  /// Whether this node's kind interleaves `unexpected` slots with its children.
  private let interleaves: Bool

  init(
    real: UnsafeBufferPointer<RawSyntax?>,
    unexpected: UnsafeBufferPointer<RawSyntax?>,
    interleaves: Bool
  ) {
    self.real = real
    self.unexpected = unexpected
    self.interleaves = interleaves
  }

  public var startIndex: Int { 0 }

  public var endIndex: Int { self.interleaves ? 2 * self.real.count + 1 : self.real.count }

  public subscript(position: Int) -> RawSyntax? {
    precondition(position >= 0 && position < self.endIndex)
    guard self.interleaves else {
      return self.real[position]
    }
    if position % 2 == 1 {
      return self.real[(position - 1) / 2]
    }
    let slot = position / 2
    return slot < self.unexpected.count ? self.unexpected[slot] : nil
  }
}

extension RawSyntaxLayoutView {
  /// The `index`th real child, counting only the node's own children and not the
  /// `unexpected` slots between them.
  ///
  /// Real children come first in a node's slots whichever shape it has, so this
  /// is the same load either way — which is why the generated accessors use it
  /// rather than an index into the layout as the tree describes it.
  @_spi(RawSyntax)
  @inline(__always)
  public func realChild(at index: Int) -> RawSyntax? {
    let (base, childCount) = raw.slotBase
    precondition(index >= 0 && index < childCount)
    return base[index]
  }

  /// The `index`th `unexpected` slot, or `nil` for a node that kept no room for
  /// them, which is almost every node.
  @_spi(RawSyntax)
  @inline(__always)
  public func unexpectedSlot(at index: Int) -> RawSyntax? {
    switch raw.header {
    case .layoutWithUnexpected:
      let (base, childCount) = raw.slotBase
      precondition(index >= 0 && index <= childCount)
      return base[childCount + index]
    case .flat, .layout:
      return nil
    case .smolParsedToken, .parsedToken, .materializedToken:
      preconditionFailure("not a layout node")
    }
  }
}
