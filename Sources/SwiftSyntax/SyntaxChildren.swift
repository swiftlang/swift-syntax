//===------------- SyntaxChildren.swift - Syntax Child Iterator -----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Sequence over the layout children nodes of a raw node, that also provides
/// its associated `AbsoluteSyntaxInfo`.
struct RawSyntaxChildren: Sequence {
  struct Iterator: IteratorProtocol {
    let parent: RawSyntax
    var nextChildInfo: AbsoluteSyntaxInfo

    init(parent: AbsoluteRawSyntax) {
      self.init(parent: parent.raw,
        startFrom: parent.info.advancedToFirstChild())
    }

    init(parent: RawSyntax, startFrom: AbsoluteSyntaxInfo) {
      self.parent = parent
      self.nextChildInfo = startFrom
    }

    mutating func next() -> (RawSyntax?, AbsoluteSyntaxInfo)? {
      let idx = Int(nextChildInfo.indexInParent)
      guard idx < parent.numberOfChildren else {
        return nil
      }
      let child = parent.child(at: idx)
      let thisItem = (child, nextChildInfo)
      nextChildInfo = nextChildInfo.advancedBySibling(child)
      return thisItem
    }
  }

  private let node: AbsoluteRawSyntax

  init(_ absoluteRaw: AbsoluteRawSyntax) {
    self.node = absoluteRaw
  }

  init(_ base: _SyntaxBase) {
    self.init(base.data.absoluteRaw)
  }

  func makeIterator() -> Iterator {
    return .init(parent: node)
  }
}

protocol AbsoluteRawSyntaxIteratorProtocol:
  IteratorProtocol where Element == AbsoluteRawSyntax {
}

/// Sequence of `AbsoluteRawSyntax` formed from all the `present` layout
/// children nodes of a raw node.
struct PresentRawSyntaxChildren: Sequence {
  struct Iterator: AbsoluteRawSyntaxIteratorProtocol {
    var iterator: RawSyntaxChildren.Iterator

    init(parent: AbsoluteRawSyntax) {
      self.init(parent: parent.raw,
        startFrom: parent.info.advancedToFirstChild())
    }

    init(parent: RawSyntax, startFrom: AbsoluteSyntaxInfo) {
      self.iterator = .init(parent: parent, startFrom: startFrom)
    }

    mutating func next() -> AbsoluteRawSyntax? {
      while true {
        guard let (node, info) = self.iterator.next() else {
          return nil
        }
        if let n = node, n.isPresent {
          return AbsoluteRawSyntax(raw: n, info: info)
        }
      }
    }
  }

  private let node: AbsoluteRawSyntax

  init(_ absoluteRaw: AbsoluteRawSyntax) {
    self.node = absoluteRaw
  }

  init(_ base: _SyntaxBase) {
    self.init(base.data.absoluteRaw)
  }

  func makeIterator() -> Iterator {
    return .init(parent: node)
  }
}

/// Reversed Sequence of `PresentRawSyntaxChildren`.
struct ReversedPresentRawSyntaxChildren: Sequence {
  struct Iterator: AbsoluteRawSyntaxIteratorProtocol {
    let parent: RawSyntax
    var previousChildInfo: AbsoluteSyntaxInfo

    init(parent: AbsoluteRawSyntax) {
      self.init(parent: parent.raw,
        endsOn: parent.info.advancedToEndOfChildren(parent.raw))
    }

    init(parent: RawSyntax, endsOn: AbsoluteSyntaxInfo) {
      self.parent = parent
      self.previousChildInfo = endsOn
    }

    mutating func next() -> AbsoluteRawSyntax? {
      while true {
        let prevIdx = Int(previousChildInfo.indexInParent)
        guard prevIdx > 0 else {
          return nil
        }
        let child = parent.child(at: prevIdx-1)
        previousChildInfo = previousChildInfo.reversedBySibling(child)
        if let n = child, n.isPresent {
          return AbsoluteRawSyntax(raw: n, info: previousChildInfo)
        }
      }
    }
  }

  private let node: AbsoluteRawSyntax

  init(_ absoluteRaw: AbsoluteRawSyntax) {
    self.node = absoluteRaw
  }

  init(_ base: _SyntaxBase) {
    self.init(base.data.absoluteRaw)
  }

  func makeIterator() -> Iterator {
    return .init(parent: node)
  }
}

/// Sequence of the sibling nodes following the provided node.
struct PresentRawSyntaxNextSiblings: Sequence {
  typealias Iterator = PresentRawSyntaxChildren.Iterator

  private let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  func makeIterator() -> Iterator {
    let rawParent = node.parent!.raw
    let absoluteRaw = node.data.absoluteRaw
    return .init(parent: rawParent,
      startFrom: absoluteRaw.info.advancedBySibling(absoluteRaw.raw))
  }
}

/// Sequence of the sibling nodes preceding the provided node, in reverse order.
struct PresentRawSyntaxPreviousSiblings: Sequence {
  typealias Iterator = ReversedPresentRawSyntaxChildren.Iterator

  private let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  func makeIterator() -> Iterator {
    let rawParent = node.parent!.raw
    let absoluteRaw = node.data.absoluteRaw
    return .init(parent: rawParent, endsOn: absoluteRaw.info)
  }
}

/// Sequence of present children nodes of the provided `_SyntaxBase` node.
struct SyntaxBaseChildren: Sequence {
  struct Iterator: IteratorProtocol {
    let parent: _SyntaxBase
    var iterator: PresentRawSyntaxChildren.Iterator

    init(node: _SyntaxBase) {
      self.iterator = .init(parent: node.data.absoluteRaw)
      self.parent = node
    }

    mutating func next() -> _SyntaxBase? {
      guard let absoluteRaw = iterator.next() else { return nil }
      let data = SyntaxData(absoluteRaw, parent: self.parent)
      return makeSyntax(data)
    }
  }

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  func makeIterator() -> Iterator {
    return Iterator(node: node)
  }

  func reversed() -> ReversedSyntaxBaseChildren {
    return ReversedSyntaxBaseChildren(node)
  }
}

/// Reversed Sequence of `SyntaxBaseChildren`.
struct ReversedSyntaxBaseChildren: Sequence {
  struct Iterator: IteratorProtocol {
    let parent: _SyntaxBase
    var iterator: ReversedPresentRawSyntaxChildren.Iterator

    init(node: _SyntaxBase) {
      self.iterator = .init(parent: node.data.absoluteRaw)
      self.parent = node
    }

    mutating func next() -> _SyntaxBase? {
      guard let absoluteRaw = iterator.next() else { return nil }
      let data = SyntaxData(absoluteRaw, parent: self.parent)
      return makeSyntax(data)
    }
  }

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  func makeIterator() -> Iterator {
    return Iterator(node: node)
  }

  func reversed() -> SyntaxBaseChildren {
    return SyntaxBaseChildren(node)
  }
}

/// Sequence of present children nodes of the provided `Syntax` node.
public struct SyntaxChildren: Sequence {
  public struct Iterator: IteratorProtocol {
    var iterator: SyntaxBaseChildren.Iterator

    init(node: _SyntaxBase) {
      self.iterator = .init(node: node)
    }

    public mutating func next() -> Syntax? {
      return iterator.next()
    }
  }

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  public init(_ node: Syntax) {
    self.node = node.base
  }

  public func makeIterator() -> Iterator {
    return Iterator(node: node)
  }

  public func reversed() -> ReversedSyntaxChildren {
    return ReversedSyntaxChildren(node)
  }
}

/// Reversed Sequence of `SyntaxChildren`.
public struct ReversedSyntaxChildren: Sequence {
  public struct Iterator: IteratorProtocol {
    var iterator: ReversedSyntaxBaseChildren.Iterator

    init(node: _SyntaxBase) {
      self.iterator = .init(node: node)
    }

    public mutating func next() -> Syntax? {
      return iterator.next()
    }
  }

  let node: _SyntaxBase

  init(_ node: _SyntaxBase) {
    self.node = node
  }

  public init(_ node: Syntax) {
    self.node = node.base
  }

  public func makeIterator() -> Iterator {
    return Iterator(node: node)
  }

  public func reversed() -> SyntaxChildren {
    return SyntaxChildren(node)
  }
}
