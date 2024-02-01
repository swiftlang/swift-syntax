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

#if SWIFT_SYNTAX_BUILD_USING_CMAKE
// The CMake bulid of swift-syntax does not build the _AtomicBool module because swift-syntax's CMake build is
// Swift-only. Fake an `AtomicBool` type that is not actually atomic. This should be acceptable for the following
// reasons:
//  - `AtomicBool` is only used for the `hasParent` assertion, so release compilers don't rely on it
//  - The compiler is single-threaded so it it is safe from race conditions on `AtomicBool`.
fileprivate struct AtomicBool {
  var value: Bool

  init(initialValue: Bool) {
    self.value = initialValue
  }
}
#else
import _AtomicBool
#endif

/// A syntax arena owns the memory for all syntax nodes within it.
///
/// The following is only relevant if you are accessing the raw syntax tree using
/// `RawSyntax` nodes. When working with syntax trees using SwiftSyntax’s API,
/// the usage of a ``SyntaxArena`` is transparent.
///
/// Contrary to Swift’s usual memory model, syntax node's are not individually
/// reference-counted. Instead, they live in an arena. That arena allocates a
/// chunk of memory at a time, which it can then use to store syntax nodes in.
/// This way, only a single memory allocation needs to be performed for multiple
/// syntax nodes and since memory allocations have a non-trivial cost, this
/// significantly speeds up parsing.
///
/// As a consequence, syntax nodes cannot be freed individually but the memory
/// will get freed once the owning ``SyntaxArena`` gets freed. Thus, it needs to
/// be manually ensured that the ``SyntaxArena`` is not deallocated while any
/// of its nodes are being accessed. The `SyntaxData` type ensures this as
/// follows:
/// - The root node has a strong reference to its ``SyntaxArena``
/// - Each node retains its parent `SyntaxData`, thus keeping it alive.
/// - If any node is allocated within a different ``SyntaxArena``,  that arena
///   is added to the root's `childRefs` property and thus kept a live as long
///   as the parent tree is alive.
///
/// As an added benefit of the ``SyntaxArena``, `RawSyntax` nodes don’t need to
/// be reference-counted, further improving the performance of ``SwiftSyntax``
/// when worked with at that level.
public class SyntaxArena {
  /// Bump-pointer allocator for all "intern" methods.
  fileprivate let allocator: BumpPtrAllocator

  /// If the syntax tree that’s allocated in this arena references nodes from
  /// other arenas, `childRefs` contains references to the arenas. Child arenas
  /// are retained in `addChild()` and are released in `deinit`.
  private var childRefs: Set<SyntaxArenaRef>

  #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
  /// Whether or not this arena has been added to other arenas as a child.
  /// Used to make sure we don’t introduce retain cycles between arenas.
  ///
  /// - Important: This is only intended to be used for assertions to catch
  ///   retain cycles in syntax arenas.
  fileprivate var hasParent: AtomicBool
  #endif

  /// Construct a new ``SyntaxArena`` in which syntax nodes can be allocated.
  public convenience init() {
    self.init(slabSize: 128)
  }

  fileprivate init(slabSize: Int) {
    self.allocator = BumpPtrAllocator(initialSlabSize: slabSize)
    self.childRefs = []
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    self.hasParent = AtomicBool(initialValue: false)
    #endif
  }

  deinit {
    for child in childRefs {
      child.release()
    }
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
  @_spi(RawSyntax)
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
  @_spi(RawSyntax)
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

  /// Adds an ``SyntaxArena`` to this arena as a "child". Do nothing if `arenaRef`
  /// refers `self`.
  ///
  /// When an arena added to another arena, it's owned and is never released
  /// until the parent arena is deinitialized. This can be used when the syntax
  /// tree managed by this arena want to hold a subtree owned by other arena.
  /// See also `RawSyntax.layout()`.
  func addChild(_ otherRef: SyntaxArenaRef) {
    if SyntaxArenaRef(self) == otherRef { return }

    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    precondition(
      !self.hasParent.value,
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

/// SyntaxArena for parsing.
public class ParsingSyntaxArena: SyntaxArena {
  @_spi(RawSyntax)
  public typealias ParseTriviaFunction = (_ source: SyntaxText, _ position: TriviaPosition) -> [RawTriviaPiece]

  /// Source file buffer the Syntax tree represents.
  private var sourceBuffer: UnsafeBufferPointer<UInt8>

  /// Function to parse trivia.
  ///
  /// - Important: Must never be changed to a mutable value. See `SyntaxArenaRef.parseTrivia`.
  private let parseTriviaFunction: ParseTriviaFunction

  @_spi(RawSyntax)
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
  @_spi(RawSyntax)
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

  @_spi(RawSyntax)
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
  @_spi(RawSyntax)
  public func parseTrivia(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    // Must never access mutable state. See `SyntaxArenaRef.parseTrivia`.
    return self.parseTriviaFunction(source, position)
  }
}

/// An opaque wrapper around `SyntaxArena` that keeps the arena alive.
@_spi(RawSyntax)
public struct RetainedSyntaxArena: @unchecked Sendable {
  // Unchecked conformance to sendable is fine because `arena` is not
  // accessible. It is just used to keep the arena alive.
  private let arena: SyntaxArena

  init(_ arena: SyntaxArena) {
    self.arena = arena
  }

  fileprivate func arenaRef() -> SyntaxArenaRef {
    return SyntaxArenaRef(arena)
  }
}

/// Unsafely unowned reference to ``SyntaxArena``. The user is responsible to
/// maintain the lifetime of the ``SyntaxArena``.
///
/// `RawSyntaxData` holds its ``SyntaxArena`` in this form to prevent their cyclic
/// strong references. Also, passing around ``SyntaxArena`` in this form doesn't
/// cause any ref-counting traffic.
struct SyntaxArenaRef: Hashable, @unchecked Sendable {
  private let _value: Unmanaged<SyntaxArena>

  init(_ value: __shared SyntaxArena) {
    self._value = .passUnretained(value)
  }

  /// Returns the ``SyntaxArena``
  private var value: SyntaxArena {
    get { self._value.takeUnretainedValue() }
  }

  /// Assuming that this references a `ParsingSyntaxArena`,
  func parseTrivia(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    // It is safe to access `_value` here because `parseTrivia` only accesses
    // `parseTriviaFunction`, which is a constant.
    (value as! ParsingSyntaxArena).parseTrivia(source: source, position: position)
  }

  func retain() {
    _ = self._value.retain()
  }

  func release() {
    self._value.release()
  }

  /// Get an opaque wrapper that keeps the syntax arena alive.
  var retained: RetainedSyntaxArena {
    return RetainedSyntaxArena(value)
  }

  #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
  /// Accessor for ther underlying's `SyntaxArena.hasParent`
  var hasParent: Bool {
    value.hasParent.value
  }

  /// Sets the `SyntaxArena.hasParent` on the referenced arena.
  func setHasParent(_ newValue: Bool) {
    value.hasParent.value = newValue
  }
  #endif

  func hash(into hasher: inout Hasher) {
    hasher.combine(_value.toOpaque())
  }

  static func == (lhs: SyntaxArenaRef, rhs: SyntaxArenaRef) -> Bool {
    return lhs._value.toOpaque() == rhs._value.toOpaque()
  }

  static func == (lhs: SyntaxArenaRef, rhs: __shared SyntaxArena) -> Bool {
    return lhs == SyntaxArenaRef(rhs)
  }

  static func == (lhs: __shared SyntaxArena, rhs: SyntaxArenaRef) -> Bool {
    return rhs == lhs
  }

  static func == (lhs: SyntaxArenaRef, rhs: RetainedSyntaxArena) -> Bool {
    return lhs == rhs.arenaRef()
  }

  static func == (lhs: RetainedSyntaxArena, rhs: SyntaxArenaRef) -> Bool {
    return rhs == lhs
  }
}
