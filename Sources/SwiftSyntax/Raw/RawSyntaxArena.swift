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

/// A syntax arena owns the memory for all syntax nodes within it.
///
/// The following is only relevant if you are accessing the raw syntax tree using
/// `RawSyntax` nodes. When working with syntax trees using SwiftSyntax’s API,
/// the usage of a ``RawSyntaxArena`` is transparent.
///
/// Contrary to Swift’s usual memory model, syntax node's are not individually
/// reference-counted. Instead, they live in an arena. That arena allocates a
/// chunk of memory at a time, which it can then use to store syntax nodes in.
/// This way, only a single memory allocation needs to be performed for multiple
/// syntax nodes and since memory allocations have a non-trivial cost, this
/// significantly speeds up parsing.
///
/// As a consequence, syntax nodes cannot be freed individually but the memory
/// will get freed once the owning ``RawSyntaxArena`` gets freed. Thus, it needs to
/// be manually ensured that the ``RawSyntaxArena`` is not deallocated while any
/// of its nodes are being accessed. The `SyntaxData` type ensures this as
/// follows:
/// - The root node has a strong reference to its ``RawSyntaxArena``
/// - Each node retains its parent `SyntaxData`, thus keeping it alive.
/// - If any node is allocated within a different ``RawSyntaxArena``,  that arena
///   is added to the root's `childRefs` property and thus kept a live as long
///   as the parent tree is alive.
///
/// As an added benefit of the ``RawSyntaxArena``, `RawSyntax` nodes don’t need to
/// be reference-counted, further improving the performance of ``SwiftSyntax``
/// when worked with at that level.
@_spi(RawSyntax)
public class RawSyntaxArena {
  /// Bump-pointer allocator for all "intern" methods.
  fileprivate let allocator: BumpPtrAllocator

  /// If the syntax tree that’s allocated in this arena references nodes from
  /// other arenas, `childRefs` contains references to the arenas. Child arenas
  /// are retained in `addChild()` and are released in `deinit`.
  private var childRefs: Set<RawSyntaxArenaRef>

  #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
  /// Whether or not this arena has been added to other arenas as a child.
  /// Used to make sure we don’t introduce retain cycles between arenas.
  ///
  /// - Important: This is only intended to be used for assertions to catch
  ///   retain cycles in syntax arenas.
  fileprivate let hasParent: UnsafeMutablePointer<AtomicBool>
  #endif

  /// Construct a new ``RawSyntaxArena`` in which syntax nodes can be allocated.
  public convenience init() {
    self.init(slabSize: 128)
  }

  fileprivate init(slabSize: Int) {
    self.allocator = BumpPtrAllocator(initialSlabSize: slabSize)
    self.childRefs = []
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    self.hasParent = swiftsyntax_atomic_bool_create(false)
    #endif
  }

  deinit {
    for child in childRefs {
      child.release()
    }
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    swiftsyntax_atomic_bool_destroy(self.hasParent)
    #endif
  }

  /// Allocates a buffer of `RawSyntax?` with the given count, then returns the
  /// uninitialized memory range as a `UnsafeMutableBufferPointer<RawSyntax?>`.
  func allocateRawSyntaxBuffer(count: Int) -> UnsafeMutableBufferPointer<RawSyntax?> {
    return allocator.allocate(RawSyntax?.self, count: count)
  }

  /// Allocates a buffer of ``RawTriviaPiece`` with the given count, then returns
  /// the uninitialized memory range as a `UnsafeMutableBufferPointer<RawTriviaPiece>`.
  func allocateRawTriviaPieceBuffer(
    count: Int
  ) -> UnsafeMutableBufferPointer<RawTriviaPiece> {
    return allocator.allocate(RawTriviaPiece.self, count: count)
  }

  /// Allocates a buffer of `UInt8` with the given count, then returns the
  /// uninitialized memory range as a `UnsafeMutableBufferPointer<UInt8>`.
  func allocateTextBuffer(count: Int) -> UnsafeMutableBufferPointer<UInt8> {
    return allocator.allocate(UInt8.self, count: count)
  }

  /// Copies the contents of a ``SyntaxText`` to the memory this arena manages,
  /// and return the ``SyntaxText`` in the destination.
  public func intern(_ value: SyntaxText) -> SyntaxText {
    // Return the passed-in value if it's already managed by this arena.
    if self.contains(text: value) {
      return value
    }

    let allocated = allocateTextBuffer(count: value.count)
    _ = allocated.initialize(from: value)
    return SyntaxText(baseAddress: allocated.baseAddress, count: allocated.count)
  }

  /// Copies a UTF8 sequence of `String` to the memory this arena manages, and
  /// returns the copied string as a ``SyntaxText``
  public func intern(_ value: String) -> SyntaxText {
    if value.isEmpty { return SyntaxText() }
    var value = value
    return value.withUTF8 { utf8 in
      let allocated = allocateTextBuffer(count: utf8.count)
      _ = allocated.initialize(from: utf8)
      return SyntaxText(baseAddress: allocated.baseAddress, count: utf8.count)
    }
  }

  /// Copies a `RawSyntaxData` to the memory this arena manages, and returns the
  /// pointer to the destination.
  func intern(_ value: RawSyntaxData) -> UnsafePointer<RawSyntaxData> {
    let allocated = allocator.allocate(RawSyntaxData.self, count: 1).baseAddress!
    allocated.initialize(to: value)
    return UnsafePointer(allocated)
  }

  /// Adds an ``RawSyntaxArena`` to this arena as a "child". Do nothing if `arenaRef`
  /// refers `self`.
  ///
  /// When an arena added to another arena, it's owned and is never released
  /// until the parent arena is deinitialized. This can be used when the syntax
  /// tree managed by this arena want to hold a subtree owned by other arena.
  /// See also `RawSyntax.layout()`.
  func addChild(_ otherRef: RawSyntaxArenaRef) {
    if RawSyntaxArenaRef(self) == otherRef { return }

    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    precondition(
      !swiftsyntax_atomic_bool_get(self.hasParent),
      "an arena can't have a new child once it's owned by other arenas"
    )
    #endif

    if childRefs.insert(otherRef).inserted {
      otherRef.retain()
      #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
      otherRef.setHasParent(true)
      #endif
    }
  }

  /// Checks if the given syntax text is managed by this arena.
  ///
  /// "managed" means it's empty, a part of "source buffer", or in the memory
  /// allocated by the underlying arena.
  func contains(text: SyntaxText) -> Bool {
    return (text.isEmpty || allocator.contains(address: text.baseAddress!))
  }
}

/// RawSyntaxArena for parsing.
@_spi(RawSyntax)
public class ParsingRawSyntaxArena: RawSyntaxArena {
  public typealias ParseTriviaFunction = (_ source: SyntaxText, _ position: TriviaPosition) -> [RawTriviaPiece]

  /// Source file buffer the Syntax tree represents.
  private var sourceBuffer: UnsafeBufferPointer<UInt8>

  /// Function to parse trivia.
  ///
  /// - Important: Must never be changed to a mutable value. See `RawSyntaxArenaRef.parseTrivia`.
  private let parseTriviaFunction: ParseTriviaFunction

  public init(parseTriviaFunction: @escaping ParseTriviaFunction) {
    self.sourceBuffer = .init(start: nil, count: 0)
    self.parseTriviaFunction = parseTriviaFunction
    super.init(slabSize: 4096)
  }

  /// Copies a source buffer in to the memory this arena manages, and returns
  /// the interned buffer.
  ///
  /// The interned buffer is guaranteed to be null-terminated.
  /// `contains(address _:)` is faster if the address is inside the memory
  /// range this function returned.
  public func internSourceBuffer(_ buffer: UnsafeBufferPointer<UInt8>) -> UnsafeBufferPointer<UInt8> {
    let allocated = allocator.allocate(
      UInt8.self,
      count: buffer.count + /* for NULL */ 1
    )
    precondition(sourceBuffer.baseAddress == nil, "SourceBuffer should only be set once.")
    _ = allocated.initialize(from: buffer)

    // NULL terminate.
    allocated.baseAddress!.advanced(by: buffer.count).initialize(to: 0)

    sourceBuffer = UnsafeBufferPointer(start: allocated.baseAddress!, count: buffer.count)
    return sourceBuffer
  }

  public override func contains(text: SyntaxText) -> Bool {
    if let addr = text.baseAddress, self.sourceBufferContains(addr) {
      return true
    }
    return super.contains(text: text)
  }

  /// Checks if the given memory address is inside the memory range returned
  /// from `internSourceBuffer(_:)` method.
  func sourceBufferContains(_ address: UnsafePointer<UInt8>) -> Bool {
    guard let sourceStart = sourceBuffer.baseAddress else { return false }
    return sourceStart <= address && address < sourceStart.advanced(by: sourceBuffer.count)
  }

  /// Parse `source` into a list of ``RawTriviaPiece`` using `parseTriviaFunction`.
  public func parseTrivia(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    // Must never access mutable state. See `RawSyntaxArenaRef.parseTrivia`.
    return self.parseTriviaFunction(source, position)
  }
}

/// An opaque wrapper around `RawSyntaxArena` that keeps the arena alive.
@_spi(RawSyntax)
public struct RetainedRawSyntaxArena: @unchecked Sendable {
  // Unchecked conformance to sendable is fine because `arena` is not
  // accessible. It is just used to keep the arena alive.
  private let arena: RawSyntaxArena

  init(_ arena: RawSyntaxArena) {
    self.arena = arena
  }

  fileprivate func arenaRef() -> RawSyntaxArenaRef {
    return RawSyntaxArenaRef(arena)
  }
}

/// Unsafely unowned reference to ``RawSyntaxArena``. The user is responsible to
/// maintain the lifetime of the ``RawSyntaxArena``.
///
/// `RawSyntaxData` holds its ``RawSyntaxArena`` in this form to prevent their cyclic
/// strong references. Also, passing around ``RawSyntaxArena`` in this form doesn't
/// cause any ref-counting traffic.
struct RawSyntaxArenaRef: Hashable, @unchecked Sendable {
  private let _value: Unmanaged<RawSyntaxArena>

  init(_ value: __shared RawSyntaxArena) {
    self._value = .passUnretained(value)
  }

  /// Returns the ``RawSyntaxArena``
  private var value: RawSyntaxArena {
    get { self._value.takeUnretainedValue() }
  }

  /// Assuming that this references a `ParsingRawSyntaxArena`,
  func parseTrivia(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    // It is safe to access `_value` here because `parseTrivia` only accesses
    // `parseTriviaFunction`, which is a constant.
    (value as! ParsingRawSyntaxArena).parseTrivia(source: source, position: position)
  }

  func retain() {
    _ = self._value.retain()
  }

  func release() {
    self._value.release()
  }

  /// Get an opaque wrapper that keeps the syntax arena alive.
  var retained: RetainedRawSyntaxArena {
    return RetainedRawSyntaxArena(value)
  }

  /// Copies a UTF8 sequence of `String` to the memory the referenced arena manages, and
  /// returns the copied string as a ``SyntaxText``
  func intern(_ value: String) -> SyntaxText {
    self.value.intern(value)
  }

  #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
  /// Accessor for the underlying's `RawSyntaxArena.hasParent`
  var hasParent: Bool {
    swiftsyntax_atomic_bool_get(value.hasParent)
  }

  /// Sets the `RawSyntaxArena.hasParent` on the referenced arena.
  func setHasParent(_ newValue: Bool) {
    swiftsyntax_atomic_bool_set(value.hasParent, newValue)
  }
  #endif

  func hash(into hasher: inout Hasher) {
    hasher.combine(_value.toOpaque())
  }

  static func == (lhs: RawSyntaxArenaRef, rhs: RawSyntaxArenaRef) -> Bool {
    return lhs._value.toOpaque() == rhs._value.toOpaque()
  }

  static func == (lhs: RawSyntaxArenaRef, rhs: __shared RawSyntaxArena) -> Bool {
    return lhs == RawSyntaxArenaRef(rhs)
  }

  static func == (lhs: __shared RawSyntaxArena, rhs: RawSyntaxArenaRef) -> Bool {
    return rhs == lhs
  }

  static func == (lhs: RawSyntaxArenaRef, rhs: RetainedRawSyntaxArena) -> Bool {
    return lhs == rhs.arenaRef()
  }

  static func == (lhs: RetainedRawSyntaxArena, rhs: RawSyntaxArenaRef) -> Bool {
    return rhs == lhs
  }
}
