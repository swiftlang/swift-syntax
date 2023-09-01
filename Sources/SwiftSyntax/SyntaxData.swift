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

/// SyntaxData is the underlying storage for each Syntax node.
///
/// SyntaxData is an implementation detail, and should not be exposed to clients
/// of SwiftSyntax.
struct SyntaxData {
  fileprivate enum Info {
    case root(Root)
    indirect case nonRoot(NonRoot)

    // For root node.
    struct Root {
      var arena: SyntaxArena
    }

    // For non-root nodes.
    struct NonRoot {
      var parent: SyntaxData
      var absoluteInfo: AbsoluteSyntaxInfo
    }
  }

  private let info: Info
  let raw: RawSyntax

  private var rootInfo: Info.Root {
    switch info {
    case .root(let info): return info
    case .nonRoot(let info): return info.parent.rootInfo
    }
  }

  private var nonRootInfo: Info.NonRoot? {
    switch info {
    case .root(_): return nil
    case .nonRoot(let info): return info
    }
  }

  private var root: SyntaxData {
    switch info {
    case .root(_): return self
    case .nonRoot(let info): return info.parent.root
    }
  }

  var parent: SyntaxData? {
    nonRootInfo?.parent
  }

  var absoluteInfo: AbsoluteSyntaxInfo {
    nonRootInfo?.absoluteInfo ?? .forRoot(raw)
  }

  var absoluteRaw: AbsoluteRawSyntax {
    AbsoluteRawSyntax(raw: raw, info: absoluteInfo)
  }

  var indexInParent: Int {
    Int(absoluteInfo.indexInParent)
  }

  var nodeId: SyntaxIdentifier {
    absoluteInfo.nodeId
  }

  /// The position of the start of this node's leading trivia
  var position: AbsolutePosition {
    AbsolutePosition(utf8Offset: Int(absoluteInfo.offset))
  }

  /// The position of the start of this node's content, skipping its trivia
  var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return position + raw.leadingTriviaLength
  }

  /// The end position of this node's content, before any trailing trivia.
  var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return endPosition - raw.trailingTriviaLength
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    position + raw.totalLength
  }

  /// "designated" memberwise initializer of `SyntaxData`.
  private init(_ raw: RawSyntax, info: Info) {
    self.raw = raw
    self.info = info
  }

  init(_ raw: RawSyntax, parent: SyntaxData, absoluteInfo: AbsoluteSyntaxInfo) {
    self.init(raw, info: .nonRoot(.init(parent: parent, absoluteInfo: absoluteInfo)))
  }

  /// Creates a `SyntaxData` with the provided raw syntax and parent.
  /// - Parameters:
  ///   - absoluteRaw: The underlying `AbsoluteRawSyntax` of this node.
  ///   - parent: The parent of this node, or `nil` if this node is the root.
  init(_ absoluteRaw: AbsoluteRawSyntax, parent: Syntax) {
    self.init(absoluteRaw.raw, parent: parent.data, absoluteInfo: absoluteRaw.info)
  }

  /// Creates a ``SyntaxData`` for a root raw node.
  ///
  /// - Parameters:
  ///   - raw: The raw node that will be the root of the tree
  ///   - rawNodeArena: The arena in which `raw` is allocated. It is passed to
  ///     make sure the arena doesn’t get de-allocated before the ``SyntaxData``
  ///     has a chance to retain it.
  static func forRoot(_ raw: RawSyntax, rawNodeArena: SyntaxArena) -> SyntaxData {
    precondition(rawNodeArena === raw.arena)
    return SyntaxData(raw, info: .root(.init(arena: rawNodeArena)))
  }

  /// Returns the child data at the provided index in this data's layout.
  /// - Note: This has O(n) performance, prefer using a proper Sequence type
  ///         if applicable, instead of this.
  /// - Note: This function traps if the index is out of the bounds of the
  ///         data's layout.
  ///
  /// - Parameter index: The index to create and cache.
  /// - Returns: The child's data at the provided index.
  func child(at index: Int) -> SyntaxData? {
    if raw.layoutView!.children[index] == nil { return nil }
    var iter = RawSyntaxChildren(absoluteRaw).makeIterator()
    for _ in 0..<index { _ = iter.next() }
    let (raw, info) = iter.next()!
    return SyntaxData(raw!, parent: self, absoluteInfo: info)
  }

  /// Creates a copy of `self` and recursively creates `SyntaxData` nodes up to
  /// the root.
  ///
  /// - Parameters:
  ///   - newRaw: The node that should replace `self`
  ///   - rawNodeArena: The arena in which `newRaw` resides
  ///   - allocationArena: The arena in which  new nodes should be allocated
  /// - Returns: A syntax tree with all parents where this node has been
  ///            replaced by `newRaw`
  func replacingSelf(_ newRaw: RawSyntax, rawNodeArena: SyntaxArena, allocationArena: SyntaxArena) -> SyntaxData {
    precondition(newRaw.arena === rawNodeArena)
    // If we have a parent already, then ask our current parent to copy itself
    // recursively up to the root.
    if let parent {
      let parentData = parent.replacingChild(at: indexInParent, with: newRaw, rawNodeArena: rawNodeArena, allocationArena: allocationArena)
      let newParent = Syntax(parentData)
      return SyntaxData(absoluteRaw.replacingSelf(newRaw, newRootId: parentData.nodeId.rootId), parent: newParent)
    } else {
      // Otherwise, we're already the root, so return the new root data.
      return .forRoot(newRaw, rawNodeArena: rawNodeArena)
    }
  }

  /// Creates a copy of `self` with the child at the provided index replaced
  /// with a new SyntaxData containing the raw syntax provided.
  ///
  /// - Parameters:
  ///   - index: The index pointing to where in the raw layout to place this
  ///            child.
  ///   - newChild: The raw syntax for the new child to replace.
  ///   - newChildArena: The arena in which `newChild` resides.
  ///   - arena: The arena in which the new node will be allocated.
  /// - Returns: The new root node created by this operation, and the new child
  ///            syntax data.
  /// - SeeAlso: replacingSelf(_:)
  func replacingChild(at index: Int, with newChild: RawSyntax?, rawNodeArena: SyntaxArena?, allocationArena: SyntaxArena) -> SyntaxData {
    precondition(newChild?.arena === rawNodeArena || newChild == nil)
    // After newRaw has been allocated in `allocationArena`, `rawNodeArena` will
    // be a child arena of `allocationArena` and thus, `allocationArena` will
    // keep `newChild` alive.
    let newRaw = withExtendedLifetime(rawNodeArena) {
      raw.layoutView!.replacingChild(at: index, with: newChild, arena: allocationArena)
    }
    return replacingSelf(newRaw, rawNodeArena: allocationArena, allocationArena: allocationArena)
  }

  /// Identical to `replacingChild(at: Int, with: RawSyntax?, arena: SyntaxArena)`
  /// that ensures that the arena of`newChild` doesn’t get de-allocated before
  /// `newChild` has been addded to the result.
  func replacingChild(at index: Int, with newChild: SyntaxData?, arena: SyntaxArena) -> SyntaxData {
    return withExtendedLifetime(newChild) {
      return replacingChild(at: index, with: newChild?.raw, rawNodeArena: newChild?.raw.arena, allocationArena: arena)
    }
  }

  func withLeadingTrivia(_ leadingTrivia: Trivia, arena: SyntaxArena) -> SyntaxData {
    if let raw = raw.withLeadingTrivia(leadingTrivia, arena: arena) {
      return replacingSelf(raw, rawNodeArena: arena, allocationArena: arena)
    } else {
      return self
    }
  }

  func withTrailingTrivia(_ trailingTrivia: Trivia, arena: SyntaxArena) -> SyntaxData {
    if let raw = raw.withTrailingTrivia(trailingTrivia, arena: arena) {
      return replacingSelf(raw, rawNodeArena: arena, allocationArena: arena)
    } else {
      return self
    }
  }

  func withPresence(_ presence: SourcePresence, arena: SyntaxArena) -> SyntaxData {
    if let raw = raw.tokenView?.withPresence(presence, arena: arena) {
      return replacingSelf(raw, rawNodeArena: arena, allocationArena: arena)
    } else {
      return self
    }
  }
}

#if DEBUG
/// See `SyntaxMemoryLayout`.
var SyntaxDataMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "SyntaxData": .init(SyntaxData.self),
  "SyntaxData.Info": .init(SyntaxData.Info.self),
  "SyntaxData.Info.Root": .init(SyntaxData.Info.Root.self),
  "SyntaxData.Info.NonRoot": .init(SyntaxData.Info.NonRoot.self),
]
#endif
