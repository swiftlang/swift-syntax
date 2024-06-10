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

import LLOnDiskCAS

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
import _SwiftSyntaxCShims
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

  fileprivate var buffer: UnsafeMutableRawBufferPointer

  fileprivate let cas: LLOnDiskCAS

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
    self.buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 10485760, alignment: 4096)
    do {
      self.cas = try LLOnDiskCAS(path: "/Users/Jan/Desktop/CAS.noindex")
    } catch {
      fatalError("LLOnDiskCAS.init() \(error)")
    }
    self.childRefs = []
    #if DEBUG || SWIFTSYNTAX_ENABLE_ASSERTIONS
    self.hasParent = AtomicBool(initialValue: false)
    #endif
  }

  deinit {
    for child in childRefs {
      child.release()
    }
    buffer.deallocate()
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

  func appendToBuffer<T>(_ ptr: inout UnsafeMutableRawPointer, _ value: T) {
    ptr = ptr.alignedUp(for: T.self)
    ptr.storeBytes(of: value, as: T.self)
    ptr = ptr.advanced(by: MemoryLayout<T>.size)
  }

  func appendSyntaxTextToBuffer(_ ptr: inout UnsafeMutableRawPointer, _ value: SyntaxText) {
    appendToBuffer(&ptr, value.count)
    if let baseAddress = value.baseAddress {
      ptr.copyMemory(from: baseAddress, byteCount: value.count)
      ptr = ptr.advanced(by: value.count)
    } else {
      assert(value.count == 0)
    }
  }

  func readFromBuffer<T>(_ ptr: inout UnsafeRawPointer, _ type: T.Type) -> T {
    ptr = ptr.alignedUp(for: T.self)
    let value = ptr.load(as: T.self)
    ptr = ptr.advanced(by: MemoryLayout<T>.size)
    return value
  }

  func readSyntaxTextFromBuffer(_ ptr: inout UnsafeRawPointer) -> SyntaxText {
    let count = readFromBuffer(&ptr, Int.self)
    let buffer = ptr.bindMemory(to: UInt8.self, capacity: count)
    let text = SyntaxText(baseAddress: buffer, count: count)
    ptr = ptr.advanced(by: count)
    return value.intern(text)
  }

  func serialize(_ payload: RawSyntaxData.Payload) -> ObjectID {
    let begin = value.buffer.baseAddress!
    var ptr = value.buffer.baseAddress!

    switch payload {
    case .parsedToken(let token):
      appendToBuffer(&ptr, 0)
      appendToBuffer(&ptr, token.tokenKind)
      appendSyntaxTextToBuffer(&ptr, token.wholeText)
      appendToBuffer(&ptr, token.textRange.lowerBound)
      appendToBuffer(&ptr, token.textRange.upperBound)
      appendToBuffer(&ptr, token.presence)
      appendToBuffer(&ptr, token.tokenDiagnostic?.kind)
      appendToBuffer(&ptr, token.tokenDiagnostic?.byteOffset)
    case .materializedToken(let token):
      appendToBuffer(&ptr, 1)
      appendToBuffer(&ptr, token.tokenKind)
      appendSyntaxTextToBuffer(&ptr, token.tokenText)
      appendToBuffer(&ptr, token.triviaPieces.count)
      for triviaPiece in token.triviaPieces {
        switch triviaPiece {
        case .backslashes(let count):
          appendToBuffer(&ptr, 0)
          appendToBuffer(&ptr, count)
        case .blockComment(let text):
          appendToBuffer(&ptr, 1)
          appendSyntaxTextToBuffer(&ptr, text)
        case .carriageReturns(let count):
          appendToBuffer(&ptr, 2)
          appendToBuffer(&ptr, count)
        case .carriageReturnLineFeeds(let count):
          appendToBuffer(&ptr, 3)
          appendToBuffer(&ptr, count)
        case .docBlockComment(let text):
          appendToBuffer(&ptr, 4)
          appendSyntaxTextToBuffer(&ptr, text)
        case .docLineComment(let text):
          appendToBuffer(&ptr, 5)
          appendSyntaxTextToBuffer(&ptr, text)
        case .formfeeds(let count):
          appendToBuffer(&ptr, 6)
          appendToBuffer(&ptr, count)
        case .lineComment(let text):
          appendToBuffer(&ptr, 7)
          appendSyntaxTextToBuffer(&ptr, text)
        case .newlines(let count):
          appendToBuffer(&ptr, 8)
          appendToBuffer(&ptr, count)
        case .pounds(let count):
          appendToBuffer(&ptr, 9)
          appendToBuffer(&ptr, count)
        case .spaces(let count):
          appendToBuffer(&ptr, 10)
          appendToBuffer(&ptr, count)
        case .tabs(let count):
          appendToBuffer(&ptr, 11)
          appendToBuffer(&ptr, count)
        case .unexpectedText(let text):
          appendToBuffer(&ptr, 12)
          appendSyntaxTextToBuffer(&ptr, text)
        case .verticalTabs(let count):
          appendToBuffer(&ptr, 13)
          appendToBuffer(&ptr, count)
        }
      }
      appendToBuffer(&ptr, token.numLeadingTrivia)
      appendToBuffer(&ptr, token.byteLength)
      appendToBuffer(&ptr, token.presence)
      appendToBuffer(&ptr, token.tokenDiagnostic?.kind)
      appendToBuffer(&ptr, token.tokenDiagnostic?.byteOffset)
    case .layout(let layout):
      appendToBuffer(&ptr, 2)
      appendToBuffer(&ptr, layout.kind)
      appendToBuffer(&ptr, layout.layout.count)
      for child in layout.layout {
        appendToBuffer(&ptr, child?.rawData.objectID.opaque)
      }
      appendToBuffer(&ptr, layout.byteLength)
      appendToBuffer(&ptr, layout.descendantCount)
      appendToBuffer(&ptr, layout.recursiveFlags.rawValue)
    }

    do {
      return try value.cas.store(value.buffer[0..<(ptr - begin)])
    } catch {
      fatalError("SyntaxArena.serialize()")
    }
  }

  func deserialize(_ objectID: ObjectID) -> RawSyntaxData.Payload {
    do {
      let loadedObject = try value.cas.loadObject(objectID)
      return deserialize(loadedObject!.data)
    } catch {
      fatalError("SyntaxArenaRef.deserialize(ObjectID)")
    }
  }

  func deserialize(_ buffer: UnsafeRawBufferPointer) -> RawSyntaxData.Payload {
    var ptr = buffer.baseAddress!

    switch readFromBuffer(&ptr, Int.self) {
    case 0:
      let tokenKind = readFromBuffer(&ptr, RawTokenKind.self)
      let wholeText = readSyntaxTextFromBuffer(&ptr)
      let textRangeLowerBound = readFromBuffer(&ptr, Int.self)
      let textRangeUpperBound = readFromBuffer(&ptr, Int.self)
      let textRange = Range(uncheckedBounds: (SyntaxText.Index(textRangeLowerBound), SyntaxText.Index(textRangeUpperBound)))
      let presence = readFromBuffer(&ptr, SourcePresence.self)
      let diagnosticKind = readFromBuffer(&ptr, TokenDiagnostic.Kind?.self)
      let diagnosticOffset = readFromBuffer(&ptr, UInt16?.self)
      let tokenDiagnostic: TokenDiagnostic? = if let kind = diagnosticKind, let offset = diagnosticOffset {
        TokenDiagnostic(kind, byteOffset: offset)
      } else {
        nil
      }
      let parsedToken = RawSyntaxData.ParsedToken(tokenKind: tokenKind,
                                                  wholeText: wholeText,
                                                  textRange: textRange,
                                                  presence: presence,
                                                  tokenDiagnostic: tokenDiagnostic)
      return RawSyntaxData.Payload.parsedToken(parsedToken)
    case 1:
      let tokenKind = readFromBuffer(&ptr, RawTokenKind.self)
      let wholeText = readSyntaxTextFromBuffer(&ptr)
      let triviaPiecesCount = readFromBuffer(&ptr, Int.self)
      let triviaBuffer = value.allocateRawTriviaPieceBuffer(count: triviaPiecesCount)
      for i in 0..<triviaPiecesCount {
        triviaBuffer[i] = switch readFromBuffer(&ptr, Int.self) {
          case 0: RawTriviaPiece.backslashes(readFromBuffer(&ptr, Int.self))
          case 1: RawTriviaPiece.blockComment(readSyntaxTextFromBuffer(&ptr))
          case 2: RawTriviaPiece.carriageReturns(readFromBuffer(&ptr, Int.self))
          case 3: RawTriviaPiece.carriageReturnLineFeeds(readFromBuffer(&ptr, Int.self))
          case 4: RawTriviaPiece.docBlockComment(readSyntaxTextFromBuffer(&ptr))
          case 5: RawTriviaPiece.docLineComment(readSyntaxTextFromBuffer(&ptr))
          case 6: RawTriviaPiece.formfeeds(readFromBuffer(&ptr, Int.self))
          case 7: RawTriviaPiece.lineComment(readSyntaxTextFromBuffer(&ptr))
          case 8: RawTriviaPiece.newlines(readFromBuffer(&ptr, Int.self))
          case 9: RawTriviaPiece.pounds(readFromBuffer(&ptr, Int.self))
          case 10: RawTriviaPiece.spaces(readFromBuffer(&ptr, Int.self))
          case 11: RawTriviaPiece.tabs(readFromBuffer(&ptr, Int.self))
          case 12: RawTriviaPiece.unexpectedText(readSyntaxTextFromBuffer(&ptr))
          case 13: RawTriviaPiece.verticalTabs(readFromBuffer(&ptr, Int.self))
          default: fatalError("SyntaxArena.deserialize")
        }
      }
      let numLeadingTrivia = readFromBuffer(&ptr, UInt32.self)
      let byteLength = readFromBuffer(&ptr, UInt32.self)
      let presence = readFromBuffer(&ptr, SourcePresence.self)
      let diagnosticKind = readFromBuffer(&ptr, TokenDiagnostic.Kind?.self)
      let diagnosticOffset = readFromBuffer(&ptr, UInt16?.self)
      let tokenDiagnostic: TokenDiagnostic? = if let kind = diagnosticKind, let offset = diagnosticOffset {
        TokenDiagnostic(kind, byteOffset: offset)
      } else {
        nil
      }
      let materializedToken = RawSyntaxData.MaterializedToken(tokenKind: tokenKind,
                                                              tokenText: wholeText,
                                                              triviaPieces: RawTriviaPieceBuffer(UnsafeBufferPointer(triviaBuffer)),
                                                              numLeadingTrivia: numLeadingTrivia,
                                                              byteLength: byteLength,
                                                              presence: presence,
                                                              tokenDiagnostic: tokenDiagnostic)
      return RawSyntaxData.Payload.materializedToken(materializedToken)
    case 2:
      let kind = readFromBuffer(&ptr, SyntaxKind.self)
      let count = readFromBuffer(&ptr, Int.self)
      let buffer = value.allocateRawSyntaxBuffer(count: count)
      for i in 0..<count {
        if let opaqueObjectID = readFromBuffer(&ptr, UInt64?.self) {
          let deserializedPayload = deserialize(ObjectID(opaque: opaqueObjectID))
          let data = value.intern(RawSyntaxData(payload: deserializedPayload,
                                                objectID: ObjectID(opaque: opaqueObjectID),
                                                arenaReference: self))
          buffer[i] = RawSyntax(pointer: SyntaxArenaAllocatedPointer(data))
        } else {
          buffer[i] = nil
        }
      }
      let byteLength = readFromBuffer(&ptr, Int.self)
      let descendantCount = readFromBuffer(&ptr, Int.self)
      let recursiveFlagsRawValue = readFromBuffer(&ptr, UInt8.self)
      let layout = RawSyntaxData.Layout(kind: kind,
                                        layout: RawSyntaxBuffer(UnsafeBufferPointer(buffer)),
                                        byteLength: byteLength,
                                        descendantCount: descendantCount,
                                        recursiveFlags: RecursiveRawSyntaxFlags(rawValue: recursiveFlagsRawValue))
      return RawSyntaxData.Payload.layout(layout)
    default:
      fatalError("SyntaxArena.deserialize(UnsafeRawBufferPointer)")
    }
  }

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
