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

/// An `UnsafePointer` pointing into memory that was allocated by a
/// ``SyntaxArena``.
///
/// Because the syntax arena will always outlive any syntax nodes that
/// reference its contents, we know that the pointer's contents won't get
/// deallocated while being accessed and thus we can add an unchecked `Sendable`
/// conformance.
@_spi(RawSyntax) public struct SyntaxArenaAllocatedPointer<Element: Sendable>: @unchecked Sendable {
  private let pointer: UnsafePointer<Element>

  /// Create a pointer from an `UnsafePointer` that was allocated inside a
  /// ``SyntaxArena``.
  ///
  /// - Important: The client needs to ensure sure that the buffer is indeed
  ///   allocated by a ``SyntaxArena`` and that the ``SyntaxArena`` will outlive
  ///   any users of this ``SyntaxArenaAllocatedBufferPointer``.
  init(_ buffer: UnsafePointer<Element>) {
    self.pointer = buffer
  }

  var pointee: Element {
    return pointer.pointee
  }

  var unsafeRawPointer: UnsafeRawPointer {
    return UnsafeRawPointer(pointer)
  }
}

/// An `UnsafeBufferPointer` pointing into memory that was allocated by a
/// ``SyntaxArena``.
///
/// Because the syntax arena will always outlive any syntax nodes that
/// reference its contents, we know that the buffer's contents won't get
/// deallocated while being accessed and thus we can add an unchecked `Sendable`
/// conformance.
@_spi(RawSyntax) public struct SyntaxArenaAllocatedBufferPointer<Element: Sendable>: RandomAccessCollection, @unchecked Sendable {
  private let buffer: UnsafeBufferPointer<Element>

  /// Create an empty buffer with no elements.
  init() {
    self.buffer = UnsafeBufferPointer(start: nil, count: 0)
  }

  /// Create a buffer pointer from an `UnsafeBufferPointer` that was allocated
  /// inside a ``SyntaxArena``.
  ///
  /// - Important: The client needs to ensure sure that the buffer is indeed
  ///   allocated by a ``SyntaxArena`` and that the ``SyntaxArena`` will outlive
  ///   any users of this ``SyntaxArenaAllocatedBufferPointer``.
  @_spi(RawSyntax) public init(_ buffer: UnsafeBufferPointer<Element>) {
    self.buffer = buffer
  }

  @_spi(RawSyntax) public subscript<RangeType: RangeExpression<Int>>(range: RangeType) -> SyntaxArenaAllocatedBufferPointer<Element> {
    return SyntaxArenaAllocatedBufferPointer(UnsafeBufferPointer(rebasing: self.buffer[range]))
  }

  @_spi(RawSyntax) public subscript(_ index: Int) -> Element {
    return self.buffer[index]
  }

  @_spi(RawSyntax) public func makeIterator() -> UnsafeBufferPointer<Element>.Iterator {
    return buffer.makeIterator()
  }

  public var startIndex: Int { buffer.startIndex }

  public var endIndex: Int { buffer.endIndex }

  public func index(after i: Int) -> Int {
    return buffer.index(after: i)
  }

  public func index(before i: Int) -> Int {
    return buffer.index(before: i)
  }

  public var count: Int {
    return buffer.count
  }

  public var isEmpty: Bool {
    return buffer.isEmpty
  }

  var baseAddress: UnsafePointer<Element>? {
    return buffer.baseAddress
  }

  var unsafeRawBufferPointer: UnsafeRawBufferPointer {
    return UnsafeRawBufferPointer(buffer)
  }
}
