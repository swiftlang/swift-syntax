//===--- RawSyntaxLayoutView.swift ----------------------------------------===//
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

extension RawSyntax {
  /// A view into the `RawSyntax` that exposes functionality that's specific to layout nodes.
  /// The token's payload must be a layout, otherwise this traps.
  var layoutView: RawSyntaxLayout {
    return RawSyntaxLayout(raw: self)
  }
}

/// A view into `RawSyntax` that exposes functionality that only applies to layout nodes.
struct RawSyntaxLayout {
  private let raw: RawSyntax

  fileprivate init(raw: RawSyntax) {
    self.raw = raw
    switch raw.payload {
    case .parsedToken, .materializedToken:
      preconditionFailure("RawSyntax must be a layout")
    case .layout(_):
      break
    }
  }

  /// Creates a new node of the same kind but with children replaced by `elements`.
  func replacingLayout<C: Collection>(
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    return .makeLayout(kind: raw.kind,
                       uninitializedCount: elements.count,
                       arena: arena) { buffer in
      if buffer.isEmpty { return }
      _ = buffer.initialize(from: elements)
    }
  }

  func insertingChild(
    _ newChild: RawSyntax?,
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(raw.children.count >= index)
    return .makeLayout(kind: raw.kind,
                       uninitializedCount: raw.children.count + 1,
                       arena: arena) { buffer in
      var childIterator = raw.children.makeIterator()
      let base = buffer.baseAddress!
      for i in 0..<buffer.count {
        base.advanced(by: i)
          .initialize(to: i == index ? newChild : childIterator.next()!)
      }
    }
  }

  func removingChild(
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(raw.children.count > index)
    let count = raw.children.count - 1
    return .makeLayout(kind: raw.kind,
                       uninitializedCount: count,
                       arena: arena) { buffer in
      if buffer.isEmpty { return }
      let newBase = buffer.baseAddress!
      let oldBase = raw.children.baseAddress!

      // Copy elements up to the index.
      newBase.initialize(from: oldBase, count: index)

      // Copy elements from the index + 1.
      newBase.advanced(by: index)
        .initialize(from: oldBase.advanced(by: index + 1),
                    count: raw.children.count - index - 1)
    }
  }

  func appending(_ newChild: RawSyntax?, arena: SyntaxArena) -> RawSyntax {
    insertingChild(newChild, at: raw.children.count, arena: arena)
  }

  /// Creates a new RawSyntax with the provided child appended to its layout.
  /// - Parameter child: The child to append
  /// - Note: This function does nothing with `.token` nodes --- the same token
  ///         is returned.
  /// - Return: A new RawSyntax node with the provided child at the end.
  // @available(*, deprecated, message: "use 'appending(_:arena:)'")
  func appending(_ child: RawSyntax?) -> RawSyntax {
    if raw.isToken { return raw }
    return insertingChild(child, at: raw.children.count, arena: raw.arena)
  }

  func replacingChildSubrange<C: Collection>(
    _ range: Range<Int>,
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    precondition(!raw.isToken)
    let newCount = raw.children.count - range.count + elements.count
    return .makeLayout(kind: raw.kind,
                       uninitializedCount: newCount,
                       arena: arena) { buffer in
      if buffer.isEmpty { return }
      var current = buffer.baseAddress!

      // Intialize
      current.initialize(from: raw.children.baseAddress!, count: range.lowerBound)
      current = current.advanced(by: range.lowerBound)
      for elem in elements {
        current.initialize(to: elem)
        current += 1
      }
      current.initialize(from: raw.children.baseAddress!.advanced(by: range.upperBound),
                         count: raw.children.count - range.upperBound)
    }
  }

  func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(!raw.isToken && raw.children.count > index)
    return .makeLayout(kind: raw.kind,
                       uninitializedCount: raw.children.count,
                       arena: arena) { buffer in
      _ = buffer.initialize(from: raw.children)
      buffer[index] = newChild
    }
  }
}

