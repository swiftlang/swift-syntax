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

/// A Syntax node represents a tree of nodes with tokens at the leaves.
/// Each node has accessors for its known children, and allows efficient
/// iteration over the children through its `children` property.
public struct Syntax: SyntaxProtocol, SyntaxHashable {
  fileprivate enum Info: Sendable {
    case root(Root)
    indirect case nonRoot(NonRoot)

    // For root node.
    struct Root: Sendable {
      private var arena: RetainedSyntaxArena

      init(arena: RetainedSyntaxArena) {
        self.arena = arena
      }
    }

    // For non-root nodes.
    struct NonRoot: Sendable {
      var parent: Syntax
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

  private var root: Syntax {
    switch info {
    case .root(_): return self
    case .nonRoot(let info): return info.parent.root
    }
  }

  public var parent: Syntax? {
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

  public var id: SyntaxIdentifier {
    absoluteInfo.nodeId
  }

  /// The position of the start of this node's leading trivia
  public var position: AbsolutePosition {
    AbsolutePosition(utf8Offset: Int(absoluteInfo.offset))
  }

  /// The position of the start of this node's content, skipping its trivia
  public var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return position + raw.leadingTriviaLength
  }

  /// The end position of this node's content, before any trailing trivia.
  public var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return endPosition - raw.trailingTriviaLength
  }

  /// The end position of this node, including its trivia.
  public var endPosition: AbsolutePosition {
    position + raw.totalLength
  }

  /// "designated" memberwise initializer of `Syntax`.
  private init(_ raw: RawSyntax, info: Info) {
    self.raw = raw
    self.info = info
  }

  init(_ raw: RawSyntax, parent: Syntax, absoluteInfo: AbsoluteSyntaxInfo) {
    self.init(raw, info: .nonRoot(.init(parent: parent, absoluteInfo: absoluteInfo)))
  }

  /// Creates a `Syntax` with the provided raw syntax and parent.
  /// - Parameters:
  ///   - absoluteRaw: The underlying `AbsoluteRawSyntax` of this node.
  ///   - parent: The parent of this node, or `nil` if this node is the root.
  init(_ absoluteRaw: AbsoluteRawSyntax, parent: Syntax) {
    self.init(absoluteRaw.raw, parent: parent, absoluteInfo: absoluteRaw.info)
  }

  /// Creates a ``Syntax`` for a root raw node.
  ///
  /// - Parameters:
  ///   - raw: The raw node that will be the root of the tree
  ///   - rawNodeArena: The arena in which `raw` is allocated. It is passed to
  ///     make sure the arena doesn’t get de-allocated before the ``Syntax``
  ///     has a chance to retain it.
  static func forRoot(_ raw: RawSyntax, rawNodeArena: RetainedSyntaxArena) -> Syntax {
    precondition(rawNodeArena == raw.arenaReference)
    return Syntax(raw, info: .root(.init(arena: rawNodeArena)))
  }

  static func forRoot(_ raw: RawSyntax, rawNodeArena: SyntaxArena) -> Syntax {
    precondition(rawNodeArena == raw.arenaReference)
    return Syntax(raw, info: .root(.init(arena: RetainedSyntaxArena(rawNodeArena))))
  }

  /// Returns the child data at the provided index in this data's layout.
  /// - Note: This has O(n) performance, prefer using a proper Sequence type
  ///         if applicable, instead of this.
  /// - Note: This function traps if the index is out of the bounds of the
  ///         data's layout.
  ///
  /// - Parameter index: The index to create and cache.
  /// - Parameter parent: The parent to associate the child with. This is
  ///             normally the Syntax node that this `Syntax` belongs to.
  /// - Returns: The child's data at the provided index.
  func child(at index: Int) -> Syntax? {
    if raw.layoutView!.children[index] == nil { return nil }
    var iter = RawSyntaxChildren(absoluteRaw).makeIterator()
    for _ in 0..<index { _ = iter.next() }
    let (raw, info) = iter.next()!
    return Syntax(raw!, parent: self, absoluteInfo: info)
  }

  /// Creates a copy of `self` and recursively creates ``Syntax`` nodes up to
  /// the root.
  ///
  /// - Parameters:
  ///   - newRaw: The node that should replace `self`
  ///   - rawNodeArena: The arena in which `newRaw` resides
  ///   - allocationArena: The arena in which  new nodes should be allocated
  /// - Returns: A syntax tree with all parents where this node has been
  ///            replaced by `newRaw`
  func replacingSelf(_ newRaw: RawSyntax, rawNodeArena: RetainedSyntaxArena, allocationArena: SyntaxArena) -> Syntax {
    precondition(newRaw.arenaReference == rawNodeArena)
    // If we have a parent already, then ask our current parent to copy itself
    // recursively up to the root.
    if let parent {
      let newParent = parent.replacingChild(at: indexInParent, with: newRaw, rawNodeArena: rawNodeArena, allocationArena: allocationArena)
      return Syntax(absoluteRaw.replacingSelf(newRaw, newRootId: newParent.id.rootId), parent: newParent)
    } else {
      // Otherwise, we're already the root, so return the new root data.
      return .forRoot(newRaw, rawNodeArena: rawNodeArena)
    }
  }

  /// Creates a copy of `self` with the child at the provided index replaced
  /// with a new ``Syntax`` containing the raw syntax provided.
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
  func replacingChild(at index: Int, with newChild: RawSyntax?, rawNodeArena: RetainedSyntaxArena?, allocationArena: SyntaxArena) -> Syntax {
    precondition(newChild == nil || (rawNodeArena != nil && newChild!.arenaReference == rawNodeArena!))
    // After newRaw has been allocated in `allocationArena`, `rawNodeArena` will
    // be a child arena of `allocationArena` and thus, `allocationArena` will
    // keep `newChild` alive.
    let newRaw = withExtendedLifetime(rawNodeArena) {
      raw.layoutView!.replacingChild(at: index, with: newChild, arena: allocationArena)
    }
    return replacingSelf(newRaw, rawNodeArena: RetainedSyntaxArena(allocationArena), allocationArena: allocationArena)
  }

  /// Same as `replacingChild(at:with:rawNodeArena:allocationArena:)` but takes a `__SyntaxArena` instead of a `RetainedSyntaxArena`.
  func replacingChild(at index: Int, with newChild: RawSyntax?, rawNodeArena: SyntaxArena?, allocationArena: SyntaxArena) -> Syntax {
    return self.replacingChild(at: index, with: newChild, rawNodeArena: rawNodeArena.map(RetainedSyntaxArena.init), allocationArena: allocationArena)
  }

  /// Identical to `replacingChild(at: Int, with: RawSyntax?, arena: SyntaxArena)`
  /// that ensures that the arena of`newChild` doesn’t get de-allocated before
  /// `newChild` has been addded to the result.
  func replacingChild(at index: Int, with newChild: Syntax?, arena: SyntaxArena) -> Syntax {
    return withExtendedLifetime(newChild) {
      return replacingChild(at: index, with: newChild?.raw, rawNodeArena: newChild?.raw.arenaReference.retained, allocationArena: arena)
    }
  }

  func withLeadingTrivia(_ leadingTrivia: Trivia, arena: SyntaxArena) -> Syntax {
    if let raw = raw.withLeadingTrivia(leadingTrivia, arena: arena) {
      return replacingSelf(raw, rawNodeArena: RetainedSyntaxArena(arena), allocationArena: arena)
    } else {
      return self
    }
  }

  func withTrailingTrivia(_ trailingTrivia: Trivia, arena: SyntaxArena) -> Syntax {
    if let raw = raw.withTrailingTrivia(trailingTrivia, arena: arena) {
      return replacingSelf(raw, rawNodeArena: RetainedSyntaxArena(arena), allocationArena: arena)
    } else {
      return self
    }
  }

  func withPresence(_ presence: SourcePresence, arena: SyntaxArena) -> Syntax {
    if let raw = raw.tokenView?.withPresence(presence, arena: arena) {
      return replacingSelf(raw, rawNodeArena: RetainedSyntaxArena(arena), allocationArena: arena)
    } else {
      return self
    }
  }

  /// Needed for the conformance to ``SyntaxProtocol``.
  ///
  /// Needed for the conformance to ``SyntaxProtocol``. Just returns `self`.
  public var _syntaxNode: Syntax {
    return self
  }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, rawNodeArena: __shared RetainedSyntaxArena) {
    self = .forRoot(raw, rawNodeArena: rawNodeArena)
  }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, rawNodeArena: __shared SyntaxArena) {
    self = .forRoot(raw, rawNodeArena: RetainedSyntaxArena(rawNodeArena))
  }

  /// Create a ``Syntax`` node from a specialized syntax node.
  public init(_ syntax: some SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Creates a new ``Syntax`` node from any node that conforms to ``SyntaxProtocol``.
  public init(fromProtocol syntax: SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Same as ``init(fromProtocol:)`` but returns `nil` if `syntax` is `nil`.
  public init?(fromProtocol syntax: SyntaxProtocol?) {
    guard let syntax = syntax else { return nil }
    self = syntax._syntaxNode
  }

  /// Syntax nodes always conform to SyntaxProtocol. This API is just added
  /// for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: SyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: SyntaxProtocol.Protocol) -> SyntaxProtocol {
    return self.raw.kind.syntaxNodeType.init(self)!
  }

  /// Add the hash value of this node’s ID to `hasher`.
  public func hash(into hasher: inout Hasher) {
    return id.hash(into: &hasher)
  }

  /// Returns `true` if `rhs` and `lhs` have the same ID.
  ///
  /// Note `lhs` and `rhs` might have the same contents even if their IDs are
  /// different. See documentation on ``SyntaxIdentifier``.
  public static func == (lhs: Syntax, rhs: Syntax) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Syntax: Identifiable {
  /// ``SyntaxIdentifier`` uniquely identifies a node.
  public typealias ID = SyntaxIdentifier
}

extension Syntax {
  /// Enumerate all of the syntax text present in this node, and all
  /// of its children, to give a source-accurate view of the bytes.
  ///
  /// Unlike `description`, this provides a source-accurate representation
  /// even in the presence of malformed UTF-8 in the input source.
  ///
  /// The ``SyntaxText`` arguments passed to the visitor are only guaranteed
  /// to be valid within that call. It is unsafe to escape the `SyntaxValue`
  /// values outside of the closure.
  @_spi(RawSyntax)
  public func withEachSyntaxText(body: (SyntaxText) throws -> Void) rethrows {
    try raw.withEachSyntaxText(body: body)
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    return raw.syntaxTextBytes
  }
}

/// ``SyntaxNode`` used to be a pervasive type name in SwiftSyntax that has been
/// replaced by the ``Syntax`` type.
@available(*, unavailable, message: "use 'Syntax' instead")
public struct SyntaxNode {}

/// See `SyntaxMemoryLayout`.
let SyntaxMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "Syntax": .init(Syntax.self),
  "Syntax.Info": .init(Syntax.Info.self),
  "Syntax.Info.Root": .init(Syntax.Info.Root.self),
  "Syntax.Info.NonRoot": .init(Syntax.Info.NonRoot.self),
]
