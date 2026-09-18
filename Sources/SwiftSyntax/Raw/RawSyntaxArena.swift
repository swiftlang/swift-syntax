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

#if compiler(>=6) && RESILIENT_LIBRARIES
@_implementationOnly private import _SwiftSyntaxCShims
#elseif compiler(>=6) && !RESILIENT_LIBRARIES
private import _SwiftSyntaxCShims
#elseif !compiler(>=6) && RESILIENT_LIBRARIES
@_implementationOnly import _SwiftSyntaxCShims
#elseif !compiler(>=6) && !RESILIENT_LIBRARIES
import _SwiftSyntaxCShims
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
  /// - Note: `UnsafeMutableRawPointer` + casting accessor is a workaround to silence the warning 'cannot bypass resilience'.
  private let _hasParent: UnsafeMutableRawPointer
  fileprivate func hasParent() -> UnsafeMutablePointer<AtomicBool> {
    _hasParent.assumingMemoryBound(to: AtomicBool.self)
  }
  #endif

  /// Construct a new ``RawSyntaxArena`` in which syntax nodes can be allocated.
  public convenience init() {
    self.init(slabSize: 128)
  }

  fileprivate init(slabSize: Int) {
    self.allocator = BumpPtrAllocator(initialSlabSize: slabSize)
    self.childRefs = []
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    self._hasParent = UnsafeMutableRawPointer(swiftsyntax_atomic_bool_create(false))
    #endif
  }

  deinit {
    for child in childRefs {
      child.release()
    }
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    swiftsyntax_atomic_bool_destroy(self.hasParent())
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

  /// Allocates `byteCount` bytes for one node, aligned for a node's header and
  /// for anything its tail can hold, and returns the uninitialized memory.
  ///
  /// A node is a header followed by a tail whose shape and size depend on which
  /// of the three kinds of node it is, so its size is not a type's size.
  func allocateNode(byteCount: Int) -> UnsafeMutableRawPointer {
    return allocator.allocate(byteCount: byteCount, alignment: 8).baseAddress!
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
      !swiftsyntax_atomic_bool_get(self.hasParent()),
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

  /// Number of distinct arenas (this one plus retained child arenas) that the
  /// tree rooted in this arena keeps alive.
  public var retainedArenaCount: Int {
    var seen: Set<RawSyntaxArenaRef> = [RawSyntaxArenaRef(self)]
    var stack: [RawSyntaxArena] = [self]
    while let arena = stack.popLast() {
      for childRef in arena.childRefs where seen.insert(childRef).inserted {
        stack.append(childRef.value)
      }
    }
    return seen.count
  }
}

/// RawSyntaxArena for parsing.
@_spi(RawSyntax)
public class ParsingRawSyntaxArena: RawSyntaxArena {
  public typealias ParseTriviaFunction = (_ source: SyntaxText, _ position: TriviaPosition) -> [RawTriviaPiece]

  /// Function to parse trivia.
  ///
  /// - Important: Must never be changed to a mutable value. See `RawSyntaxArenaRef.parseTrivia`.
  private let parseTriviaFunction: ParseTriviaFunction

  /// The arena's own copy of the whole source buffer, made by
  /// `internSourceBuffer` for a full parse. `nil` for an incremental reparse,
  /// which does not copy the whole buffer. When set, the lexer runs over this
  /// copy, so a parsed token whose text lies within it is already arena-owned
  /// and `internParsedTokenText` returns it unchanged.
  private struct SourceCopy {
    let start: UnsafePointer<UInt8>
    let end: UnsafePointer<UInt8>
  }
  private var sourceCopy: SourceCopy?

  /// The size of slab to take when nothing is known about what will be
  /// allocated.
  private static let defaultSlabSize = 4096

  /// The largest slab to take, so that a large file does not ask the system for
  /// one enormous block.
  private static let maximumSlabSize = 4 << 20

  /// The size of slab to take while parsing a source file of `sourceByteCount`
  /// bytes.
  ///
  /// A full parse allocates roughly 26 times the source here, in nodes, text and
  /// trivia — measured between 19 and 28 times across the parser's own sources
  /// and the performance test inputs. A slab the size of the source therefore
  /// fills in about twenty allocations, where the 4 KB a parse starts with
  /// otherwise takes hundreds of them, doubling only every 128.
  ///
  /// Doubled up from the default rather than computed, so that a slab is always a
  /// power of two, and bounded at both ends: a small file is no worse off than it
  /// was, and what a large one wastes is bounded by one slab, measured at 4.4% of
  /// the memory a parse takes. Sizing the slab at twice the source instead saves
  /// no measurable time and wastes twice as much.
  private static func slabSize(forSourceOf sourceByteCount: Int) -> Int {
    var size = Self.defaultSlabSize
    while size < Self.maximumSlabSize, size < sourceByteCount {
      size *= 2
    }
    return size
  }

  /// - Parameter sourceByteCount: The size of the source that this arena will
  ///   hold a full parse of, if that is known, so that the slabs can be sized for
  ///   it. `nil` for an incremental reparse, where what gets allocated bears no
  ///   relation to the size of the source, and for any other use.
  public init(parseTriviaFunction: @escaping ParseTriviaFunction, sourceByteCount: Int? = nil) {
    self.parseTriviaFunction = parseTriviaFunction
    super.init(slabSize: sourceByteCount.map(Self.slabSize(forSourceOf:)) ?? Self.defaultSlabSize)
  }

  /// Copy the whole source buffer into this arena and return the copy, so the
  /// caller can lex over arena-owned memory. Parsed tokens then point directly
  /// into the copy and need no per-token interning, and the resulting tree is
  /// self-contained without referencing the caller's buffer.
  ///
  /// This suits a full parse, where every token's text is needed and the tree
  /// legitimately retains text the size of the source. It must not be used for
  /// an incremental reparse, where copying the whole buffer would defeat the
  /// point of reusing nodes; there, `internParsedTokenText` copies each
  /// re-lexed token individually instead.
  public func internSourceBuffer(_ buffer: UnsafeBufferPointer<UInt8>) -> UnsafeBufferPointer<UInt8> {
    guard buffer.count > 0 else {
      self.sourceCopy = nil
      return buffer
    }
    let dest = allocateTextBuffer(count: buffer.count)
    _ = dest.initialize(from: buffer)
    let copyBase = UnsafePointer(dest.baseAddress!)
    self.sourceCopy = SourceCopy(start: copyBase, end: copyBase + buffer.count)
    return UnsafeBufferPointer(dest)
  }

  /// Intern a parsed token's whole text so the resulting node owns its text and
  /// does not depend on the caller's source buffer.
  ///
  /// For a full parse the source was copied into the arena up front
  /// (`internSourceBuffer`), so a token whose text lies within that copy is
  /// already arena-owned and is returned unchanged. Otherwise — an incremental
  /// reparse, or text that is not part of the source buffer such as a
  /// synthesized token — the text is copied into the arena.
  func internParsedTokenText(_ text: SyntaxText) -> SyntaxText {
    guard let base = text.baseAddress, !text.isEmpty else {
      return text
    }
    if let sourceCopy, base >= sourceCopy.start, base + text.count <= sourceCopy.end {
      return text
    }
    let allocated = allocateTextBuffer(count: text.count)
    _ = allocated.initialize(from: text)
    return SyntaxText(baseAddress: allocated.baseAddress, count: allocated.count)
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

  /// Number of arenas (self + retained children) kept alive by this tree.
  public var retainedArenaCount: Int {
    arena.retainedArenaCount
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
  fileprivate var value: RawSyntaxArena {
    self._value.takeUnretainedValue()
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
    swiftsyntax_atomic_bool_get(value.hasParent())
  }

  /// Sets the `RawSyntaxArena.hasParent` on the referenced arena.
  func setHasParent(_ newValue: Bool) {
    swiftsyntax_atomic_bool_set(value.hasParent(), newValue)
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
