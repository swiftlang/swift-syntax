//===----------------------------------------------------------------------===//
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
  fileprivate let allocator: BumpPtrAllocator

  /// If the syntax tree that’s allocated in this arena references nodes from
  /// other arenas, `childRefs` contains references to the arenas. Child arenas
  /// are retained in `addChild()` and are released in `deinit`.
  private var childRefs: Set<SyntaxArenaRef>

  #if DEBUG
  /// Whether or not this arena has been added to other arenas as a child.
  /// Used to make sure we don’t introduce retain cycles between arenas.
  private var hasParent: Bool
  #endif

  public convenience init() {
    self.init(slabSize: 128)
  }

  fileprivate init(slabSize: Int) {
    self.allocator = BumpPtrAllocator(slabSize: slabSize)
    self.childRefs = []
    #if DEBUG
    self.hasParent = false
    #endif
  }

  deinit {
    for child in childRefs {
      child.release()
    }
  }

  /// Allocates a buffer of `RawSyntax?` with the given count, then returns the
  /// uninitlialized memory range as a `UnsafeMutableBufferPointer<RawSyntax?>`.
  func allocateRawSyntaxBuffer(count: Int) -> UnsafeMutableBufferPointer<RawSyntax?> {
    return allocator.allocate(RawSyntax?.self, count: count)
  }

  /// Allcates a buffer of `RawTriviaPiece` with the given count, then returns
  /// the uninitialized memory range as a `UnsafeMutableBufferPointer<RawTriviaPiece>`.
  func allocateRawTriviaPieceBuffer(
    count: Int
  ) -> UnsafeMutableBufferPointer<RawTriviaPiece> {
    return allocator.allocate(RawTriviaPiece.self, count: count)
  }

  /// Allcates a buffer of `UInt8` with the given count, then returns the
  /// uninitialized memory range as a `UnsafeMutableBufferPointer<UInt8>`.
  func allocateTextBuffer(count: Int) -> UnsafeMutableBufferPointer<UInt8> {
    return allocator.allocate(UInt8.self, count: count)
  }

  /// Copies the contents of a `SyntaxText` to the memory this arena manages,
  /// and return the `SyntaxText` in the destiation.
  @_spi(RawSyntax)
  public func intern(_ value: SyntaxText) -> SyntaxText {
    // Return the passed-in value if it's already managed by this arena.
    if (self.contains(text: value)) {
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
  func addChild(_ otherRef: SyntaxArenaRef) {
    if SyntaxArenaRef(self) == otherRef { return }

    #if DEBUG
    precondition(
      !self.hasParent,
      "an arena can't have a new child once it's owned by other arenas"
    )
    #endif

    if childRefs.insert(otherRef).inserted {
      otherRef.retain()
      #if DEBUG
      // FIXME: This may trigger a data race warning in Thread Sanitizer.
      // Can we use atomic bool here?
      otherRef.value.hasParent = true
      #endif
    }
  }

  /// Recursively checks if this arena contains given `arenaRef` as a descendant.
  func contains(arenaRef: SyntaxArenaRef) -> Bool {
    childRefs.contains { childRef in
      childRef == arenaRef || childRef.value.contains(arenaRef: arenaRef)
    }
  }

  /// Checks if the given syntax text is managed by this arena.
  ///
  /// "managed" means it's empty, a part of "source buffer", or in the memory
  /// allocated by the underlying arena.
  @_spi(RawSyntax)
  public func contains(text: SyntaxText) -> Bool {
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
  private var parseTriviaFunction: ParseTriviaFunction

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

  /// Parse `source` into a list of `RawTriviaPiece` using `parseTriviaFunction`.
  @_spi(RawSyntax)
  public func parseTrivia(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    return self.parseTriviaFunction(source, position)
  }
}

/// Unsafely unowned reference to `SyntaxArena`. The user is responsible to
/// maintain the lifetime of the `SyntaxArena`.
///
/// `RawSyntaxData` holds its `SyntaxArena` in this form to prevent their cyclic
/// strong references. Also, passing around `SyntaxArena` in this form doesn't
/// cause any ref-counting traffic.
struct SyntaxArenaRef: Hashable {
  private let _value: Unmanaged<SyntaxArena>

  init(_ value: __shared SyntaxArena) {
    self._value = .passUnretained(value)
  }

  /// Returns the `SyntaxArena`
  var value: SyntaxArena {
    get { self._value.takeUnretainedValue() }
  }

  func retain() {
    _ = self._value.retain()
  }

  func release() {
    self._value.release()
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(_value.toOpaque())
  }

  static func == (lhs: SyntaxArenaRef, rhs: SyntaxArenaRef) -> Bool {
    return lhs._value.toOpaque() == rhs._value.toOpaque()
  }
}
