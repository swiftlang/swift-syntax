//===-------- SyntaxArena.swift - RawSyntaxData Memory Management  --------===//
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

public class SyntaxArena {
  /// Bump-pointer allocator for all "intern" methods.
  private var allocator: BumpPtrAllocator
  /// Source file buffer the Syntax tree represents.
  private var sourceBuffer: UnsafeBufferPointer<UInt8>

  /// If the syntax tree that’s allocated in this arena references nodes from
  /// other arenas, `children` contains those arenas to keep them alive.
  private var children: Set<SyntaxArena>
  /// Whether or not this arena has been added to other arenas as a child.
  /// Used to make sure we don’t introduce retain cycles between arenas.
  private var hasParent: Bool

  public init() {
    allocator = BumpPtrAllocator()
    children = []
    sourceBuffer = .init(start: nil, count: 0)
    hasParent = false
  }

  /// Copies a source buffer in to the memory this arena manages, and returns
  /// the interned buffer.
  ///
  /// `contains(address _:)` is faster if the address is inside the memory
  /// range this function returned.
  public func internSourceBuffer(_ buffer: UnsafeBufferPointer<UInt8>) -> UnsafeBufferPointer<UInt8> {
    precondition(sourceBuffer.baseAddress == nil, "SourceBuffer should only be set once.")
    let allocated = allocator.allocate(UInt8.self, count: buffer.count)
    _ = allocated.initialize(from: buffer)
    sourceBuffer = UnsafeBufferPointer(start: allocated.baseAddress, count: buffer.count)
    return sourceBuffer
  }

  /// Checks if the given memory address is inside the memory range returned
  /// from `internSourceBuffer(_:)` method.
  func sourceBufferContains(_ address: UnsafePointer<UInt8>) -> Bool {
    guard let sourceStart = sourceBuffer.baseAddress else { return false }
    return sourceStart <= address && address < sourceStart.advanced(by: sourceBuffer.count)
  }

  /// Allocates a buffer of `RawSyntax?` with the given count, then returns the
  /// uninitlialized memory range as a `UnsafeMutableBufferPointer<RawSyntax?>`.
  func allocateRawSyntaxBuffer(count: Int) -> UnsafeMutableBufferPointer<RawSyntax?> {
    return allocator.allocate(RawSyntax?.self, count: count)
  }

  /// Allcates a buffer of `RawTriviaPiece` with the given count, then returns
  /// the uninitialized memory range as a `UnsafeMutableBufferPointer<RawTriviaPiece>`.
  func allocateRawTriviaPieceBuffer(
    count: Int) -> UnsafeMutableBufferPointer<RawTriviaPiece> {
      return allocator.allocate(RawTriviaPiece.self, count: count)
    }

  /// Allcates a buffer of `UInt8` with the given count, then returns the
  /// uninitialized memory range as a `UnsafeMutableBufferPointer<UInt8>`.
  func allocateTextBuffer(count: Int) -> UnsafeMutableBufferPointer<UInt8> {
    return allocator.allocate(UInt8.self, count: count)
  }

  /// Copies the contents of a `SyntaxText` to the memory this arena manages,
  /// and return the `SyntaxText` in the destiation.
  func intern(_ value: SyntaxText) -> SyntaxText {
    // Return the passed-in value if it's
    // * empty,
    // * a part of "source buffer", or
    // * in the memory allocated by this arena
    if (value.isEmpty || sourceBufferContains(value.baseAddress!) ||
        allocator.contains(address: value.baseAddress!)) {
      return value
    }

    let allocated = allocateTextBuffer(count: value.count)
    _ = allocated.initialize(from: value)
    return SyntaxText(baseAddress: allocated.baseAddress, count: allocated.count)
  }

  /// Copies a UTF8 sequence of `String` to the memory this arena manages, and
  /// returns the copied string as a `SyntaxText`
  func intern(_ value: String) -> SyntaxText {
    if value.isEmpty { return SyntaxText() }
    var value = value
    return value.withUTF8 { utf8 in
      let allocated = allocateTextBuffer(count: utf8.count)
      _ = allocated.initialize(from: utf8)
      return SyntaxText(baseAddress: allocated.baseAddress, count: utf8.count)
    }
  }

  /// Copies a `RawSyntaxData` to the memory this arena manages, and retuns the
  /// pointer to the destination.
  func intern(_ value: RawSyntaxData) -> UnsafePointer<RawSyntaxData> {
    let allocated = allocator.allocate(RawSyntaxData.self, count: 1).baseAddress!
    allocated.initialize(to: value)
    return UnsafePointer(allocated)
  }

  /// Adds an `SyntaxArena` to this arena as a "child". Do nothing if `arenaRef`
  /// refers `self`.
  ///
  /// When an arena added to another arena, it's owned and is never released
  /// until the parent arena is deinitialized. This can be used when the syntax
  /// tree managed by this arena want to hold a subtree owned by other arena.
  /// See also `RawSyntax.layout()`.
  func addChild(_ arenaRef: SyntaxArenaRef) {
    if SyntaxArenaRef(self) == arenaRef { return }

    let other = arenaRef.value

    precondition(
      !self.hasParent,
      "an arena can't have a new child once it's owned by other arenas")
    // `precondition(!self.hasParent)` should be sufficient to make sure we
    // don’t add retain cycles between syntax arenas, but to be doubly sure,
    // check the child arenas as well in debug builds.
    assert(!other.contains(arena: self), "cyclic arena hierarchy detected")

    other.hasParent = true
    children.insert(other)
  }

  /// Recursively checks if this arena contains given `arena` as a descendant.
  func contains(arena: SyntaxArena) -> Bool {
    return children.contains { child in
      child === arena  || child.contains(arena: arena)
    }
  }
}

extension SyntaxArena: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
  public static func ==(lhs: SyntaxArena, rhs: SyntaxArena) -> Bool {
    return lhs === rhs
  }
}

/// Unsafely unowned reference to `SyntaxArena`. The user is responsible to
/// maintain the lifetime of the `SyntaxArena`.
///
/// `RawSyntaxData` holds its `SyntaxArena` in this form to prevent their cyclic
/// strong references. Also, passing around `SyntaxArena` in this form doesn't
/// cause any ref-counting traffic.
struct SyntaxArenaRef: Equatable {
  private unowned(unsafe) var _value: SyntaxArena

  init(_ value: __shared SyntaxArena) {
    self._value = value
  }

  /// Returns the `SyntaxArena`
  var value: SyntaxArena {
    get { self._value }
  }

  static func ==(lhs: SyntaxArenaRef, rhs: SyntaxArenaRef) -> Bool {
    return lhs._value === rhs._value
  }
}

extension SyntaxArena {
  // FIXME: This is only for migration. All clients should move to "arena" model.
  //@available(*, deprecated, message: ".default SyntaxArena is subject to remove soon")
  public static let `default` = SyntaxArena()
}
