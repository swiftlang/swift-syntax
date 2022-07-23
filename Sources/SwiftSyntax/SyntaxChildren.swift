//===------------- SyntaxChildren.swift - Syntax Child Iterator -----------===//
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

// MARK: - Index

/// An index in a syntax children collection.
public struct SyntaxChildrenIndex: Comparable {
  fileprivate var data: SyntaxData?

  internal init(_ data: SyntaxData?) {
    // 'nil' for endIndex, otherwise it must not be a root node.
    assert(data == nil || data!.indexInParent != nil)
    self.data = data
  }

  public static func < (lhs: SyntaxChildrenIndex, rhs: SyntaxChildrenIndex)
      -> Bool {
    switch (lhs.data, rhs.data) {
    case (.some(let lhsData), .some(let rhsData)):
      return lhsData.indexInParent! < rhsData.indexInParent!
    case (.some(_), .none):
      return true
    case (.none, .some(_)):
      return false
    case (.none, .none):
      return false
    }
  }
}

// MARK: - Collections

/// Collection that contains the child nodes of a node, including missing nodes.
public struct SyntaxChildren: BidirectionalCollection {
  public typealias Index = SyntaxChildrenIndex
  public typealias Element = Syntax

  /// The parent node of the children. Used to build the `Syntax` nodes.
  private let parent: SyntaxData

  init(in parent: Syntax) {
    self.parent = parent.data
  }

  public var startIndex: SyntaxChildrenIndex { return Index(parent.firstNonNilChild) }
  public var endIndex: SyntaxChildrenIndex { return Index(nil) }

  public func index(before i: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    Index(i.data.flatMap { $0.previousSibling } ?? parent.lastNonNilChild)
  }
  public func index(after i: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
    Index(i.data.flatMap { $0.nextSibling })
  }

  public subscript(position: SyntaxChildrenIndex) -> Syntax {
    get { Syntax(data: position.data!) }
  }
}
