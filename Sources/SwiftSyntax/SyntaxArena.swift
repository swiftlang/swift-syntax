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

public typealias TriviaParserFunction = (_ triviaText: StringRef, _ isTrailing: Bool) -> [RawTriviaPiece]

public class SyntaxArena {
  private var allocator: BumpPtrAllocator
  private var children: Set<SyntaxArena>
  private var _sourceBuffer: UnsafeBufferPointer<UInt8>
  private var _triviaParser: TriviaParserFunction

  public init(triviaParser: @escaping TriviaParserFunction) {
    allocator = BumpPtrAllocator()
    children = []
    _sourceBuffer = .init(start: nil, count: 0)
    self._triviaParser = triviaParser
  }

  deinit {
    allocator.reset()
  }

  var totalSizeAllocated: Int { allocator.totalSizeAllocated }

  public func internSourceBuffer(_ buffer: UnsafeBufferPointer<UInt8>) -> UnsafeBufferPointer<UInt8> {
    let allocated = allocator.allocate(UInt8.self, count: buffer.count + /* for NULL */1)
    _ = allocated.initialize(from: buffer)

    // NULL terminate.
    allocated.baseAddress!.advanced(by: buffer.count).initialize(to: 0)

    _sourceBuffer = UnsafeBufferPointer(start: allocated.baseAddress!, count: buffer.count)
    return _sourceBuffer
  }

  func sourceBufferContains(_ pointer: UnsafePointer<UInt8>) -> Bool {
    guard let sourceStart = _sourceBuffer.baseAddress else { return false }
    return sourceStart <= pointer && pointer < sourceStart.advanced(by: _sourceBuffer.count)
  }

  func allocateRawSyntaxBuffer(count: Int) -> UnsafeMutableBufferPointer<RawSyntax?> {
    return allocator.allocate(RawSyntax?.self, count: count)
  }

  @_spi(RawSyntax)
  public func allocateRawTriviaPieceBuffer(count: Int) -> UnsafeMutableBufferPointer<RawTriviaPiece> {
    return allocator.allocate(RawTriviaPiece.self, count: count)
  }

  func allocateTextBuffer(count: Int) -> UnsafeMutableBufferPointer<UInt8> {
    return allocator.allocate(UInt8.self, count: count)
  }

  func intern(_ value: StringRef) -> StringRef {
    // Return the passed-in value if it's
    // * empty,
    // * a part of "source code", or
    // * alreay managed by this arena.
    if value.isEmpty || sourceBufferContains(value.baseAddress!) ||
        allocator.contains(address: value.baseAddress!) {
      return value
    }

    let allocated = allocator.allocate(UInt8.self, count: value.count)
    _ = allocated.initialize(from: value)
    return StringRef(baseAddress: allocated.baseAddress, count: allocated.count)
  }

  func intern(_ value: String) -> StringRef {
    if value.isEmpty { return StringRef() }
    let utf8 = value.utf8
    let allocated = allocator.allocate(UInt8.self, count: utf8.count)
    _ = allocated.initialize(from: utf8)
    return StringRef(baseAddress: allocated.baseAddress, count: utf8.count)
  }

  func intern(_ value: RawSyntaxData) -> UnsafePointer<RawSyntaxData> {
    let allocated = allocator.allocate(RawSyntaxData.self, count: 1).baseAddress!
    allocated.initialize(to: value)
    return UnsafePointer(allocated)
  }

  func addChild(_ child: SyntaxArena) {
    if self == child { return }
    children.insert(child)
  }

  func contains(address: UnsafeRawPointer) -> Bool {
    allocator.contains(address: address)
  }

  func parseTrivia(_ text: StringRef, isTrailing: Bool) -> [RawTriviaPiece] {
    return _triviaParser(text, isTrailing)
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

extension SyntaxArena {
  public static let `default` = SyntaxArena(triviaParser: _triviaParsingDisabled)
}

private func _triviaParsingDisabled(_ source: StringRef, _ isTrailing: Bool) -> [RawTriviaPiece] {
  fatalError("String trivia is not supported in 'default' arena.")
}
