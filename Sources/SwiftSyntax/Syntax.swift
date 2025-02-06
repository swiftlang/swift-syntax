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
@_implementationOnly private import _SwiftSyntaxCShims
#else
@_implementationOnly import _SwiftSyntaxCShims
#endif

// `Syntax` is a user facing tree wrapping `RawSyntax` tree. A value is a pair
// of strong reference to the `SyntaxDataArena` and a pointer to the `SyntaxData`
// allocated in the arena.
// The arena is shared between the all node in the tree, but only in the tree.
// Whenever the tree is modified, a new arena is created and it forms a new "tree".

/// A Syntax node represents a tree of nodes with tokens at the leaves.
/// Each node has accessors for its known children, and allows efficient
/// iteration over the children through its `children` property.
public struct Syntax: SyntaxProtocol, SyntaxHashable {
  let arena: SyntaxDataArena
  let dataRef: SyntaxDataReference

  /// "designated" memberwise initializer of `Syntax`.
  @_transparent  // Inline early to enable certain optimzation.
  init(arena: __shared SyntaxDataArena, dataRef: SyntaxDataReference) {
    self.arena = arena
    self.dataRef = dataRef
  }

  var data: SyntaxData {
    @_transparent unsafeAddress { dataRef.pointer }
  }

  @inline(__always)
  var raw: RawSyntax {
    data.raw
  }

  @inline(__always)
  public var root: Self {
    return Self(arena: arena, dataRef: arena.root)
  }

  @inline(__always)
  public var parent: Syntax? {
    guard let parentDataRef = data.parent else {
      return nil
    }
    return Syntax(arena: arena, dataRef: parentDataRef)
  }

  @inline(__always)
  public var hasParent: Bool {
    data.parent != nil
  }

  var absoluteInfo: AbsoluteSyntaxInfo {
    data.absoluteInfo
  }

  /// Index in parent's layout. `nil` slots are counted.
  var layoutIndexInParent: Int {
    Int(absoluteInfo.layoutIndexInParent)
  }

  public var id: SyntaxIdentifier {
    // This var is a workaround for a potential compiler bug (rdar://141977987)
    let rootDataRef = arena.root
    return SyntaxIdentifier(
      rootId: rootDataRef.pointee.raw.id,
      indexInTree: SyntaxIdentifier.SyntaxIndexInTree(indexInTree: absoluteInfo.indexInTree)
    )
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

  /// Creates a ``Syntax`` for a root raw node.
  ///
  /// - Parameters:
  ///   - raw: The raw node that will be the root of the tree
  ///   - rawNodeArena: The arena in which `raw` is allocated. It is passed to
  ///     make sure the arena doesn’t get de-allocated before the ``Syntax``
  ///     has a chance to retain it.
  static func forRoot(_ raw: RawSyntax, rawNodeArena: RetainedRawSyntaxArena) -> Syntax {
    precondition(rawNodeArena == raw.arenaReference)
    let arena = SyntaxDataArena(raw: raw, rawNodeArena: rawNodeArena)
    return Self(arena: arena, dataRef: arena.root)
  }

  static func forRoot(_ raw: RawSyntax, rawNodeArena: RawSyntaxArena) -> Syntax {
    return forRoot(raw, rawNodeArena: RetainedRawSyntaxArena(rawNodeArena))
  }

  /// References to the children data.
  ///
  /// - Note: The buffer is managed by the arena, and thus only valid while the arena is alive.
  var layoutBuffer: SyntaxDataReferenceBuffer {
    self.arena.layout(for: self.dataRef)
  }

  /// Returns the child node at the provided index in this node's layout.
  /// - Note: This function traps if the node is a token, or the index is out of the bounds of the layout.
  ///
  /// - Parameter index: The index to create and cache.
  /// - Returns: The child's node at the provided index.
  func child(at index: Int) -> Syntax? {
    let layoutBuffer = self.layoutBuffer
    guard let dataRef = layoutBuffer[index] else {
      return nil
    }
    return Self(arena: self.arena, dataRef: dataRef)
  }

  /// Creates a copy of `self` and recursively creates ``Syntax`` nodes up to
  /// the root.
  ///
  /// - Parameters:
  ///   - newRaw: The node that should replace `self`
  ///   - rawNodeArena: The arena in which `newRaw` resides
  ///   - rawAllocationArena: The arena in which  new nodes should be allocated
  /// - Returns: A syntax tree with all parents where this node has been
  ///            replaced by `newRaw`
  func replacingSelf(
    _ newRaw: RawSyntax,
    rawNodeArena: RetainedRawSyntaxArena,
    rawAllocationArena: RawSyntaxArena
  ) -> Syntax {
    precondition(newRaw.arenaReference == rawNodeArena)
    // If we have a parent already, then ask our current parent to copy itself
    // recursively up to the root.
    if let parent {
      let newParent = parent.replacingChild(
        at: layoutIndexInParent,
        with: newRaw,
        rawNodeArena: rawNodeArena,
        rawAllocationArena: rawAllocationArena
      )
      return newParent.child(at: layoutIndexInParent)!
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
  ///   - rawNodeArena: The arena in which `newChild` resides.
  ///   - rawAllocationArena: The arena in which the new node will be allocated.
  /// - Returns: The new root node created by this operation, and the new child
  ///            syntax data.
  /// - SeeAlso: replacingSelf(_:)
  func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    rawNodeArena: RetainedRawSyntaxArena?,
    rawAllocationArena: RawSyntaxArena
  ) -> Syntax {
    precondition(newChild == nil || (rawNodeArena != nil && newChild!.arenaReference == rawNodeArena!))
    // After newRaw has been allocated in `allocationArena`, `rawNodeArena` will
    // be a child arena of `allocationArena` and thus, `allocationArena` will
    // keep `newChild` alive.
    let newRaw = withExtendedLifetime(rawNodeArena) {
      raw.layoutView!.replacingChild(at: index, with: newChild, arena: rawAllocationArena)
    }
    return replacingSelf(
      newRaw,
      rawNodeArena: RetainedRawSyntaxArena(rawAllocationArena),
      rawAllocationArena: rawAllocationArena
    )
  }

  /// Same as `replacingChild(at:with:rawNodeArena:rawAllocationArena:)` but takes a `__RawSyntaxArena` instead of a `RetainedRawSyntaxArena`.
  func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    rawNodeArena: RawSyntaxArena?,
    rawAllocationArena: RawSyntaxArena
  ) -> Syntax {
    return self.replacingChild(
      at: index,
      with: newChild,
      rawNodeArena: rawNodeArena.map(RetainedRawSyntaxArena.init),
      rawAllocationArena: rawAllocationArena
    )
  }

  /// Identical to `replacingChild(at: Int, with: RawSyntax?, rawAllocationArena: RawSyntaxArena)`
  /// that ensures that the arena of`newChild` doesn’t get de-allocated before
  /// `newChild` has been addded to the result.
  func replacingChild(at index: Int, with newChild: Syntax?, rawAllocationArena: RawSyntaxArena) -> Syntax {
    return withExtendedLifetime(newChild) {
      return replacingChild(
        at: index,
        with: newChild?.raw,
        rawNodeArena: newChild?.raw.arenaReference.retained,
        rawAllocationArena: rawAllocationArena
      )
    }
  }

  func withLeadingTrivia(_ leadingTrivia: Trivia, rawAllocationArena: RawSyntaxArena) -> Syntax {
    if let raw = raw.withLeadingTrivia(leadingTrivia, arena: rawAllocationArena) {
      return replacingSelf(
        raw,
        rawNodeArena: RetainedRawSyntaxArena(rawAllocationArena),
        rawAllocationArena: rawAllocationArena
      )
    } else {
      return self
    }
  }

  func withTrailingTrivia(_ trailingTrivia: Trivia, rawAllocationArena: RawSyntaxArena) -> Syntax {
    if let raw = raw.withTrailingTrivia(trailingTrivia, arena: rawAllocationArena) {
      return replacingSelf(
        raw,
        rawNodeArena: RetainedRawSyntaxArena(rawAllocationArena),
        rawAllocationArena: rawAllocationArena
      )
    } else {
      return self
    }
  }

  func withPresence(_ presence: SourcePresence, rawAllocationArena: RawSyntaxArena) -> Syntax {
    if let raw = raw.tokenView?.withPresence(presence, arena: rawAllocationArena) {
      return replacingSelf(
        raw,
        rawNodeArena: RetainedRawSyntaxArena(rawAllocationArena),
        rawAllocationArena: rawAllocationArena
      )
    } else {
      return self
    }
  }

  func ancestorOrSelf<T>(mapping map: (Syntax) -> T?) -> T? {
    var dataRef = self.dataRef
    while true {
      if let mapped = map(Syntax(arena: self.arena, dataRef: dataRef)) {
        return mapped
      }
      guard let parent = dataRef.pointee.parent else {
        return nil
      }
      dataRef = parent
    }
  }

  /// Needed for the conformance to ``SyntaxProtocol``. Just returns `self`.
  public var _syntaxNode: Syntax {
    return self
  }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, rawNodeArena: __shared RetainedRawSyntaxArena) {
    self = .forRoot(raw, rawNodeArena: rawNodeArena)
  }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, rawNodeArena: __shared RawSyntaxArena) {
    self = .forRoot(raw, rawNodeArena: RetainedRawSyntaxArena(rawNodeArena))
  }

  /// Create a ``Syntax`` node from a specialized syntax node.
  // Inline always so the optimizer can optimize this to a member access on `syntax` without having to go through
  // generics.
  @_transparent
  public init(_ syntax: __shared some SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Creates a new ``Syntax`` node from any node that conforms to ``SyntaxProtocol``.
  public init(fromProtocol syntax: __shared SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Same as ``init(fromProtocol:)`` but returns `nil` if `syntax` is `nil`.
  public init?(fromProtocol syntax: __shared SyntaxProtocol?) {
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
  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    return raw.syntaxTextBytes
  }
}

typealias SyntaxDataReference = ArenaAllocatedPointer<SyntaxData>
typealias SyntaxDataReferenceBuffer = ArenaAllocatedBufferPointer<SyntaxDataReference?>

/// Node data for a `Syntax`, allocated and managed by `SyntaxDataArena`.
///
/// - Note: This type must be trivial as it is allocated by ‘BumpPtrAllocator’.
struct SyntaxData: Sendable {
  /// Underlying node of the `Syntax` node.
  let raw: RawSyntax
  /// Reference to the parent data. Or `nil` if this is the root.
  let parent: SyntaxDataReference?
  /// Index and position info in the tree.
  let absoluteInfo: AbsoluteSyntaxInfo
  /// Length of the children layout.
  /// This is a cached information, equals to `raw.layoutView?.children.count ?? 0`.
  /// This 4 bytes fits nicely after the 12 bytes `absoluteInfo`.
  let childCount: UInt32

  // If the childCount > 0, a pointer to the layout buffer (`UnsafePointer<SyntaxDataReference?>?`) is tail allocated.
}

/// `SyntaxDataArena` manages the entire data of a `Syntax` tree.
final class SyntaxDataArena: @unchecked Sendable {
  /// Mutex for locking the data when populating layout buffers.
  private let mutex: PlatformMutex

  /// Allocator.
  private let allocator: BumpPtrAllocator

  /// Retaining reference to the arena of the _root_ ``RawSyntax``
  private let rawArena: RetainedRawSyntaxArena

  /// Root node.
  let root: SyntaxDataReference

  init(raw: RawSyntax, rawNodeArena: RetainedRawSyntaxArena) {
    precondition(rawNodeArena == raw.arenaReference)

    self.mutex = PlatformMutex.create()
    self.allocator = BumpPtrAllocator(initialSlabSize: Self.slabSize(for: raw))
    self.rawArena = rawNodeArena
    self.root = Self.createDataImpl(allocator: allocator, raw: raw, parent: nil, absoluteInfo: .forRoot(raw))
  }

  deinit {
    // Debug print for re-evaluating `slabSize(for:)`
    // print("nodeCount: \(root.pointee.raw.totalNodes), slabSize: \(Self.slabSize(for: root.pointee.raw)), allocated: \(allocator.totalByteSizeAllocated), overflowed: \(Self.slabSize(for: root.pointee.raw) < allocator.totalByteSizeAllocated)")
    self.mutex.destroy()
  }

  /// Return the childen data of the given node.
  ///
  /// The layout buffer is created and cached when it's first accessed.
  func layout(for parent: SyntaxDataReference) -> SyntaxDataReferenceBuffer {
    let childCount = Int(truncatingIfNeeded: parent.pointee.childCount)

    // Return empty buffer for the node with no children.
    guard childCount != 0 else {
      return SyntaxDataReferenceBuffer()
    }

    // The storage of the buffer address is allocated next to the SyntaxData.
    let baseAddressRef = parent.advanced(by: 1)
      .unsafeRawPointer
      .assumingMemoryBound(to: AtomicPointer.self)

    // If the buffer is already populated, return it.
    if let baseAddress = swiftsyntax_atomic_pointer_get(baseAddressRef)?.assumingMemoryBound(
      to: SyntaxDataReference?.self
    ) {
      return SyntaxDataReferenceBuffer(UnsafeBufferPointer(start: baseAddress, count: childCount))
    }

    mutex.lock()
    defer { mutex.unlock() }

    // Recheck, maybe some other thread has populated the buffer during acquiring the lock.
    if let baseAddress = swiftsyntax_atomic_pointer_get(baseAddressRef)?.assumingMemoryBound(
      to: SyntaxDataReference?.self
    ) {
      return SyntaxDataReferenceBuffer(UnsafeBufferPointer(start: baseAddress, count: childCount))
    }

    let buffer = createLayoutDataImpl(parent)
    assert(buffer.count == childCount, "childCount doesn't match with RawSyntax layout length?")
    // Remeber the base address of the created buffer.
    swiftsyntax_atomic_pointer_set(
      UnsafeMutablePointer(mutating: baseAddressRef),
      UnsafeRawPointer(buffer.baseAddress)
    )

    return SyntaxDataReferenceBuffer(buffer)
  }

  /// Create the layout buffer of the node.
  private func createLayoutDataImpl(_ parent: SyntaxDataReference) -> UnsafeBufferPointer<SyntaxDataReference?> {
    let rawChildren = parent.pointee.raw.layoutView!.children
    let allocated = self.allocator.allocate(SyntaxDataReference?.self, count: rawChildren.count)

    var ptr = allocated.baseAddress!
    var absoluteInfo = parent.pointee.absoluteInfo.advancedToFirstChild()
    for raw in rawChildren {
      let dataRef: SyntaxDataReference?
      if let raw {
        dataRef = Self.createDataImpl(allocator: self.allocator, raw: raw, parent: parent, absoluteInfo: absoluteInfo)
      } else {
        dataRef = nil
      }
      ptr.initialize(to: dataRef)
      absoluteInfo = absoluteInfo.advancedBySibling(raw)
      ptr += 1
    }
    return UnsafeBufferPointer(allocated)
  }

  /// Calculate the recommended slab size of `BumpPtrAllocator`.
  ///
  /// Estimate the total allocation size assuming the client visits every node in
  /// the tree. Return the estimated size, or 4096 if it's larger than 4096.
  ///
  /// Each node consumes `SyntaxData` size at least. Non-empty layout node tail
  /// allocates a pointer storage for the base address of the layout buffer.
  ///
  /// For layout buffers, each child element consumes a `SyntaxDataReference` in
  /// the parent's layout. But non-collection layout nodes, the layout is usually
  /// sparse, so we can't calculate the exact memory size until we see the RawSyntax.
  /// That being said, `SytnaxData` + 4 pointer size looks like an enough estimation.
  private static func slabSize(for raw: RawSyntax) -> Int {
    let dataSize = MemoryLayout<SyntaxData>.stride
    let pointerSize = MemoryLayout<UnsafeRawPointer>.stride

    let nodeCount = raw.totalNodes
    assert(nodeCount != 0, "The tree needs to contain at least the root node")
    let totalSize = dataSize + (dataSize + pointerSize * 4) * (nodeCount &- 1)
    // Power of 2 might look nicer, but 'BumpPtrAllocator' doesn't require that.
    return min(totalSize, 4096)
  }

  /// Allocate and initialize `SyntaxData` with the trailing pointer storage for the references to the children.
  private static func createDataImpl(
    allocator: BumpPtrAllocator,
    raw: RawSyntax,
    parent: SyntaxDataReference?,
    absoluteInfo: AbsoluteSyntaxInfo
  ) -> SyntaxDataReference {
    let childCount = raw.layoutView?.children.count ?? 0

    // Allocate 'SyntaxData' + storage for the reference to the children data.
    // NOTE: If you change the memory layout, revisit 'slabSize(for:)' too.
    var totalSize = MemoryLayout<SyntaxData>.stride
    if childCount != 0 {
      // Tail allocate the storage for the pointer to the lazily allocated layout data.
      totalSize &+= MemoryLayout<AtomicPointer>.size
    }
    let alignment = MemoryLayout<SyntaxData>.alignment
    let allocated = allocator.allocate(byteCount: totalSize, alignment: alignment).baseAddress!

    // Initialize the data.
    let dataRef = allocated.bindMemory(to: SyntaxData.self, capacity: 1)
    dataRef.initialize(
      to: SyntaxData(
        raw: raw,
        parent: parent,
        absoluteInfo: absoluteInfo,
        childCount: UInt32(truncatingIfNeeded: childCount)
      )
    )

    if childCount != 0 {
      // Initialize the tail allocated storage with 'nil'.
      let layoutBufferBaseAddressRef =
        allocated
        .advanced(by: MemoryLayout<SyntaxData>.stride)
        .bindMemory(to: AtomicPointer.self, capacity: 1)
      swiftsyntax_atomic_pointer_set(layoutBufferBaseAddressRef, nil)
    }

    return SyntaxDataReference(UnsafePointer(dataRef))
  }
}

/// ``SyntaxNode`` used to be a pervasive type name in SwiftSyntax that has been
/// replaced by the ``Syntax`` type.
@available(*, unavailable, message: "use 'Syntax' instead")
public struct SyntaxNode {}

/// See `SyntaxMemoryLayout`.
let SyntaxMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "Syntax": .init(Syntax.self),
  "SyntaxData": .init(SyntaxData.self),
  "AbsoluteSyntaxInfo": .init(AbsoluteSyntaxInfo.self),
  "SyntaxDataReference?": .init(SyntaxDataReference?.self),
  "AtomicPointer": .init(AtomicPointer.self),
]
